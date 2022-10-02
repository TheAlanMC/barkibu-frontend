import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff52B9E2);
  static const Color secondary = Colors.grey;
  static const Color alert = Color(0xffED4B4B);
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(color: primary, elevation: 0),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
      ),
      backgroundColor: Colors.grey[200],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: primary, shape: const StadiumBorder(), elevation: 0)),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
        labelStyle: TextStyle(color: secondary),
      ));
}
