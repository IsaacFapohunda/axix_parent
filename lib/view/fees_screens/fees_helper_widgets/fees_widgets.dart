
import 'package:flutter/material.dart';

import '../../../model/fees/fees_data.dart';


class FeesSectionHeading extends StatelessWidget {
  final String title;
  final String? trailing;

  const FeesSectionHeading({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF20242C),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: const TextStyle(
              color: Color(0xFF16834E),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}

class InvoiceStatusBadge extends StatelessWidget {
  final String status;

  const InvoiceStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    switch (status) {
      case 'Paid':
        background = const Color(0xFFE7F7EF);
        foreground = const Color(0xFF16834E);
        break;
      case 'Part paid':
        background = const Color(0xFFFFF3DF);
        foreground = const Color(0xFFE69A27);
        break;
      default:
        background = const Color(0xFFFFE9E9);
        foreground = const Color(0xFFE34C4C);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}

class InvoiceListTile extends StatelessWidget {
  final FeeInvoice invoice;
  final VoidCallback onTap;

  const InvoiceListTile({
    super.key,
    required this.invoice,
    required this.onTap,
  });

  String _formatAmount(double amount) {
    return '₦${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Color(0xFFECEFF2)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3DF),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFFE69A27),
                size: 19,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${invoice.id} · ${_formatAmount(invoice.amount)}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8B95A5),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InvoiceStatusBadge(status: invoice.status),
                const SizedBox(height: 5),
                Text(
                  invoice.status == 'Paid'
                      ? _formatAmount(invoice.amount)
                      : _formatAmount(invoice.outstanding),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: Color(0xFF8994A5),
            ),
          ],
        ),
      ),
    );
  }
}