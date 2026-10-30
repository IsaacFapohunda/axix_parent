
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import 'fees_helper_widgets/fees_widgets.dart';
import 'invoice_details_screen.dart';

class PaymentPendingScreen extends ConsumerWidget {
  final double amount;
  final dynamic invoice;
  final bool payAll;

  const PaymentPendingScreen({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(feesControllerProvider);

    final progress = fees.totalFees == 0
        ? 0.0
        : (fees.totalPaid / fees.totalFees).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Fees', style: TextStyle(fontSize: 15)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFFFFF3DF),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xFFE69A27),
                  size: 17,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Waiting for your ${_money(amount)} transfer to arrive',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFB7791F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'Adaeze · First Term · 2025/2026',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF98A2B3),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'OUTSTANDING',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF98A2B3),
                  ),
                ),
                Text(
                  _money(fees.totalOutstanding),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  color: const Color(0xFF16834E),
                  backgroundColor: const Color(0xFFECEFF2),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_money(fees.totalPaid)} paid of ${_money(fees.totalFees)}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FeesSectionHeading(
            title: 'Invoices',
            trailing: '${fees.invoices.length}',
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                for (final item in fees.invoices)
                  InvoiceListTile(
                    invoice: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InvoiceDetailsScreen(
                            invoiceId: item.id,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}