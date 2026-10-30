
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'bank_verification_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final FeeInvoice? invoice;
  final bool payAll;

  const OtpVerificationScreen({
    super.key,
    this.invoice,
    this.payAll = false,
  });

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Fees',
          style: TextStyle(fontSize: 15),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Verify with your bank',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter the demonstration OTP sent by your bank.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF98A2B3),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'OTP CODE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF98A2B3),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                letterSpacing: 12,
                fontWeight: FontWeight.w700,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                hintText: '000000',
                hintStyle: const TextStyle(
                  letterSpacing: 8,
                  color: Color(0xFFD0D5DD),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(
                    color: Color(0xFFECEFF2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resend code in 00:38',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Demonstration OTP resent.'),
                      ),
                    );
                  },
                  child: const Text(
                    "Didn't get it?",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF16834E),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Demonstration only. No bank verification is performed.',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            greenButton(
              label: 'Verify and continue',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BankVerificationScreen(
                      invoice: widget.invoice,
                      payAll: widget.payAll,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}