
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'card_pin_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  final FeeInvoice? invoice;
  final bool payAll;

  const CardPaymentScreen({
    super.key,
    this.invoice,
    this.payAll = false,
  });

  @override
  State<CardPaymentScreen> createState() =>
      _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
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
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Pay by card',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Enter your card details',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF98A2B3),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            height: 125,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF16834E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'CARD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  cardNumberController.text.isEmpty
                      ? '•••• •••• •••• ••••'
                      : cardNumberController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  nameController.text.isEmpty
                      ? 'CARDHOLDER NAME'
                      : nameController.text.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _label('Card number'),
          _input(
            controller: cardNumberController,
            hint: '0000 0000 0000 0000',
            keyboardType: TextInputType.number,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Expiry'),
                    _input(
                      controller: expiryController,
                      hint: 'MM/YY',
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('CVV'),
                    _input(
                      controller: cvvController,
                      hint: '000',
                      keyboardType: TextInputType.number,
                      obscure: true,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          _label('Name on card'),
          _input(
            controller: nameController,
            hint: 'Cardholder name',
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 25),

          greenButton(
            label: 'Continue',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CardPinScreen(
                    invoice: widget.invoice,
                    payAll: widget.payAll,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _label(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    List<TextInputFormatter> formatters = const [],
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      inputFormatters: formatters,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xFF98A2B3),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFECEFF2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFECEFF2)),
        ),
      ),
    );
  }
}