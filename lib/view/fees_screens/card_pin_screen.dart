
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'otp_verfication_screen.dart';

class CardPinScreen extends StatefulWidget {
  final FeeInvoice? invoice;
  final bool payAll;

  const CardPinScreen({
    super.key,
    this.invoice,
    this.payAll = false,
  });

  @override
  State<CardPinScreen> createState() => _CardPinScreenState();
}

class _CardPinScreenState extends State<CardPinScreen> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
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
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
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
                    'Enter your card PIN',
                    style: TextStyle(
                      fontSize: 15,
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
                'Enter your 4-digit demonstration PIN',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: pinController,
                obscureText: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: const InputDecoration(
                  hintText: '••••',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
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
                        'This is a demonstration screen. Do not enter a real bank PIN.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              greenButton(
                label: 'Continue',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OtpVerificationScreen(
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
      ),
    );
  }
}