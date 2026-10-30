
import 'package:axix_parent_app/view/fees_screens/payment_result_screen.dart';
import 'package:flutter/material.dart';

import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';


class BankVerificationScreen extends StatelessWidget {
  final FeeInvoice? invoice;
  final bool payAll;

  const BankVerificationScreen({
    super.key,
    this.invoice,
    this.payAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bank verification',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.account_balance_outlined,
              size: 45,
              color: Color(0xFF16834E),
            ),
            const SizedBox(height: 20),
            const Text(
              'Verify your payment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your payment is ready for demonstration.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF98A2B3),
              ),
            ),
            const Spacer(),
            greenButton(
              label: 'Verify payment',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentResultScreen(
                      invoice: invoice,
                      payAll: payAll,
                      success: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentResultScreen(
                        invoice: invoice,
                        payAll: payAll,
                        success: false,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Simulate payment failure',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}