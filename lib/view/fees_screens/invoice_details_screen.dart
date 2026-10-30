
import 'package:axix_parent_app/view/fees_screens/payment_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';
import '../messages_screen/messages_widget/parent_holder.dart';
import 'fees_helper_widgets/fees_widgets.dart';




class InvoiceDetailsScreen extends ConsumerWidget {
  final String invoiceId;

  const InvoiceDetailsScreen({
    super.key,
    required this.invoiceId,
  });

  String _money(double amount) {
    return '₦${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    )}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(feesControllerProvider);

    final FeeInvoice invoice = fees.invoices.firstWhere(
          (item) => item.id == invoiceId,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF20242C),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invoice.id,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF20242C),
              ),
            ),
            const Text(
              'First term tuition · Adaeze',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF98A2B3),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFECEFF2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BALANCE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF98A2B3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InvoiceStatusBadge(
                      status: invoice.status,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  _money(invoice.outstanding),
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'of ${_money(invoice.amount)} · Due '
                      '${invoice.dueDate.day} '
                      '${_month(invoice.dueDate.month)} '
                      '${invoice.dueDate.year}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF98A2B3),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 17),

          const Text(
            'Items',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              children: [
                _detailRow(invoice.title, _money(invoice.amount)),
                const Divider(height: 22),
                _detailRow('Amount paid', _money(invoice.amountPaid)),
                const Divider(height: 22),
                _detailRow(
                  'Outstanding',
                  _money(invoice.outstanding),
                  isBold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Payments on this invoice',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          if (fees.receipts
              .where((receipt) => receipt.invoiceId == invoice.id)
              .isEmpty)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'No payments have been made on this invoice.',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF98A2B3),
                ),
              ),
            )
          else
            ...fees.receipts
                .where((receipt) => receipt.invoiceId == invoice.id)
                .map(
                  (receipt) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Color(0xFF16834E),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _money(receipt.amount),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${receipt.method} · ${receipt.id}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF98A2B3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF98A2B3),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 20),

          if (invoice.outstanding > 0)
            greenButton(
              label: 'Pay ${_money(invoice.outstanding)}',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => PayInvoiceBottomSheet(
                    invoice: invoice,
                  ),
                );
              },
            )
          else
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F7EF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF16834E),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Invoice fully paid',
                    style: TextStyle(
                      color: Color(0xFF16834E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static Widget _detailRow(
      String title,
      String amount, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: isBold
                ? const Color(0xFF20242C)
                : const Color(0xFF8994A5),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF20242C),
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static String _month(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }
}