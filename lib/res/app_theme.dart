import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color allports50 = Color(0xFFF2F9FD);
  static const Color allports100 = Color(0xFFE3F1FB);
  static const Color allports200 = Color(0xFFC1E4F6);
  static const Color allports300 = Color(0xFF8ACEEF);
  static const Color allports400 = Color(0xFF4CB6E4);
  static const Color allports500 = Color(0xFF259DD2);
  static const Color allports600 = Color(0xFF1679AB);
  static const Color allports700 = Color(0xFF146590);
  static const Color allports800 = Color(0xFF145578);
  static const Color allports900 = Color(0xFF164764);
  static const Color allports950 = Color(0xFF0F2E42);

  static ThemeData get themeData {
    return ThemeData(
        primaryColor: allports300,
        scaffoldBackgroundColor: allports200,
        appBarTheme: const AppBarTheme(
          backgroundColor: allports800,
          centerTitle: true,
          titleTextStyle: TextStyle(color: allports100, fontSize: 20),
        ),
        textTheme: GoogleFonts.ubuntuTextTheme(const TextTheme(
            displayLarge:
                TextStyle(color: allports950, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(
                color: allports950, fontWeight: FontWeight.bold, fontSize: 25),
            titleLarge:
                TextStyle(color: allports100, fontWeight: FontWeight.w500),
            titleMedium: TextStyle(color: allports900, fontSize: 20),
            bodyLarge: TextStyle(color: allports100, fontSize: 20),
            bodyMedium: TextStyle(color: allports100, fontSize: 16),
            bodySmall: TextStyle(color: allports100, fontSize: 13),
            labelLarge: TextStyle(color: allports900, fontSize: 16))),
        iconTheme: const IconThemeData(color: allports100, size: 18),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: allports400, fontSize: 16),
          labelStyle: TextStyle(color: allports900),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: allports100,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: allports900,
            secondary: allports400,
            surface: allports50,
            brightness: Brightness.light));
  }
}
