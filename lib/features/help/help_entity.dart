import 'package:flutter/material.dart';

// Étape de connexion
class ConnectionStep {
  final int number;
  final String title;
  final String description;
  final bool isCompleted;

  const ConnectionStep({
    required this.number,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

// Question fréquente (FAQ)
class FaqItem {
  final IconData icon;
  final String question;
  final String answer;

  const FaqItem({
    required this.icon,
    required this.question,
    required this.answer,
  });
}
