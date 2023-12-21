// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// WARNA
const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFaF8FC);
const appOrange = Color(0xFFE6704A);

// TEMA
ThemeData light = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurple,
  ),
);

ThemeData dark = ThemeData(
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: appWhite,
    ),
    bodyText2: TextStyle(
      color: appWhite,
    ),
  ),
);
