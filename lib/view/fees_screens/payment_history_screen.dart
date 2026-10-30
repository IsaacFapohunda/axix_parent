
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';

class PaymentHistoryScreen extends ConsumerWidget {
  const PaymentHistoryScreen({super.key});

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
        title: const Text(
          'Payment history',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              _summaryCard(
                _money(fees.totalPaid),
                'THIS TERM',
              ),
              const SizedBox(width: 8),
              _summaryCard(
                '${fees.receipts.length}',
                'PAYMENTS',
              ),
              const SizedBox(width: 8),
              _summaryCard('2', 'CHILDREN'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment history',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ExportStatementBottomSheet(),
                  );
                },
                icon: const Icon(
                  Icons.download_outlined,
                  size: 15,
                  color: Color(0xFF16834E),
                ),
                label: const Text(
                  'Export',
                  style: TextStyle(
                    color: Color(0xFF16834E),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (fees.receipts.isEmpty)
            _emptyHistory()
          else
            ...fees.receipts.map(
                  (receipt) => _historyTile(receipt),
            ),
        ],
      ),
    );
  }

  Widget _summaryCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF98A2B3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyTile(FeeReceipt receipt) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFFE7F7EF),
            child: Icon(
              Icons.receipt_long,
              size: 17,
              color: Color(0xFF16834E),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receipt.title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${receipt.method} · ${receipt.id}',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF98A2B3),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _money(receipt.amount),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${receipt.date.day}/${receipt.date.month}/${receipt.date.year}',
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF98A2B3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.chevron_right,
            size: 17,
            color: Color(0xFF98A2B3),
          ),
        ],
      ),
    );
  }

  Widget _emptyHistory() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'No payment history yet.',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF98A2B3),
          ),
        ),
      ),
    );
  }
}

class ExportStatementBottomSheet extends StatefulWidget {
  const ExportStatementBottomSheet({super.key});

  @override
  State<ExportStatementBottomSheet> createState() =>
      _ExportStatementBottomSheetState();
}

class _ExportStatementBottomSheetState
    extends State<ExportStatementBottomSheet> {
  double progress = 0;
  bool exporting = false;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exporting statement',
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'First Term · 2025/2026',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF98A2B3),
                ),
              ),
            ),
            const SizedBox(height: 18),
            LinearProgressIndicator(
              value: exporting ? progress : 0,
              color: const Color(0xFF16834E),
              backgroundColor: const Color(0xFFECEFF2),
            ),
            const SizedBox(height: 12),
            Text(
              exporting ? '${(progress * 100).round()}%' : 'Ready to export',
              style: const TextStyle(fontSize: 11),
            ),
            const SizedBox(height: 18),
            greenButton(
              label: exporting ? 'Preparing...' : 'Export statement',
              onTap: exporting
                  ? null
                  : () {
                setState(() {
                  exporting = true;
                  progress = 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Demo export completed. Connect PDF generation later.',
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