import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/main/pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Village Connecté',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: const MainScreen(),
    );
  }
}