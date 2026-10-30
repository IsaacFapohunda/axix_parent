
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fees_data.dart';

final feesControllerProvider =
ChangeNotifierProvider<FeesController>((ref) {
  return FeesController();
});

class FeesController extends ChangeNotifier {
  final List<FeeInvoice> invoices = [
    FeeInvoice(
      id: 'INV-2041',
      title: 'First term tuition',
      description: 'First term tuition fee',
      studentName: 'Adaeze Nwosu',
      amount: 250000,
      amountPaid: 100000,
      dueDate: DateTime(2026, 4, 30),
    ),
    FeeInvoice(
      id: 'INV-2042',
      title: 'School bus (per term)',
      description: 'Transportation fee',
      studentName: 'Adaeze Nwosu',
      amount: 55000,
      dueDate: DateTime(2026, 4, 30),
    ),
    FeeInvoice(
      id: 'INV-2043',
      title: 'Exam levy',
      description: 'Examination fee',
      studentName: 'Adaeze Nwosu',
      amount: 30000,
      dueDate: DateTime(2026, 4, 30),
    ),
  ];

  final List<FeeReceipt> receipts = [];

  final List<WalletTransaction> walletTransactions = [];

  double walletBalance = 62500;

  String paymentMethod = 'Card';

  FeeInvoice? selectedInvoice;

  final Set<String> selectedInvoiceIds = {};

  double get totalFees {
    return invoices.fold(0, (sum, invoice) => sum + invoice.amount);
  }

  double get totalPaid {
    return invoices.fold(0, (sum, invoice) => sum + invoice.amountPaid);
  }

  double get totalOutstanding {
    return invoices.fold(
      0,
          (sum, invoice) => sum + invoice.outstanding,
    );
  }

  double get selectedOutstanding {
    return invoices
        .where((invoice) => selectedInvoiceIds.contains(invoice.id))
        .fold(0, (sum, invoice) => sum + invoice.outstanding);
  }

  int get paidInvoiceCount {
    return invoices.where((invoice) => invoice.status == 'Paid').length;
  }

  void selectInvoice(FeeInvoice invoice) {
    selectedInvoice = invoice;
    notifyListeners();
  }

  void selectAllOutstandingInvoices() {
    selectedInvoiceIds
      ..clear()
      ..addAll(
        invoices
            .where((invoice) => invoice.outstanding > 0)
            .map((invoice) => invoice.id),
      );

    notifyListeners();
  }

  void toggleInvoiceSelection(String invoiceId) {
    if (selectedInvoiceIds.contains(invoiceId)) {
      selectedInvoiceIds.remove(invoiceId);
    } else {
      selectedInvoiceIds.add(invoiceId);
    }

    notifyListeners();
  }

  void clearInvoiceSelection() {
    selectedInvoiceIds.clear();
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    paymentMethod = method;
    notifyListeners();
  }

  void payInvoice(FeeInvoice invoice, double amount) {
    final payment = amount.clamp(0.0, invoice.outstanding).toDouble();

    if (payment <= 0) return;

    invoice.amountPaid += payment;

    receipts.insert(
      0,
      FeeReceipt(
        id: 'RCP-${DateTime.now().millisecondsSinceEpoch}',
        invoiceId: invoice.id,
        title: invoice.title,
        amount: payment,
        method: paymentMethod,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void paySelectedInvoices() {
    for (final invoice in invoices) {
      if (selectedInvoiceIds.contains(invoice.id)) {
        payInvoice(invoice, invoice.outstanding);
      }
    }

    selectedInvoiceIds.clear();
    notifyListeners();
  }

  void payFromWallet(FeeInvoice invoice, double amount) {
    final payment = amount.clamp(
      0.0,
      invoice.outstanding < walletBalance
          ? invoice.outstanding
          : walletBalance,
    ).toDouble();

    if (payment <= 0) return;

    walletBalance -= payment;

    walletTransactions.insert(
      0,
      WalletTransaction(
        title: invoice.title,
        description: 'School fee payment',
        amount: payment,
        isCredit: false,
        date: DateTime.now(),
      ),
    );

    setPaymentMethod('Axix wallet');
    payInvoice(invoice, payment);
  }

  void topUpWallet(double amount) {
    if (amount <= 0) return;

    walletBalance += amount;

    walletTransactions.insert(
      0,
      WalletTransaction(
        title: 'Wallet top up',
        description: 'Wallet funding',
        amount: amount,
        isCredit: true,
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}