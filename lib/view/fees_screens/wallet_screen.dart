
import 'package:axix_parent_app/view/fees_screens/wallet_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  bool autoDebit = true;

  String _money(double value) =>
      '₦${value.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (m) => ',',
      )}';

  @override
  Widget build(BuildContext context) {
    final fees = ref.watch(feesControllerProvider);

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: const Color(0xFF16834E),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WALLET BALANCE',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  _money(fees.walletBalance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'No pending top ups',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const TopUpWalletBottomSheet(),
                      );
                    },
                    icon: const Icon(Icons.add, size: 17),
                    label: const Text(
                      'Top up',
                      style: TextStyle(fontSize: 11),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF16834E),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Auto debit school levies',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Switch(
                  value: autoDebit,
                  activeColor: const Color(0xFF16834E),
                  onChanged: (value) {
                    setState(() {
                      autoDebit = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Wallet activity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 9),
          if (fees.walletTransactions.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Your wallet activity will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF98A2B3),
                ),
              ),
            )
          else
            ...fees.walletTransactions.map(
                  (transaction) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: transaction.isCredit
                          ? const Color(0xFFE7F7EF)
                          : const Color(0xFFFFE9E9),
                      child: Icon(
                        transaction.isCredit
                            ? Icons.add
                            : Icons.arrow_outward,
                        color: transaction.isCredit
                            ? const Color(0xFF16834E)
                            : const Color(0xFFE55353),
                        size: 17,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            transaction.description,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF98A2B3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${transaction.isCredit ? '+' : '-'}'
                          '${_money(transaction.amount)}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: transaction.isCredit
                            ? const Color(0xFF16834E)
                            : const Color(0xFFE55353),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}