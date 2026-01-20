import 'package:flutter/material.dart';

class HistoryItem {
  final String id;
  final String name;
  final String description; // <-- Ajouté
  final String dateLabel;
  final String code;
  final int price;
  final String currency;
  final bool isActive;
  final String usageLabel;

  const HistoryItem({
    required this.id,
    required this.name,
    required this.description, // <-- Ajouté
    required this.dateLabel,
    required this.code,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.usageLabel,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      name: json['name'] ?? '', // ou json['package']?['name'] selon structure exacte
      description: json['description'] ?? '',
      dateLabel: json['createdAt'] ?? json['date'] ?? '',
      code: json['code'] ?? '',
      price: json['price'] ?? 0,
      currency: 'XOF', // adapte si tu as une clé currency
      isActive: !(json['used'] ?? false),
      usageLabel: (json['used'] ?? false) ? 'Utilisé' : 'Non utilisé',
    );
  }

  Color statusColor() => isActive ? Colors.green : Colors.grey;
  String statusText() => isActive ? 'Actif' : 'Terminé';
}
