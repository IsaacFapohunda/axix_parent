
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'chat_screen.dart';
import 'events_screen.dart';
import 'meeting_screen.dart';
import 'messages_widget/bordered_input.dart';
import 'messages_widget/green_button.dart';
import 'messages_widget/parent_holder.dart';
import 'messages_widget/screen_title.dart';
import 'new_message_screen.dart';

class ParentMessagesScreen extends ConsumerStatefulWidget {
  const ParentMessagesScreen({super.key});

  @override
  ConsumerState<ParentMessagesScreen> createState() => _ParentMessagesScreenState();
}

class _ParentMessagesScreenState extends ConsumerState<ParentMessagesScreen> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> messages = [
    {
      'name': 'Mr. Adebayo Okafor',
      'role': 'Class teacher',
      'message': 'Thanks - I’ll share the Physics practical...',
      'time': '15:55',
      'initials': 'MA',
      'color': const Color(0xFFB42318),
      'unread': true,
    },
    {
      'name': 'Bursary',
      'role': 'Accounts office',
      'message': 'Your payment plan request has been received.',
      'time': '15:55',
      'initials': 'B',
      'color': const Color(0xFF2C93FF),
      'unread': false,
    },
    {
      'name': 'Mrs. Funmi Adeyemi',
      'role': 'Class teacher',
      'message': 'Child did very well in the spelling quiz...',
      'time': 'Apr 6',
      'initials': 'MF',
      'color': const Color(0xFF1A7A4A),
      'unread': false,
    },
    {
      'name': 'School Nurse',
      'role': 'Clinic',
      'message': 'Please remember to update the health form.',
      'time': 'Apr 6',
      'initials': 'N',
      'color': const Color(0xFFF59E0B),
      'unread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {

    final appColortheme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);


    return Scaffold(
      appBar: AppBar(
        primary: false,
        toolbarHeight: 168,
        titleSpacing: 0,
        backgroundColor: appColortheme.appBarWhite,
        title: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 39.5,),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

             parentHeader(context, ref),
              SizedBox(height: 24,),
              screenTitle(context, 'Messages', 'Teachers and school offices', ref),
            ],
          ),
        ),
      ),
      backgroundColor: appColortheme.scaffoldColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Row(
              children: [
                categoryTab('Messages', 0, ref),
                categoryTab('Meetings', 1, ref),
                categoryTab('Events', 2, ref),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (selectedTab == 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: borderedInput(
                hint: 'Search messages',
                icon: Icons.search,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  ...messages.map((item) => _messageTile(item, context, ref)),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: greenButton(
                      label: 'New message',
                      icon: Icons.add,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const NewMessageBottomSheet(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]
          else if (selectedTab == 1) ...[
            const Expanded(
              child: MeetingsScreen(),
            ),
          ] else ...[
            const Expanded(
              child: EventsScreen(),
            ),
          ],
          // if (selectedTab == 0) ...[
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: borderedInput(
          //       hint: 'Search messages',
          //       icon: Icons.search,
          //     ),
          //   ),
          //   const SizedBox(height: 10),
          //   Expanded(
          //     child: ListView(
          //       padding: const EdgeInsets.symmetric(horizontal: 14),
          //       children: [
          //         ...messages.map((item) => _messageTile(item, context, ref)),
          //         const SizedBox(height: 8),
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 6),
          //           child: greenButton(
          //             label: 'New message',
          //             icon: Icons.add,
          //             onTap: () =>
          //             showModalBottomSheet(context: context,
          //                 builder: (context) => NewMessageBottomSheet()),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ]
          // else if (selectedTab == 1) ...[
          //   const Expanded(child: MeetingsScreen(embedded: true)),
          // ] else ...[
          //   const Expanded(child: EventsScreen(embedded: true)),
          // ],
        ],
      ),
    );
  }

  Widget categoryTab(String label, int index, WidgetRef ref) {
    final selected = selectedTab == index;
    final appColortheme = ref.watch(appThemeProvider);
    final appTextTheme = ref.watch(appTextProvider);


    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: InkWell(
        onTap: () => setState(() => selectedTab = index),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF1A7A4A) : Colors.white,
            border: Border.all(
              color: selected
                  ?  appColortheme.primaryColor
                  :  Color(0xFFE4E7EC),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: appTextTheme.whiteText(context, fontSize: 14, fontweight:
            FontWeight.w600, color: selected ? Colors.white : Color(0xFF67707E))

          ),
        ),
      ),
    );
  }

  Widget _messageTile(Map<String, dynamic> item,
      BuildContext context,
      WidgetRef ref) {
    final appThemeColor = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            name: item['name'] as String,
            role: item['role'] as String,
            initials: item['initials'] as String,
            avatarColor: item['color'] as Color,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
        height: 79,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFECEFF2)),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: item['color'] as Color,
              child: Text(
                item['initials'] as String,
                style: appTextThemeProvider.whiteText(context, fontSize: 14),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextThemeProvider.bodyBlack(context,
                        fontSize: 14,
                        fontweight: FontWeight.w700)
                  ),
                  Text(
                    item['role'] as String,
                    style: appTextThemeProvider.body2ColorText(appThemeColor, fontSize: 11, fontweight: FontWeight.w500),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['message'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextThemeProvider.bodyBlack(context, fontSize: 12, fontweight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item['time'] as String,
                  style: appTextThemeProvider.smallTextWithPrimaryColor(appThemeColor, fontweight: FontWeight.w500, fontSize: 12 )
                ),
                if (item['unread'] == true) ...[
                  const SizedBox(height: 7),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: appThemeColor.primaryColor,
                    child: Text(
                      '1',
                      style: appTextThemeProvider.whiteText(context, fontSize: 11, fontweight: FontWeight.w700),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}