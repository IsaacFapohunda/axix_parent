
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import '../messages_screen/messages_widget/green_button.dart';
import 'wallet_topup_success_screen.dart';

class TopUpWalletBottomSheet extends ConsumerStatefulWidget {
  const TopUpWalletBottomSheet({super.key});

  @override
  ConsumerState<TopUpWalletBottomSheet> createState() =>
      _TopUpWalletBottomSheetState();
}

class _TopUpWalletBottomSheetState
    extends ConsumerState<TopUpWalletBottomSheet> {
  double? selectedAmount;
  String paymentMethod = 'Card';

  final List<double> amounts = [
    20000,
    50000,
    100000,
    145000,
  ];

  String _money(double value) =>
      '₦${value.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (m) => ',',
      )}';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          18,
          15,
          18,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
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
                  'Top up wallet',
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
              'Select an amount to add to your wallet.',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF98A2B3),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Text(
                selectedAmount == null
                    ? '₦0'
                    : _money(selectedAmount!),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: amounts.map((amount) {
                final selected = selectedAmount == amount;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedAmount = amount;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF20242C)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFECEFF2),
                      ),
                    ),
                    child: Text(
                      _money(amount),
                      style: TextStyle(
                        fontSize: 10,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF344054),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              'PAY WITH',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF98A2B3),
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 9),

            _paymentOption(
              'Card',
              'Mastercard or Visa',
              Icons.credit_card_outlined,
            ),

            _paymentOption(
              'Bank transfer',
              'Your wallet virtual account',
              Icons.account_balance_outlined,
            ),

            const SizedBox(height: 18),

            greenButton(
              label: selectedAmount == null
                  ? 'Top up wallet'
                  : 'Top up ${_money(selectedAmount!)}',
              onTap: () {
                if (selectedAmount == null) return;

                final amount = selectedAmount!;

                ref.read(feesControllerProvider).topUpWallet(amount);

                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WalletTopUpSuccessScreen(
                      amount: amount,
                      method: paymentMethod,
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

  Widget _paymentOption(
      String title,
      String subtitle,
      IconData icon,
      ) {
    final selected = paymentMethod == title;

    return InkWell(
      onTap: () {
        setState(() {
          paymentMethod = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE7F7EF)
              : Colors.white,
          border: Border.all(
            color: selected
                ? const Color(0xFF16834E)
                : const Color(0xFFECEFF2),
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 18,
              color: const Color(0xFF16834E),
            ),
          ],
        ),
      ),
    );
  }
}