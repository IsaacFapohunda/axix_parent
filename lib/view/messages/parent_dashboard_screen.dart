
import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/messages/place_holder-tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'messages_home_screen.dart';



class ParentDashboardScreen extends ConsumerStatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  ConsumerState<ParentDashboardScreen> createState() =>
      _ParentDashboardScreenState();
}

class _ParentDashboardScreenState
    extends ConsumerState<ParentDashboardScreen> {
  int selectedIndex = 3;

  final List<Widget> screens = const [
    PlaceholderTabScreen(title: 'Home'),
    PlaceholderTabScreen(title: 'Academics'),
    PlaceholderTabScreen(title: 'Fees'),
    ParentMessagesScreen(),
    PlaceholderTabScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);


    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: theme.greyBorderColor),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
               navItem(0, 'Home', AppSvgs.home),
               navItem(1, 'Academics', AppSvgs.academics),
               navItem(2, 'Fees', AppSvgs.fees),
               navItem(3, 'Messages', AppSvgs.messageDouble,),
               navItem(4, 'Profile', AppSvgs.avatar),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(int index, String label, String svg,) {
    final theme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);

    final selected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedIndex = index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected)
              Container(
                width: 34,
                height: 2,
                margin: const EdgeInsets.only(bottom: 5),
                color: theme.primaryColor,
              )
            else
              const SizedBox(height: 7),
            SvgPicture.asset(svg, colorFilter: ColorFilter.mode(
                selected ? theme.primaryColor : theme.body2Color, BlendMode.srcIn),),

      SizedBox(height: 3),
            Text(
              label,
              style:  selected ? appTextThemeProvider.smallerTextWithPrimaryColor(theme): appTextThemeProvider.body2ColorText(theme)),
          ],
        ),
      ),
    );
  }
}