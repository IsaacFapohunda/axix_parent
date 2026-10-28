
import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/home_screen.dart';
import 'package:axix_parent_app/view/messages/parent_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'chat_screen.dart';
import 'messages_widget/bordered_input.dart';
import 'messages_widget/green_button.dart';
import 'messages_widget/parent_holder.dart';
import 'messages_widget/screen_title.dart';

class NoMessageScreen extends ConsumerStatefulWidget {
  const NoMessageScreen({super.key});

  @override
  ConsumerState<NoMessageScreen> createState() => _NoMessageScreenState();
}

class _NoMessageScreenState extends ConsumerState<NoMessageScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {

    final appColortheme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 168,
        backgroundColor: appColortheme.appBarWhite,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            parentHeader(context, ref),
            SizedBox(height: 24,),
            screenTitle(context, 'Messages', 'Teachers and school offices', ref),
          ],
        ),
      ),
      backgroundColor: appColortheme.scaffoldColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
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

            const SizedBox(height: 10),

            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(7.27),
              decoration: BoxDecoration(
                color: appColortheme.paleyellow,
                borderRadius: BorderRadius.circular(10.39),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(AppSvgs.messageDouble,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(appColortheme.burntYellow, BlendMode.srcIn),
                ),
              ),
            ),
            
            Text('No messages yet', style: appTextThemeProvider.headingBlack(context, fontSize: 16),),

            SizedBox(height: 6,),
            SizedBox(width: 308,child: Text(
                'Message Adaeze\'s teachers or the school office. \nReplies come here and to your notifications.',
              textAlign: TextAlign.center,
              style: appTextThemeProvider.body3ColorText(appColortheme),
            )),
            SizedBox(height: 32,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: greenButton(
                      label: 'New message',
                      icon: Icons.add,
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()
                              //const NewMessageScreen(),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ]
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
            style: TextStyle(
              fontSize: 10,
              color: selected ? Colors.white : const Color(0xFF67707E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageTile(Map<String, dynamic> item) {
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
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFECEFF2)),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: item['color'] as Color,
              child: Text(
                item['initials'] as String,
                style: const TextStyle(fontSize: 10, color: Colors.white),
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
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item['role'] as String,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['message'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10),
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
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF1A7A4A),
                  ),
                ),
                if (item['unread'] == true) ...[
                  const SizedBox(height: 7),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(0xFF1A7A4A),
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 7, color: Colors.white),
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