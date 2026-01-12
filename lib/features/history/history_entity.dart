import 'package:flutter/material.dart';

class HistoryItem {
  final String id;
  final String name;
  final String dateLabel;
  final String code;
  final int price;
  final String currency;
  final bool isActive;
  final String usageLabel;

  const HistoryItem({
    required this.id,
    required this.name,
    required this.dateLabel,
    required this.code,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.usageLabel,
  });

  Color statusColor() => isActive ? Colors.green : Colors.grey;
  String statusText() => isActive ? 'Actif' : 'Terminé';
}
