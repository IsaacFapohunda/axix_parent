
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import '../messages_screen/messages_widget/green_button.dart';


class WalletTopUpSuccessScreen extends ConsumerWidget {
  final double amount;
  final String method;

  const WalletTopUpSuccessScreen({
    super.key,
    required this.amount,
    required this.method,
  });

  String _money(double value) =>
      '₦${value.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (m) => ',',
      )}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(feesControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Fees',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFE7F7EF),
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: Color(0xFF16834E),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Wallet topped up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _money(amount),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Added to your wallet successfully.',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const SizedBox(height: 20),
              _detail('Method', method),
              _detail('Balance now', _money(fees.walletBalance)),
              _detail(
                'Date',
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              ),
              const SizedBox(height: 20),
              greenButton(
                label: 'Done',
                onTap: () {
                  Navigator.popUntil(
                    context,
                        (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF98A2B3),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}