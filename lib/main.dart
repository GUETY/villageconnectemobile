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
      home: const MainScreen(), // utiliser MainScreen au lieu de HomePage
      routes: {
        '/home': (_) => const MainScreen(initialIndex: 0),
        '/packages': (_) => const MainScreen(initialIndex: 1),
        '/history': (_) => const MainScreen(initialIndex: 2),
        '/help': (_) => const MainScreen(initialIndex: 3),
      },
    );
  }
}