import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'events_details_screen.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  int selectedCategory = 0;

  final List<String> categories = const [
    'All events',
    'Academic',
    'Sports',
    'General',
  ];

  final List<Map<String, String>> events = const [
    {
      'title': 'Inter-house sports day',
      'category': 'Sports',
      'date': '24',
      'month': 'APR',
      'code': 'EVT-2026-024',
      'time': '9:00 AM - 3:00 PM',
      'location': 'School sports field',
      'description':
      'Join us for the annual inter-house sports day. Students will participate in sporting activities and represent their respective houses.',
    },
    {
      'title': 'Science exhibition',
      'category': 'Academic',
      'date': '28',
      'month': 'APR',
      'code': 'EVT-2026-028',
      'time': '10:00 AM - 1:00 PM',
      'location': 'School assembly hall',
      'description':
      'Students will present science projects, experiments, and practical demonstrations.',
    },
    {
      'title': 'Parents’ information day',
      'category': 'General',
      'date': '30',
      'month': 'APR',
      'code': 'EVT-2026-030',
      'time': '11:00 AM - 2:00 PM',
      'location': 'School premises',
      'description':
      'An opportunity for parents to receive school updates and important information.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final appText = ref.watch(appTextProvider);

    final filteredEvents = selectedCategory == 0
        ? events
        : events
        .where(
          (event) =>
      event['category'] == categories[selectedCategory],
    )
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        Text(
          'Upcoming events',
          style: appText.headingBlack(context, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(
          'Stay updated with school activities.',
          style: appText.body2ColorText(theme, fontSize: 12),
        ),
        const SizedBox(height: 16),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              final selected = selectedCategory == index;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () {
                    setState(() => selectedCategory = index);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.primaryColor
                          : Colors.white,
                      border: Border.all(
                        color: selected
                            ? theme.primaryColor
                            : const Color(0xFFE4E7EC),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF67707E),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 18),

        if (filteredEvents.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No events found.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF98A2B3),
                ),
              ),
            ),
          ),

        ...filteredEvents.map((event) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsScreen(event: event),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: theme.greyBorderColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event['date']!,
                          style: const TextStyle(
                            fontSize: 19,
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
                          style: appText.bodyBlack(
                            context,
                            fontSize: 13,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5EE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            event['category']!,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF1A7A4A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          event['time']!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF67707E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['location']!,
                          style: const TextStyle(
                            fontSize: 11,
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
          );
        }),
      ],
    );
  }
}