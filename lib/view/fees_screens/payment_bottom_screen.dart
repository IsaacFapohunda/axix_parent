
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/fees/fees_controller.dart';
import '../../model/fees/fees_data.dart';
import 'card_payment_screen.dart';
import 'bank_transfer_screen.dart';

class PayInvoiceBottomSheet extends ConsumerWidget {
  final FeeInvoice invoice;

  const PayInvoiceBottomSheet({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(feesControllerProvider);

    return _PaymentMethodSheet(
      title: 'Pay school fees',
      subtitle: '${invoice.title} · ${invoice.studentName}',
      amount: invoice.outstanding,
      onCard: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardPaymentScreen(
              invoice: invoice,
            ),
          ),
        );
      },
      onWallet: () {
        fees.payFromWallet(invoice, invoice.outstanding);
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onBank: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              amount: invoice.outstanding,
              invoice: invoice,
            ),
          ),
        );
      },
    );
  }
}

class PayAllFeesBottomSheet extends ConsumerWidget {
  const PayAllFeesBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(feesControllerProvider);

    final selectedInvoices = fees.invoices
        .where((invoice) =>
        fees.selectedInvoiceIds.contains(invoice.id))
        .toList();

    return _PaymentMethodSheet(
      title: 'Pay school fees',
      subtitle: '${selectedInvoices.length} invoices',
      amount: fees.selectedOutstanding,
      onCard: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardPaymentScreen(
              payAll: true,
            ),
          ),
        );
      },
      onWallet: () {
        final amount = fees.selectedOutstanding;

        if (fees.walletBalance >= amount) {
          for (final invoice in selectedInvoices) {
            fees.payFromWallet(invoice, invoice.outstanding);
          }
        }

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              fees.walletBalance >= 0
                  ? 'Wallet payment processed.'
                  : 'Insufficient wallet balance.',
            ),
          ),
        );
      },
      onBank: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              amount: fees.selectedOutstanding,
              payAll: true,
            ),
          ),
        );
      },
    );
  }
}

class _PaymentMethodSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final VoidCallback onCard;
  final VoidCallback onWallet;
  final VoidCallback onBank;

  const _PaymentMethodSheet({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onCard,
    required this.onWallet,
    required this.onBank,
  });

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
          18,
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
                  'Pay school fees',
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
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF98A2B3),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _money(amount),
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'PAY WITH',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF98A2B3),
              ),
            ),
            const SizedBox(height: 8),
            _methodTile(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Axix wallet',
              subtitle: 'Available balance',
              onTap: onWallet,
            ),
            _methodTile(
              icon: Icons.credit_card_outlined,
              title: 'Card',
              subtitle: 'Debit or credit card',
              onTap: onCard,
            ),
            _methodTile(
              icon: Icons.account_balance_outlined,
              title: 'Bank transfer',
              subtitle: 'Pay into the school virtual account',
              onTap: onBank,
            ),
          ],
        ),
      ),
    );
  }

  Widget _methodTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFECEFF2)),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF667085)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.radio_button_unchecked,
              color: Color(0xFF98A2B3),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}