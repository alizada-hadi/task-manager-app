import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_management/constants/app_constants.dart';
import 'package:task_management/screens/task_list_screen.dart';
import 'providers/auth_provider.dart';
import "providers/task_provider.dart";
import 'screens/auth_screens.dart'; // Adjusted to singular, confirm your filename

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const TaskManagement(),
    ),
  );
}

class TaskManagement extends StatelessWidget {
  const TaskManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: AppConstants.appTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa', 'AF')],
      locale: const Locale('fa', 'FA'),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.user == null) {
            return const AuthScreens(); // Adjusted to singular
          }
          return const TaskListScreen();
        },
      ),
    );
  }
}
