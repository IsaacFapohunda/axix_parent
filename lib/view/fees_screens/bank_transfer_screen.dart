
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'payment_pending_screen.dart';

class BankTransferScreen extends StatelessWidget {
  final double amount;
  final FeeInvoice? invoice;
  final bool payAll;

  const BankTransferScreen({
    super.key,
    required this.amount,
    this.invoice,
    this.payAll = false,
  });

  String _money(double value) =>
      '₦${value.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (m) => ',',
      )}';

  void _copy(BuildContext context, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          18,
          18,
          18,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(18),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pay by bank transfer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Text(
                'Transfer the exact amount to this account.',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 18),
              _transferRow(
                'Bank',
                'Wema Bank',
              ),
              _transferRow(
                'Account number',
                '7821 0045 93',
                copy: true,
                onCopy: () => _copy(context, '7821004593'),
              ),
              _transferRow(
                'Account name',
                'KHS / Adaeze Nwosu',
              ),
              _transferRow(
                'Amount',
                _money(amount),
                copy: true,
                onCopy: () => _copy(context, amount.toStringAsFixed(0)),
              ),
              const SizedBox(height: 14),

              const SizedBox(height: 18),
              greenButton(
                label: "I've sent the money",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentPendingScreen(
                        amount: amount,
                        invoice: invoice,
                        payAll: payAll,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transferRow(
      String title,
      String value, {
        bool copy = false,
        VoidCallback? onCopy,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF98A2B3),
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (copy)
            IconButton(
              onPressed: onCopy,
              icon: const Icon(
                Icons.copy,
                size: 15,
                color: Color(0xFF16834E),
              ),
            ),
        ],
      ),
    );
  }
}