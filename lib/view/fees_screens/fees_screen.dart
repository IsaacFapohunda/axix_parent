
import 'package:axix_parent_app/view/fees_screens/payment_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../model/fees/fees_controller.dart';
import '../messages_screen/messages_widget/green_button.dart';
import '../messages_screen/messages_widget/parent_holder.dart';
import '../messages_screen/messages_widget/screen_title.dart';

import 'fees_helper_widgets/fees_widgets.dart';
import 'invoice_details_screen.dart';
import 'payment_history_screen.dart';
import 'wallet_screen.dart';

class FeesScreen extends ConsumerWidget {
  const FeesScreen({super.key});

  String _money(double amount) {
    return '₦${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    )}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);
    final fees = ref.watch(feesControllerProvider);

    final progress = fees.totalFees == 0
        ? 0.0
        : (fees.totalPaid / fees.totalFees).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        primary: false,
        toolbarHeight: 168,
        titleSpacing: 0,
        backgroundColor: theme.appBarWhite,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 39.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              parentHeader(context, ref),
              const SizedBox(height: 24),
              screenTitle(
                context,
                'Fees',
                'Adaeze · First Term · 2025/2026',
                ref,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 25),
        children: [
          Row(
            children: [
              _tab('Fees', true),
              const SizedBox(width: 8),

              // Navigate to payment history.
              _tab(
                'History',
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentHistoryScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(width: 8),

              // Navigate to wallet.
              _tab(
                'Wallet',
                false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WalletScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Outstanding balance card.
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFECEFF2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'OUTSTANDING',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF98A2B3),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _money(fees.totalOutstanding),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF20242C),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  fees.totalOutstanding == 0
                      ? 'All paid · Thank you'
                      : 'Due by 30 Apr 2026',
                  style: TextStyle(
                    fontSize: 10,
                    color: fees.totalOutstanding == 0
                        ? const Color(0xFF16834E)
                        : const Color(0xFFE55353),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF16834E),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${_money(fees.totalPaid)} paid of '
                      '${_money(fees.totalFees)} '
                      '(${(progress * 100).round()}%)',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF98A2B3),
                  ),
                ),

                if (fees.totalOutstanding > 0) ...[
                  const SizedBox(height: 12),

                  // Open the pay-all-outstanding bottom sheet.
                  greenButton(
                    label: 'Pay ${_money(fees.totalOutstanding)}',
                    onTap: () {
                      fees.selectAllOutstandingInvoices();

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return PayAllFeesBottomSheet();
                        },
                      );
                    },
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 17),

          FeesSectionHeading(
            title: 'Invoices',
            trailing: '${fees.invoices.length}',
          ),

          const SizedBox(height: 8),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFECEFF2),
              ),
            ),
            child: Column(
              children: [
                for (final invoice in fees.invoices)
                  InvoiceListTile(
                    invoice: invoice,
                    onTap: () {
                      fees.selectInvoice(invoice);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InvoiceDetailsScreen(
                            invoiceId: invoice.id,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),

          const SizedBox(height: 17),

          FeesSectionHeading(
            title: 'Receipts',
            trailing: '${fees.receipts.length}',
          ),

          const SizedBox(height: 8),

          if (fees.receipts.isEmpty)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Your payment receipts will appear here.',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF98A2B3),
                ),
              ),
            )
          else
            ...fees.receipts.map(
                  (receipt) => Container(
                margin: const EdgeInsets.only(bottom: 7),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      color: Color(0xFF16834E),
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
                          Text(
                            '${receipt.id} · ${receipt.method}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF98A2B3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _money(receipt.amount),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
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

  Widget _tab(
      String label,
      bool selected, {
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF16834E)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? const Color(0xFF16834E)
                : const Color(0xFFECEFF2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: selected
                ? Colors.white
                : const Color(0xFF667085),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}