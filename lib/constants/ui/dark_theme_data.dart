import 'package:flutter/material.dart';
part 'dark_theme_color.dart';

class DarkTheme {
  static ThemeData themeData(context) {
    String _selectedFontFamily = 'Tondo';
    return ThemeData.dark().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionHandleColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: labelColor, circularTrackColor: Colors.black),
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent),
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
            headlineSmall: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                color: Colors.white)
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
