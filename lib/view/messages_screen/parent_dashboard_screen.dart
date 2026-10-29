
import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/messages_screen/place_holder-tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../home_screens/home_screen.dart';
import '../more_screens/profile_screen.dart';
import '../more_screens/settings_screen.dart';
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
  bool showingSettings = false;

  late final List<Widget> screens = [
    ParentHomeScreen(),
    //const PlaceholderTabScreen(title: 'Home'),
    const PlaceholderTabScreen(title: 'Academics'),
    const PlaceholderTabScreen(title: 'Fees'),
    const ParentMessagesScreen(),
    ProfileScreen(
      onOpenSettings: () {
        setState(() {
          showingSettings = true;
        });
      },
    ),
  ];

  void _selectTab(int index) {
    setState(() {
      selectedIndex = index;
      showingSettings = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      body: showingSettings && selectedIndex == 4
          ? ParentSettingsScreen(
        onBack: () {
          setState(() {
            showingSettings = false;
          });
        },
      )
          : IndexedStack(
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
                navItem(3, 'Messages', AppSvgs.messageDouble),
                navItem(4, 'More', AppSvgs.avatar),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(int index, String label, String svg) {
    final theme = ref.watch(appThemeProvider);
    final textTheme = ref.watch(appTextProvider);
    final selected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _selectTab(index),
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
            SvgPicture.asset(
              svg,
              colorFilter: ColorFilter.mode(
                selected ? theme.primaryColor : theme.body2Color,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: selected
                  ? textTheme.smallerTextWithPrimaryColor(theme)
                  : textTheme.body2ColorText(theme),
            ),
          ],
        ),
      ),
    );
  }
}