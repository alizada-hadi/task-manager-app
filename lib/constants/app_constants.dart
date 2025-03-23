import 'package:flutter/material.dart';

class AppConstants {
  static const String appTitle = "مدیریت وظایف";
  static const String taskListTitle = "لیست وظایف";
  static const String logoutTooltip = "خروج";
  static const String logoutSuccess = "با موفقیت خارج شدید";
  static const String noTasksFound = "هیچ وظیفه‌ای یافت نشد";

  static final ThemeData appTheme = ThemeData(
    primarySwatch: Colors.green,
    fontFamily: "Vazir",
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontFamily: 'Vazir'),
      headlineSmall: TextStyle(fontFamily: 'Vazir'),
    ),
  );
}
