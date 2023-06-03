import 'package:flutter/material.dart';
part 'light_theme_color.dart';

class LightTheme {
  static ThemeData themeData(context) {
    // const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    //     contentPadding: EdgeInsets.all(10),
    //     iconColor: primaryColor,
    //     enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(width: 0.8, color: primaryColor)));
    String _selectedFontFamily = 'Tondo';
    return ThemeData.light().copyWith(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: labelColor, circularTrackColor: Colors.grey),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        primaryColor: primaryColor,
        textTheme: TextTheme(
          // labelLarge: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 18.0,
          //     color: labelColor),
          // labelMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 16.0,
          //     color: labelColor),
          // labelSmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     color: labelColor),
          // displayLarge: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // displayMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // displaySmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          bodyLarge: TextStyle(
              fontFamily: _selectedFontFamily,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
              color: labelColor),
          bodyMedium: TextStyle(
              fontFamily: _selectedFontFamily,
              fontSize: 14.0,
              color: labelColor),
          bodySmall: TextStyle(
              fontFamily: _selectedFontFamily,
              fontSize: 12.0,
              color: labelColor),
          // titleLarge: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 22.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // titleMedium: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
          // titleSmall: TextStyle(
          //     fontFamily: _selectedFontFamily,
          //     fontSize: 14.0,
          //     fontWeight: FontWeight.bold,
          //     color: labelColor),
        ));
  }
}
