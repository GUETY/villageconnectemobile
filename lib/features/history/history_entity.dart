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

  // Créer un HistoryItem depuis les données JSON de l'API
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id']?.toString() ?? '',
      name: json['nom'] ?? json['name'] ?? json['forfait'] ?? json['package_name'] ?? '',
      dateLabel: json['date'] ?? json['dateLabel'] ?? json['date_achat'] ?? json['created_at'] ?? '',
      code: json['code'] ?? json['code_acces'] ?? json['access_code'] ?? '',
      price: _parsePrice(json['prix'] ?? json['price'] ?? json['montant'] ?? 0),
      currency: json['devise'] ?? json['currency'] ?? 'FCFA',
      isActive: json['actif'] ?? json['isActive'] ?? json['active'] ?? json['status'] == 'actif' ?? false,
      usageLabel: json['utilisation'] ?? json['usageLabel'] ?? json['usage'] ?? json['temps_utilise'] ?? '0h 00min',
    );
  }

  // Parser le prix (peut être int ou String)
  static int _parsePrice(dynamic price) {
    if (price is int) return price;
    if (price is double) return price.toInt();
    if (price is String) return int.tryParse(price) ?? 0;
    return 0;
  }

  Color statusColor() => isActive ? Colors.green : Colors.grey;
  String statusText() => isActive ? 'Actif' : 'Terminé';
}
