import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primarySwatch: Colors.orange,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF29B6F6),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  shadowColor: Colors.grey,
  backgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    errorStyle: const TextStyle(
      color: Colors.white,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFC4C4C4),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFC4C4C4),
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFC4C4C4),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Color(0xFFC4C4C4),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
  ),
);