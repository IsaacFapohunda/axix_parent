
import 'package:axix_parent_app/view/academics_screen/switch%20_child_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/attendance_tab_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/report_card_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ParentAcademicsScreen extends ConsumerStatefulWidget {
  const ParentAcademicsScreen({super.key});

  @override
  ConsumerState<ParentAcademicsScreen> createState() =>
      _ParentAcademicsScreenState();
}

class _ParentAcademicsScreenState
    extends ConsumerState<ParentAcademicsScreen> {
  int selectedTab = 0;

  String selectedChild = 'Adaeze Nwosu';
  String selectedClass = 'SS1B';

  final List<Map<String, String>> children = [
    {
      'name': 'Adaeze Nwosu',
      'class': 'SS1B',
      'initials': 'AN',
    },
    {
      'name': 'Chidi Nwosu',
      'class': 'JSS2A',
      'initials': 'CN',
    },
  ];

  Future<void> _showChildren() async {
    final child = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SwitchChildBottomSheet(
        children: children,
        selectedChild: selectedChild,
      ),
    );

    if (child != null && mounted) {
      setState(() {
        selectedChild = child['name']!;
        selectedClass = child['class']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: _showChildren,
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFE8EBEF),
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: Color(0xFF2D91FF),
                                child: Text(
                                  'AN',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Text(
                                selectedChild.split(' ').first,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                selectedClass,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF77808D),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 16,
                                color: Color(0xFF8993A1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            color: Color(0xFF5C6674),
                          ),
                          Positioned(
                            right: -3,
                            top: -5,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE94B45),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFB42318),
                        child: Text(
                          'NN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Academics',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF18212B),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$selectedChild · $selectedClass · First Term 2025/2026',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF87909C),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: const Color(0xFFECEFF2)),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
                children: [
                  _tabButton('Timetable', 0),
                  const SizedBox(width: 7),
                  _tabButton('Attendance', 1),
                  const SizedBox(width: 7),
                  _tabButton('Report cards', 2),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  const TimetablePlaceholderTab(),
                  AttendanceTab(childName: selectedChild),
                  ReportCardsTab(childName: selectedChild),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTab = index),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF197B4B) : Colors.white,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF197B4B)
                  : const Color(0xFFE8EBEF),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : const Color(0xFF657080),
            ),
          ),
        ),
      ),
    );
  }
}

class TimetablePlaceholderTab extends StatelessWidget {
  const TimetablePlaceholderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Timetable content can be connected here.',
          style: TextStyle(color: Color(0xFF7B8490)),
        ),
      ),
    );
  }
}