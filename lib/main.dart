import 'package:axix_parent_app/core/theme/app_colors.dart';
import 'package:axix_parent_app/view/login_screens/pin_login.dart';
import 'package:axix_parent_app/view/login_screens/welcome_screen.dart';
import 'package:axix_parent_app/view/messages_screen/messages_home_screen.dart';
import 'package:axix_parent_app/view/messages_screen/parent_dashboard_screen.dart';
import 'package:axix_parent_app/view/more_screens/payment_method_screen.dart';
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
      home: ParentDashboardScreen()
      //ChatScreen(name: '', role: '', initials: '', avatarColor: Colors.red,),
        //ChatScreen(name: '', role: '', initials: '', avatarColor: Colors.white,)
    );
  }
}