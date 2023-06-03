import 'package:flutter/material.dart';
part 'light_theme_color.dart';

class LightTheme {
  static ThemeData themeData(context) {
    // const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    //     contentPadding: EdgeInsets.all(10),
    //     iconColor: primaryColor,
    //     enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(width: 0.8, color: primaryColor)));
    return ThemeData.light().copyWith(
        // inputDecorationTheme: inputDecorationTheme,
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: labelColor),
          labelMedium: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: labelColor),
          labelSmall: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
          displayLarge: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: labelColor),
          displayMedium: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: labelColor),
          displaySmall: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
          bodyLarge: TextStyle(fontSize: 16.0, color: labelColor),
          bodyMedium: TextStyle(fontSize: 14.0, color: labelColor),
          bodySmall: TextStyle(fontSize: 12.0, color: labelColor),
          titleLarge: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: labelColor),
          titleMedium: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: labelColor),
          titleSmall: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.bold, color: labelColor),
        ));
  }
}
