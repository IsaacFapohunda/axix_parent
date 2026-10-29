
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ParentHomeScreen extends ConsumerStatefulWidget {
  const ParentHomeScreen({
    super.key,
    this.children = const [
      ParentHomeChild(
        id: '1',
        name: 'Adaeze Nwosu',
        className: 'SS1B',
        initials: 'AN',
      ),
      ParentHomeChild(
        id: '2',
        name: 'Chidi Nwosu',
        className: 'JSS2A',
        initials: 'CN',
      ),
    ],
    this.initialChildId = '1',
    this.attendanceStatus = AttendanceStatus.registerNotTaken,
    this.attendanceMessage,
    this.needsYouItems = const [],
    this.onChildChanged,
    this.onPayFees,
    this.onExplainAbsence,
  });

  final List<ParentHomeChild> children;
  final String initialChildId;
  final AttendanceStatus attendanceStatus;

  // Supply the backend message here when available.
  final String? attendanceMessage;

  // Empty list automatically shows "You're all caught up".
  final List<ParentHomeItem> needsYouItems;

  // Use this callback to fetch the selected child's dashboard data.
  final ValueChanged<ParentHomeChild>? onChildChanged;
  final VoidCallback? onPayFees;
  final VoidCallback? onExplainAbsence;

  @override
  ConsumerState<ParentHomeScreen> createState() =>
      _ParentHomeScreenState();
}

