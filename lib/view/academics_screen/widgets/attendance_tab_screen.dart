
import 'package:flutter/material.dart';

import '../explain_absence_bottom_screen.dart';
import '../switch _child_screen.dart';

class AttendanceTab extends StatefulWidget {
  const AttendanceTab({
    super.key,
    required this.childName,
  });

  final String childName;

  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  String selectedDay = 'Mon';

  // Replace these sample values with the attendance API response.
  final Map<String, Map<String, dynamic>> dailyData = {
    'Mon': {
      'type': 'attendance',
      'lessons': [
        {'time': '7:30', 'subject': 'Assembly', 'teacher': 'Hall'},
        {
          'time': '8:00',
          'subject': 'English Language',
          'teacher': 'Mrs. Adeyemi · Room 201'
        },
        {
          'time': '9:00',
          'subject': 'Mathematics',
          'teacher': 'Mr. Okafor · Room 102'
        },
        {
          'time': '10:00',
          'subject': 'Basic Science',
          'teacher': 'Mrs. Bello · Room 203'
        },
        {
          'time': '11:00',
          'subject': 'BREAK',
          'teacher': ''
        },
        {
          'time': '11:30',
          'subject': 'Social Studies',
          'teacher': 'Mr. James · Room 105'
        },
      ],
    },
    'Tue': {
      'type': 'attendance',
      'lessons': [
        {
          'time': '8:00',
          'subject': 'Mathematics',
          'teacher': 'Mr. Okafor · Room 102'
        },
        {
          'time': '9:00',
          'subject': 'English Language',
          'teacher': 'Mrs. Adeyemi · Room 201'
        },
      ],
    },
    'Wed': {
      'type': 'noRegister',
      'message': 'Register not taken yet',
      'description': 'The attendance register has not been submitted.',
    },
    'Thu': {
      'type': 'absent',
      'message': 'Marked absent',
      'description': 'Adaeze was marked absent on this day.',
    },
    'Fri': {
      'type': 'holiday',
      'message': 'No school on Friday, 1 May',
      'description':
      'Workers’ Day public holiday. Lessons resume on Monday, 4 May.',
    },
  };

  Future<void> _explainAbsence() async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExplainAbsenceBottomSheet(
        date: '$selectedDay, 3 Apr 2026 · Absent',
        onSubmit: ({
          required reason,
          required note,
          attachment,
        }) async {
          // TODO: Submit reason, note and attachment to your API.
          // The attachment is a PlatformFile from file_picker.
          debugPrint('Reason: $reason');
          debugPrint('Note: $note');
         // debugPrint('Attachment: ${attachment?.name}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = dailyData[selectedDay] ??
        {'type': 'notPublished'};

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        _attendanceRateCard(),
        const SizedBox(height: 18),
        Row(
          children: [
            const Text(
              'Select day',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            Text(
              widget.childName,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF7B8490),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: weekdays.map((day) {
            final selected = selectedDay == day;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: InkWell(
                  onTap: () => setState(() => selectedDay = day),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF111820)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFF111820)
                            : const Color(0xFFE7EAEE),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF657080),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        if (data['type'] == 'attendance') ...[
          _sectionHeading('Attendance for $selectedDay'),
          const SizedBox(height: 12),
          ...(data['lessons'] as List<Map<String, String>>).map(
                (lesson) => _lessonCard(lesson),
          ),
        ] else if (data['type'] == 'absent') ...[
          _statusCard(
            icon: Icons.event_busy_outlined,
            title: 'Marked absent',
            description: data['description'] as String,
            color: const Color(0xFFB42318),
          ),
          const SizedBox(height: 14),
          _absenceAction(),
          const SizedBox(height: 24),
          _sectionHeading('Recent days'),
          const SizedBox(height: 8),
          _recentDay('Fri, 10 Nov', 'Present', Colors.green),
          _recentDay('Thu, 9 Nov', 'Late', Colors.orange),
          _recentDay('Wed, 8 Nov', 'Present', Colors.green),
          _recentDay('Fri, 3 Nov', 'Absent', Colors.red),
        ] else if (data['type'] == 'holiday') ...[
          _emptyState(
            icon: Icons.wb_sunny_outlined,
            title: data['message'] as String,
            description: data['description'] as String,
            linkText: 'See school calendar',
          ),
        ] else if (data['type'] == 'noRegister') ...[
          _emptyState(
            icon: Icons.pending_actions_outlined,
            title: data['message'] as String,
            description: data['description'] as String,
          ),
        ] else ...[
          _emptyState(
            icon: Icons.calendar_today_outlined,
            title: 'Timetable not published yet',
            description:
            'The timetable will appear here once the school publishes it.',
          ),
        ],
      ],
    );
  }

  Widget _attendanceRateCard() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9EDF0)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                '94%',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              SizedBox(width: 8),
              Text(
                'attendance rate',
                style: TextStyle(fontSize: 10, color: Color(0xFF7B8490)),
              ),
              Spacer(),
              Icon(Icons.circle, color: Color(0xFF35B879), size: 7),
              SizedBox(width: 4),
              Text(
                'Good standing',
                style: TextStyle(fontSize: 9, color: Color(0xFF35A66D)),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: .94,
              minHeight: 5,
              backgroundColor: Color(0xFFE9EDF0),
              color: Color(0xFF197B4B),
            ),
          ),
          const SizedBox(height: 13),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _AttendanceNumber('46', 'PRESENT', Color(0xFF197B4B)),
              _AttendanceNumber('3', 'LATE', Color(0xFFE89A25)),
              _AttendanceNumber('2', 'ABSENT', Color(0xFFE94B45)),
              _AttendanceNumber('1', 'EXCUSED', Color(0xFF328AFF)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
    );
  }

  Widget _lessonCard(Map<String, String> lesson) {
    final isBreak = lesson['subject'] == 'BREAK';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                lesson['time'] ?? '',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBreak
                    ? const Color(0xFFF1F3F5)
                    : Colors.white,
                border: Border.all(
                  color: const Color(0xFFE7EAEE),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson['subject'] ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isBreak
                          ? const Color(0xFF7B8490)
                          : const Color(0xFF6372D9),
                    ),
                  ),
                  if ((lesson['teacher'] ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      lesson['teacher']!,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF7B8490),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE7EAEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7B8490),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _absenceAction() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: _explainAbsence,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF197B4B),
          side: const BorderSide(color: Color(0xFF197B4B)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Explain an absence',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _recentDay(String date, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFECEFF2)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState({
    required IconData icon,
    required String title,
    required String description,
    String? linkText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 55, left: 12, right: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF5E5),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: const Color(0xFFE89A25)),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              height: 1.5,
              color: Color(0xFF7B8490),
            ),
          ),
          if (linkText != null) ...[
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Connect the school-calendar navigation here.
              },
              child: Text(
                linkText,
                style: const TextStyle(
                  color: Color(0xFF197B4B),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AttendanceNumber extends StatelessWidget {
  const _AttendanceNumber(this.value, this.label, this.color);

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            color: Color(0xFF7B8490),
          ),
        ),
      ],
    );
  }
}