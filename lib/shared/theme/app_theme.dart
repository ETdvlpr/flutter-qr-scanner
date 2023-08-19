import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF454E9E);
  static const Color accentColor = Color(0xFFF8B219);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: primaryColor,
        ),
    fontFamily: 'SegoeUi',
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
  );
}
