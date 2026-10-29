
import 'package:flutter/material.dart';

import '../messages_screen/messages_widget/green_button.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key});

  @override
  State<AddNewCardBottomSheet> createState() =>
      _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState
    extends State<AddNewCardBottomSheet> {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final nameController = TextEditingController();
  bool makeDefault = true;

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
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          18,
          14,
          18,
          MediaQuery.of(context).viewInsets.bottom + 18,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sheetHeader(
                context,
                'Pay by bank transfer',
                subtitle: 'Enter your card details',
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A7A4A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.credit_card, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      '•••• •••• •••• ••••',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        letterSpacing: 1.3,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'CARD PREVIEW',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _cardField(
                'Card number',
                cardNumberController,
                hint: '0000 0000 0000 0000',
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: _cardField(
                      'Expiry',
                      expiryController,
                      hint: 'MM/YY',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _cardField(
                      'CVV',
                      cvvController,
                      hint: '3 digits',
                      keyboardType: TextInputType.number,
                      obscure: true,
                    ),
                  ),
                ],
              ),
              _cardField(
                'Name on card',
                nameController,
                hint: 'NAME ON CARD',
              ),
              CheckboxListTile(
                value: makeDefault,
                onChanged: (value) {
                  setState(() => makeDefault = value ?? false);
                },
                dense: true,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF1A7A4A),
                title: const Text(
                  'Make this my default card',
                  style: TextStyle(fontSize: 12),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),
              greenButton(
                label: 'Continue',
                onTap: () {
                  final digits = cardNumberController.text
                      .replaceAll(RegExp(r'\D'), '');

                  if (digits.length < 12 ||
                      expiryController.text.trim().isEmpty ||
                      cvvController.text.trim().length < 3 ||
                      nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter valid card details.',
                        ),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context, {
                    'number': digits.substring(digits.length - 4),
                    'type': 'Card',
                    'expiry': expiryController.text.trim(),
                    'name': nameController.text.trim().toUpperCase(),
                    'makeDefault': makeDefault.toString(),
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardAddedBottomSheet extends StatelessWidget {
  const CardAddedBottomSheet({
    super.key,
    required this.card,
    required this.onMakeDefault,
  });

  final Map<String, String> card;
  final VoidCallback onMakeDefault;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sheetHeader(context, 'Card added'),
            const SizedBox(height: 12),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFE5F5EB),
              child: Icon(
                Icons.check,
                color: Color(0xFF1A7A4A),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Card saved',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your card has been added successfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF89919D),
              ),
            ),
            const SizedBox(height: 18),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text('•••• ${card['number']}'),
              subtitle: Text('Expires ${card['expiry']}'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onMakeDefault();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Make default',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A7A4A),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveCardBottomSheet extends StatelessWidget {
  const RemoveCardBottomSheet({
    super.key,
    required this.card,
  });

  final Map<String, String> card;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sheetHeader(context, 'Remove card?'),
            const SizedBox(height: 12),
            Text(
              'Remove card ending in ${card['number']}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 6),
            const Text(
              'You can add the card again later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF89919D),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE55353),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Remove card'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BankTransferBottomSheet extends StatelessWidget {
  const BankTransferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
            _sheetHeader(
              context,
              'Pay by bank transfer',
              subtitle: 'Transfer directly to the school account',
            ),
            const SizedBox(height: 12),
            const Text(
              'School account',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF89919D),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'School account details',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 8),
                  Text('Account number: Obtain from the school'),
                  Text('Bank: Obtain from the school'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Connect your school payment API to display the '
                  'actual account details here.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF89919D),
              ),
            ),
            const SizedBox(height: 12),
            greenButton(
              label: 'Close',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _sheetHeader(
    BuildContext context,
    String title, {
      String? subtitle,
    }) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF89919D),
                ),
              ),
            ],
          ],
        ),
      ),
      IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
    ],
  );
}

Widget _cardField(
    String label,
    TextEditingController controller, {
      String? hint,
      TextInputType keyboardType = TextInputType.text,
      bool obscure = false,
    }) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFF89919D),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    ),
  );
}