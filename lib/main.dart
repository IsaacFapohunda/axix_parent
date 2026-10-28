import 'package:axix_parent_app/core/theme/app_colors.dart';
import 'package:axix_parent_app/view/create_pin_screen.dart';
import 'package:axix_parent_app/view/home_screen.dart';
import 'package:axix_parent_app/view/invite_code_screen.dart';
import 'package:axix_parent_app/view/messages/chat_screen.dart';
import 'package:axix_parent_app/view/messages/events_details_screen.dart';
import 'package:axix_parent_app/view/messages/messages_home_screen.dart';
import 'package:axix_parent_app/view/messages/no_message_screen.dart';
import 'package:axix_parent_app/view/messages/parent_dashboard_screen.dart';
import 'package:axix_parent_app/view/pin_login.dart';
import 'package:axix_parent_app/view/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ref.watch(appThemeProvider).theme,

      debugShowCheckedModeBanner: false,
      home: ParentChildSelectionScreen()
      //CreatePinScreen(),
        //ChatScreen(name: '', role: '', initials: '', avatarColor: Colors.white,)
    );
  }
}