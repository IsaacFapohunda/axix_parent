
class FeeInvoice {
  final String id;
  final String title;
  final String description;
  final String studentName;
  final double amount;
  double amountPaid;
  final DateTime dueDate;

  FeeInvoice({
    required this.id,
    required this.title,
    required this.description,
    required this.studentName,
    required this.amount,
    this.amountPaid = 0,
    required this.dueDate,
  });

  double get outstanding => amount - amountPaid;

  String get status {
    if (amountPaid >= amount) return 'Paid';
    if (amountPaid > 0) return 'Part paid';
    return 'Unpaid';
  }
}

class FeeReceipt {
  final String id;
  final String invoiceId;
  final String title;
  final double amount;
  final String method;
  final DateTime date;

  FeeReceipt({
    required this.id,
    required this.invoiceId,
    required this.title,
    required this.amount,
    required this.method,
    required this.date,
  });
}

class WalletTransaction {
  final String title;
  final String description;
  final double amount;
  final bool isCredit;
  final DateTime date;

  WalletTransaction({
    required this.title,
    required this.description,
    required this.amount,
    required this.isCredit,
    required this.date,
  });
}