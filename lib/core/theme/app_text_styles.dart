import 'package:axix_parent_app/core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


final appTextProvider = ChangeNotifierProvider<AppTextStyles>((ref) {
  return AppTextStyles();
});
class AppTextStyles extends ChangeNotifier{

  ///headline1
  TextStyle axixLogo(BuildContext context) {
    return GoogleFonts.solway(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  ///headline2
  TextStyle headingBlack(BuildContext context, {
    FontWeight fontweight = FontWeight.w700, double fontSize = 24}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }


  TextStyle bodyBlack(BuildContext context,{
    FontWeight fontweight = FontWeight.w600, double fontSize = 14}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }



  TextStyle whiteText(BuildContext context,{
    FontWeight fontweight = FontWeight.w700, double fontSize = 10, Color color = Colors.white}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontweight,
      color: color,
      height:1.4
    );
  }





   TextStyle bodyGrey(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onTertiary,
    );
  }

 TextStyle bodyWithPrimaryColor(BuildContext context) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.primary,
    );
  }

   TextStyle bodyWithOffWhiteColor(AppThemeController theme) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
     color: theme.offWhiteColor,
    );
  }

   TextStyle body3ColorText(AppThemeController theme){
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: theme.body3Color,
    );
  }

   TextStyle body2ColorText(AppThemeController theme){
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: theme.body2Color,
    );
  }


   TextStyle smallerTextWithPrimaryColor(AppThemeController theme){
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: theme.primaryColor,
    );
  }

   TextStyle smallTextWithPrimaryColor(AppThemeController theme){
    return GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: theme.primaryColor,
    );
  }


   TextStyle appBarBackColor(AppThemeController theme){
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: theme.backColor,
    );
  }

}