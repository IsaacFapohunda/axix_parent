
import 'package:axix_parent_app/view/fees_screens/payment_bottom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/fees/fees_controller.dart';
import '../../model/fees/fees_data.dart';
import '../messages_screen/messages_widget/green_button.dart';


class PaymentResultScreen extends ConsumerStatefulWidget {
  final FeeInvoice? invoice;
  final bool payAll;
  final bool success;

  const PaymentResultScreen({
    super.key,
    this.invoice,
    this.payAll = false,
    required this.success,
  });

  @override
  ConsumerState<PaymentResultScreen> createState() =>
      _PaymentResultScreenState();
}

class _PaymentResultScreenState
    extends ConsumerState<PaymentResultScreen> {
  bool paymentRecorded = false;

  @override
  void initState() {
    super.initState();

    if (widget.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || paymentRecorded) return;

        final fees = ref.read(feesControllerProvider);

        fees.setPaymentMethod('Card');

        if (widget.payAll) {
          fees.paySelectedInvoices();
        } else if (widget.invoice != null) {
          fees.payInvoice(
            widget.invoice!,
            widget.invoice!.outstanding,
          );
        }

        setState(() {
          paymentRecorded = true;
        });
      });
    }
  }

  String _money(double amount) =>
      '₦${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (m) => ',',
      )}';

  @override
  Widget build(BuildContext context) {
    final fees = ref.watch(feesControllerProvider);

    final amount = widget.invoice?.outstanding ??
        (widget.payAll ? fees.selectedOutstanding : 0);

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.success
                        ? Icons.check_circle
                        : Icons.cancel,
                    size: 65,
                    color: widget.success
                        ? const Color(0xFF16834E)
                        : const Color(0xFFE55353),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.success
                        ? 'Payment successful'
                        : 'Payment failed',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.success
                        ? '${_money(amount)} paid successfully.'
                        : 'Your bank declined the payment. No money was taken.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (widget.success) ...[
                    _detail('Method', 'Card'),
                    _detail('Date', _date(DateTime.now())),
                    _detail(
                      'Balance now',
                      _money(fees.totalOutstanding),
                    ),
                  ] else ...[
                    _detail('Amount', _money(amount)),
                    _detail('Reason', 'Insufficient funds (51)'),
                  ],
                  const SizedBox(height: 22),
                  if (widget.success)
                    greenButton(
                      label: 'Done',
                      onTap: () {
                        Navigator.of(context).popUntil(
                              (route) => route.isFirst,
                        );
                      },
                    )
                  else ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).popUntil(
                                    (route) => route.isFirst,
                              );
                            },
                            child: const Text('Close'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: greenButton(
                            label: 'Try another method',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  if (widget.payAll) {
                                    return const PayAllFeesBottomSheet();
                                  }

                                  return PayInvoiceBottomSheet(
                                    invoice: widget.invoice!,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
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

  String _date(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}