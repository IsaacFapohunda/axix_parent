
import 'dart:ui';

import 'package:flutter/material.dart';

import 'add_card_bank_transfer_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() =>
      _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, String>> cards = [
    {
      'number': '4219',
      'type': 'Verve',
      'expiry': '09/28',
      'name': 'NGOZI NWOSU',
    },
    {
      'number': '1182',
      'type': 'Verve',
      'expiry': '11/27',
      'name': 'NGOZI NWOSU',
    },
  ];

  String defaultCard = '4219';

  Future<void> _addCard() async {
    final card = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddNewCardBottomSheet(),
    );

    if (card == null || !mounted) return;

    setState(() {
      cards.add(card);
    });

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CardAddedBottomSheet(
        card: card,
        onMakeDefault: () {
          setState(() {
            defaultCard = card['number']!;
          });
        },
      ),
    );
  }

  Future<void> _removeCard(Map<String, String> card) async {
    final remove = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => RemoveCardBottomSheet(card: card),
    );

    if (remove == true && mounted) {
      setState(() {
        cards.remove(card);

        if (defaultCard == card['number'] && cards.isNotEmpty) {
          defaultCard = cards.first['number']!;
        } else if (cards.isEmpty) {
          defaultCard = '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Color(0xFF20252D)),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment methods',
              style: TextStyle(
                color: Color(0xFF20252D),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Your saved cards and wallet options',
              style: TextStyle(
                color: Color(0xFF89919D),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeading('Saved cards'),
          const SizedBox(height: 8),
          ...cards.map((card) {
            final isDefault = defaultCard == card['number'];

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFECEFF2),
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.credit_card,
                  color: Color(0xFF1A7A4A),
                ),
                title: Text(
                  '•••• ${card['number']}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Expires ${card['expiry']}',
                  style: const TextStyle(fontSize: 11),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'default') {
                      setState(() {
                        defaultCard = card['number']!;
                      });
                    } else if (value == 'remove') {
                      _removeCard(card);
                    }
                  },
                  itemBuilder: (_) => [
                    if (!isDefault)
                      const PopupMenuItem(
                        value: 'default',
                        child: Text('Make default'),
                      ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove card'),
                    ),
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isDefault)
                        const Text(
                          '✓ Default',
                          style: TextStyle(
                            color: Color(0xFF1A7A4A),
                            fontSize: 10,
                          ),
                        ),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFF89919D),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 6),
          OutlinedButton.icon(
            onPressed: _addCard,
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add a new card'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1A7A4A),
              side: const BorderSide(
                color: Color(0xFF1A7A4A),
                style: BorderStyle.solid,
              ),
            ),
          ),
          const SizedBox(height: 22),
          _sectionHeading('Other ways to pay'),
          const SizedBox(height: 8),
          _paymentOption(
            icon: Icons.account_balance_outlined,
            title: 'Bank transfer',
            subtitle: 'Each child has their own school account number',
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => const BankTransferBottomSheet(),
              );
            },
          ),
          _paymentOption(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Axix wallet',
            subtitle: 'Wallet balance and transaction options',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wallet integration is not connected yet.'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _paymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF89919D)),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF89919D),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}