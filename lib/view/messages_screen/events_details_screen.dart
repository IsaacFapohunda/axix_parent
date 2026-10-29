
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messages_widget/green_button.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
        ),
        title: const Text(
          'Event details',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE4E7EC)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 38,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5EE),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: [
                            Text(
                              event['date']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A7A4A),
                              ),
                            ),
                            Text(
                              event['month']!,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF1A7A4A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title']!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              event['code']!,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF98A2B3),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${event['time']} · ${event['location']}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF67707E),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              event['description']!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF67707E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: greenButton(
              label: 'Add to calendar',
              icon: Icons.calendar_today_outlined,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Demo only: calendar integration is not connected.',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}