class _ParentHomeScreenState
    extends ConsumerState<ParentHomeScreen> {
  late ParentHomeChild selectedChild;

  static const green = Color(0xFF1A7A4A);
  static const pageBackground = Color(0xFFF8FAF9);
  static const borderColor = Color(0xFFECEFF2);
  static const mutedText = Color(0xFF667085);

  @override
  void initState() {
    super.initState();

    selectedChild = widget.children.firstWhere(
          (child) => child.id == widget.initialChildId,
      orElse: () => widget.children.first,
    );
  }

  Future<void> _showChildSelector() async {
    final child = await showModalBottomSheet<ParentHomeChild>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _ChildSelectorSheet(
          children: widget.children,
          selectedChildId: selectedChild.id,
        );
      },
    );

    if (child == null || !mounted) return;

    setState(() {
      selectedChild = child;
    });

    // The parent can use this to fetch fresh API data for this child.
    widget.onChildChanged?.call(child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            _buildTopBar(),
            const SizedBox(height: 18),
            _buildGreeting(),
            const SizedBox(height: 14),
            _buildChildSummary(),
            const SizedBox(height: 12),
            _buildStatistics(),
            const SizedBox(height: 16),
            _buildNeedsYou(),
            const SizedBox(height: 16),
            _buildTimetable(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildUpcomingEvents(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        InkWell(
          onTap: _showChildSelector,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: const Color(0xFFE8F1FF),
                  child: Text(
                    selectedChild.initials,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2383E2),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  selectedChild.name.split(' ').first,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.keyboard_arrow_down, size: 14),
              ],
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Connect your notifications screen here.
          },
          visualDensity: VisualDensity.compact,
          icon: const Icon(
            Icons.notifications_none,
            size: 22,
          ),
        ),
        Container(
          width: 27,
          height: 27,
          decoration: const BoxDecoration(
            color: Color(0xFFB42318),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'NN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good afternoon, Ngozi',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Mon, 13th of Apr, 2026 · First Term',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildChildSummary() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: const Color(0xFFE8F1FF),
                child: Text(
                  selectedChild.initials,
                  style: const TextStyle(
                    color: Color(0xFF2383E2),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedChild.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${selectedChild.className} · Blue House',
                      style: const TextStyle(
                        fontSize: 9,
                        color: mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _attendanceStatusCard(),
        ],
      ),
    );
  }

  Widget _attendanceStatusCard() {
    late final Color background;
    late final Color foreground;
    late final IconData icon;
    late final String defaultMessage;

    switch (widget.attendanceStatus) {
      case AttendanceStatus.registerNotTaken:
        background = const Color(0xFFFFF5E8);
        foreground = const Color(0xFFB76E00);
        icon = Icons.schedule_outlined;
        defaultMessage = 'Register not taken yet today.';
        break;

      case AttendanceStatus.present:
        background = const Color(0xFFE8F5EE);
        foreground = green;
        icon = Icons.check_circle_outline;
        defaultMessage = 'In school today · Marked present.';
        break;

      case AttendanceStatus.absent:
        background = const Color(0xFFFFECEB);
        foreground = const Color(0xFFB42318);
        icon = Icons.info_outline;
        defaultMessage = 'Marked absent today.';
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: foreground),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              widget.attendanceMessage ?? defaultMessage,
              style: TextStyle(
                fontSize: 9,
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.attendanceStatus == AttendanceStatus.absent)
            TextButton(
              onPressed: widget.onExplainAbsence,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                minimumSize: const Size(0, 28),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Explain absence',
                style: TextStyle(
                  fontSize: 9,
                  color: green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        _statCard('94%', 'ATTENDANCE', green),
        const SizedBox(width: 8),
        _statCard('₦145k', 'FEES DUE', const Color(0xFFB42318)),
        const SizedBox(width: 8),
        _statCard('3', 'ASSIGNMENTS', const Color(0xFF2383E2)),
      ],
    );
  }

  Widget _statCard(String value, String label, Color color) {
    return Expanded(
      child: _card(
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 3,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 7,
                color: mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeedsYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading('Needs you', '${widget.needsYouItems.length}'),
        const SizedBox(height: 8),
        if (widget.needsYouItems.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5EE),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: green,
                  size: 18,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You're all caught up",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: green,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Nothing needs your attention right now.',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          ...widget.needsYouItems.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _needsYouItem(item),
            ),
          ),
      ],
    );
  }

  Widget _needsYouItem(ParentHomeItem item) {
    final isFee = item.type == ParentHomeItemType.fee;

    return _card(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isFee
                  ? const Color(0xFFFFF3E0)
                  : const Color(0xFFFFECEB),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(
              isFee
                  ? Icons.account_balance_wallet_outlined
                  : Icons.event_busy_outlined,
              size: 16,
              color: isFee
                  ? const Color(0xFFB76E00)
                  : const Color(0xFFB42318),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle!,
                    style: const TextStyle(
                      fontSize: 9,
                      color: mutedText,
                    ),
                  ),
                ],
              ],
            ),
          ),
          TextButton(
            onPressed: item.onTap ??
                (isFee ? widget.onPayFees : widget.onExplainAbsence),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              minimumSize: const Size(0, 28),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              item.actionLabel,
              style: const TextStyle(
                fontSize: 9,
                color: green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading('Now in class', 'Timetable'),
        const SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PERIOD 6 · 12:45 - 13:30',
                style: TextStyle(
                  color: green,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Chemistry',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Dr. Ex · SS1B · Lab 1',
                style: TextStyle(
                  fontSize: 9,
                  color: mutedText,
                ),
              ),
              const SizedBox(height: 9),
              const Divider(height: 1, color: borderColor),
              const SizedBox(height: 8),
              const Text(
                'Next: Physics · 13:30 - 14:15',
                style: TextStyle(
                  fontSize: 9,
                  color: mutedText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'For your child',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _quickAction(
              Icons.calendar_month_outlined,
              'Timetable',
              const Color(0xFFE8F5EE),
            ),
            const SizedBox(width: 8),
            _quickAction(
              Icons.fact_check_outlined,
              'Attendance',
              const Color(0xFFE8F1FF),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _quickAction(
              Icons.description_outlined,
              'Report cards',
              const Color(0xFFF0EDFF),
            ),
            const SizedBox(width: 8),
            _quickAction(
              Icons.receipt_long_outlined,
              'Fees',
              const Color(0xFFFFF3E0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickAction(
      IconData icon,
      String title,
      Color background,
      ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Connect each action to your existing tab/navigation.
        },
        borderRadius: BorderRadius.circular(9),
        child: _card(
          child: Row(
            children: [
              Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 16, color: green),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading('Coming up', 'Events'),
        const SizedBox(height: 8),
        _card(
          padding: const EdgeInsets.all(10),
          child: const Column(
            children: [
              _EventRow(
                day: '13',
                month: 'NOV',
                title: 'Parent-teacher meeting',
                subtitle: 'Mr. Adebayo Okafor · 10:00 AM',
              ),
              Divider(height: 18, color: borderColor),
              _EventRow(
                day: '20',
                month: 'NOV',
                title: 'Inter-house sports day',
                subtitle: 'All students · School field',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeading(String title, String trailing) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 9,
            color: green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _card({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class _ChildSelectorSheet extends StatelessWidget {
  const _ChildSelectorSheet({
    required this.children,
    required this.selectedChildId,
  });

  final List<ParentHomeChild> children;
  final String selectedChildId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD0D5DD),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Switch child',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 19),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...children.map((child) {
              final isSelected = child.id == selectedChildId;

              return InkWell(
                onTap: () => Navigator.pop(context, child),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFE8F5EE)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1A7A4A)
                          : const Color(0xFFECEFF2),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: child.initials == 'AN'
                            ? const Color(0xFFE8F1FF)
                            : const Color(0xFFF0EDFF),
                        child: Text(
                          child.initials,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: child.initials == 'AN'
                                ? const Color(0xFF2383E2)
                                : const Color(0xFF625BEB),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              child.name,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              child.className,
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF667085),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        size: 18,
                        color: isSelected
                            ? const Color(0xFF1A7A4A)
                            : const Color(0xFFD0D5DD),
                      ),
                    ],
                  ),
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // Connect your existing add-child flow here.
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Link another child'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                foregroundColor: const Color(0xFF344054),
                side: const BorderSide(
                  color: Color(0xFFECEFF2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
  });

  final String day;
  final String month;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 31,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5EE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A7A4A),
                ),
              ),
              Text(
                month,
                style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF1A7A4A),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right,
          size: 17,
          color: Color(0xFF98A2B3),
        ),
      ],
    );
  }
}

enum AttendanceStatus {
  registerNotTaken,
  present,
  absent,
}

enum ParentHomeItemType {
  fee,
  absence,
  other,
}

class ParentHomeChild {
  const ParentHomeChild({
    required this.id,
    required this.name,
    required this.className,
    required this.initials,
  });

  final String id;
  final String name;
  final String className;
  final String initials;
}

class ParentHomeItem {
  const ParentHomeItem({
    required this.id,
    required this.type,
    required this.title,
    required this.actionLabel,
    this.subtitle,
    this.onTap,
  });

  final String id;
  final ParentHomeItemType type;
  final String title;
  final String? subtitle;
  final String actionLabel;
  final VoidCallback? onTap;
}