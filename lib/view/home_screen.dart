import 'package:axix_parent_app/core/utils/app_svgs.dart';
import 'package:axix_parent_app/view/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_text_styles.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final appColorTheme = ref.watch(appThemeProvider);
    final appTextThemeProvider = ref.watch(appTextProvider);


    return Scaffold(
      backgroundColor: appColorTheme.scaffoldColor,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 65,
            left: 32,
            right: 32,
            bottom: 48
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Container(
                    width: 34.33,
                    height: 33.25,
                    padding: const EdgeInsets.all(7.27),
                    decoration: BoxDecoration(
                      color: appColorTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10.39),
                    ),
                    child: SvgPicture.asset(AppSvgs.appLogo,
                    fit: BoxFit.contain,
                   ),
                  ),
                  const SizedBox(width: 5.19),
                  Text("AXIX", style: appTextThemeProvider.axixLogo(context)),
                ],
              ),
              const SizedBox(height: 88),
              Text(
                "Your child's school day, in your pocket",
                style:appTextThemeProvider.headingBlack(context)
              ),
              const SizedBox(height: 8),
              Text(
                "Attendance, timetable, fees and report cards for each of your children - straight from their school",
                style: appTextThemeProvider.bodyGrey(context)
              ),
              const SizedBox(height: 32),
              featureTile(context, appColorTheme, AppSvgs.squareMark, "Know the moment they're marked in"),
              const SizedBox(height: 8),
              featureTile(context, appColorTheme, AppSvgs.fees, "Pay fees and get receipts instantly"),
              const SizedBox(height: 8),
              featureTile(context, appColorTheme, AppSvgs.message, "Message teachers directly"),

              const Spacer(),



              AppButton(onPressed: (){

              },
                  label: 'Log in',
                  buttonColor: appColorTheme.primaryColor,
                  textStyle: appTextThemeProvider.bodyWithOffWhiteColor(appColorTheme)),

              const SizedBox(height: 12),

              AppButton(onPressed: (){},
                  label: 'I have an invite code',
                  buttonColor: appColorTheme.scaffoldColor,
                  borderColor: appColorTheme.primaryColor,
                  textStyle: appTextThemeProvider.bodyWithPrimaryColor(context)),


              // const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }


  Widget featureTile(BuildContext context,
      AppThemeController theme, String svg, String text) {
    final appTextThemeProvider = ref.watch(appTextProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 35, height: 35,
          decoration: BoxDecoration(
            color: theme.primary2Color,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(5),
          child: SvgPicture.asset(svg,
         fit: BoxFit.contain,
         ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: appTextThemeProvider.bodyBlack(context)),
        ),
      ],
    );
  }
}