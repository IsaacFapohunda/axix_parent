
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final appThemeProvider = ChangeNotifierProvider<AppThemeController>((ref) {
  return AppThemeController();
});

class AppThemeController extends ChangeNotifier{

  final Dio _dio = Dio();



  ///this is for our sharedpreferences key, value pair
  static const String _scaffoldKey = "scaffoldColor";
  static const String _primaryKey  = "primaryColor";
  static const String _primary2Key = "primary2Color";
  static const String _headlineKey = "headlineColor";
  static const String _bodyKey     = "bodyColor";
  static const String _bodyGreyKey = "bodyGreyColor";
  static const String _offWhiteKey = "offWhiteColor";


  ///didnt save these ones to prefs
  //static const String _appBarWhite = "appBarWhite;
  // static const String _body2Key = "body2Color";
  // static const String _body3Key = "body3Color";
  // static const String _backKey = "backColor";
  // static const String _greyBorder = "greyBorderColor";


  ///Default Colors
   Color _scaffoldColor = const Color(0xFFF7F7F7);
   Color _primaryColor = const Color(0xFF1A7A4A);
   Color _primary2Color = const Color(0xFFE8F5EE);
   Color _headlineColor = const Color(0xFF000000);
   Color _bodyColor = const Color(0xFF070D17);
   Color _bodyGreyColor = const Color(0xFF98A2B3);



   Color _offWhiteColor = const Color(0xFFF9F9F9);
   final Color _appBarWhite     = const Color(0xFFFAFFFC);
   final Color _body2Color        = const Color(0xFF98A2B3);
   final Color _body3Color       = const Color(0xFF67707E);
   final Color _backColor       = const Color(0xFF072E1C);
   final Color _greyBorderColor = const Color(0xFFE4E7EC);
   final Color _errorRedColor = const Color(0xFFDD524D);
   final Color _whiteColor = const Color(0xFFFFFFFF);
   final Color _paleyellow = const Color(0xFFFEF6E7);
   final Color _burntYellow = const Color(0xFFC57D00);



  Color get scaffoldColor => _scaffoldColor;
  Color get primaryColor =>  _primaryColor;
  Color get primary2Color => _primary2Color;
  Color get bodyGreyColor => _bodyGreyColor;
  Color get headlineColor => _headlineColor;
  Color get bodyColor     => _bodyColor;
  Color get offWhiteColor => _offWhiteColor;

  Color get burntYellow => _burntYellow;
  Color get paleyellow => _paleyellow;
 Color get appBarWhite => _appBarWhite;
 Color get body2Color => _body2Color;
 Color get body3Color => _body3Color;
 Color get backColor => _backColor;
 Color get greyBorderColor => _greyBorderColor;
 Color get errorRedColor => _errorRedColor;
 Color get whiteColor => _whiteColor;


  static const List<Color> avatarPallete = [
    Color(0xFF2C93FF),
    Color(0xFF5D5FEF),
    Color(0xFF1A7A4A),
    Color(0xFFF59E0B),
  ];

  static Color getAvatarColor(String fullName){
    final hash = fullName.hashCode;
    return avatarPallete[hash.abs() %  avatarPallete.length];
  }

  ThemeData get theme{
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        onPrimary: _primary2Color,
        surface: scaffoldColor,
        onSurface: headlineColor,
        tertiary: _bodyColor,
        onTertiary: _bodyGreyColor,

      ),
      scaffoldBackgroundColor: scaffoldColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _appBarWhite
      )
    );
  }


  ///convert backend color to flutter color
  Color _parseColor(String value){
    String hex = value.trim().replaceAll('#', '');
    if(hex.length == 6){
      hex = 'FF$hex';
    }
    if(hex.length != 8){
      throw FormatException('Invalid color: $value');
    }
    return Color(int.parse(hex, radix: 16));
  }


  ///Load previously saved colors
  Future<void> loadCachedColors() async {
    try{
      final prefs = await SharedPreferences.getInstance();


      final scaffold = prefs.getString(_scaffoldKey);
      final primary  = prefs.getString(_primaryKey);
      final bodyGrey = prefs.getString(_bodyGreyKey);
      final headline = prefs.getString(_headlineKey);
      final body     = prefs.getString(_bodyKey);
      final primary2 = prefs.getString(_primary2Key);

      ///use default if nothing is cached
      if(scaffold == null ||
          primary == null ||
          bodyGrey == null ||
          headline == null ||
          body == null ||
          primary2 == null
      ){
        return;
      }

      ///parse colors
      final cachedScaffold   = _parseColor(scaffold);
      final cachedPrimary    = _parseColor(primary);
      final cachedBodyGrey   = _parseColor(bodyGrey);
      final cachedHeadLine   = _parseColor(headline);
      final cachedBody       = _parseColor(body);
      final cachedprimary2  = _parseColor(primary2);

      _scaffoldColor =  cachedScaffold;
      _primaryColor = cachedPrimary;
      _bodyGreyColor = cachedBodyGrey;
      _headlineColor = cachedHeadLine;
      _bodyColor = cachedBody;
      _primary2Color = cachedprimary2;

      notifyListeners();
    } catch(e){
      debugPrint('Unable to load cached colors, $e');
    }

  }


  ///fetch colors from backend

  Future<void> updateColor() async {
    try{
      ///replace endpoint with
      final response = await _dio.get('.......');
      final data = Map<String, dynamic>.from(response.data as Map);

      ///edit this part based on what is being received from the backend
    final scaffold = data['scaffoldColor'] as String;
    final  primary = data['PrimaryColor'] as String;
    final primary2 = data['primary2Color'] as String;
    final  bodyGrey = data['bodyGreyColor'] as String;
    final  headline = data['headlineColor'] as String;
    final  body = data["bodyColor"] as String;

    ///parse as flutter color
      final parsedScaffold = _parseColor(scaffold);
      final parsedPrimary = _parseColor(primary);
      final parsedPrimary2 = _parseColor(primary2);
      final parsedBodyGrey = _parseColor(bodyGrey);
      final parsedHeadline = _parseColor(headline);
      final parsedBody = _parseColor(body);

      ///updating theme before saving
      _scaffoldColor = parsedScaffold;
      _primaryColor = parsedPrimary;
      _primary2Color = parsedPrimary2;
      _bodyGreyColor = parsedBodyGrey;
      _headlineColor = parsedHeadline;
      _bodyColor = parsedBody;

      notifyListeners();

      ///save colors for offline

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_scaffoldKey, scaffold);
      await prefs.setString(_primaryKey, primary);
      await prefs.setString(_primary2Key, primary2);
      await prefs.setString(_headlineKey, headline);
      await prefs.setString(_bodyKey, body);
      await prefs.setString(_bodyGreyKey, bodyGrey);

     }
     catch(e){
      debugPrint('Unable to update app colors: $e');

    }
  }


}