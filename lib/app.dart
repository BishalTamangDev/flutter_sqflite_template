import 'package:flutter/material.dart';
import 'package:sqflite_git/config/theme/theme_constants.dart';
import 'package:sqflite_git/features/presentation/pages/home_page.dart';

class LocalDbApp extends StatelessWidget {
  const LocalDbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Database App",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
