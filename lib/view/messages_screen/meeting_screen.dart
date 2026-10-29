
import 'package:axix_parent_app/view/messages_screen/request_meeting_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'empty_destination_screen.dart';
import 'messages_widget/green_button.dart';

class MeetingsScreen extends ConsumerWidget {
  const MeetingsScreen({super.key});

  final List<Map<String, String>> meetings = const [
    {
      'title': 'Parent-Teacher Conference',
      'subtitle': 'Discuss Adaeze’s academic progress',
      'date': 'Apr 18',
      'time': '10:00 AM',
      'status': 'Upcoming',
    },
    {
      'title': 'Academic Review',
      'subtitle': 'SS1 academic performance review',
      'date': 'Apr 22',
      'time': '12:30 PM',
      'status': 'Upcoming',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final appText = ref.watch(appTextProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Your meetings',
                style: appText.headingBlack(context, fontSize: 16),
              ),
            ),
            Text(
              '${meetings.length} meetings',
              style: appText.body2ColorText(
                theme,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        ...meetings.map((meeting) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmptyDestinationScreen(
                    title: meeting['title']!,
                    message: 'Meeting details will appear here.',
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
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
                    width: 44,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xFF1A7A4A),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting['title']!,
                          style: appText.bodyBlack(
                            context,
                            fontSize: 13,
                            fontweight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          meeting['subtitle']!,
                          style: appText.body2ColorText(
                            theme,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          '${meeting['date']} · ${meeting['time']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF67707E),
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            meeting['status']!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF1A7A4A),
                            ),
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

        const SizedBox(height: 8),

        greenButton(
          label: 'Request a meeting',
          icon: Icons.add,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const RequestMeetingBottomSheet(),
            );
          },
        ),
      ],
    );
  }
}