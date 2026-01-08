import 'package:intl/intl.dart';

// Utilitaire pour formater les nombres de manière belle
class NumberFormatter {
  // Formater un nombre entier avec séparateurs (ex: 15 600 au lieu de 15600)
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return formatter.format(amount);
  }

  // Formater un nombre simple avec séparateurs
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return formatter.format(number);
  }

  // Formater avec symbole FCFA
  static String formatPrice(double price) {
    final formatted = formatCurrency(price);
    return '$formatted FCFA';
  }

  // Formater la durée (ex: "3h 30min")
  static String formatDuration(int hours) {
    if (hours < 1) {
      return '${hours * 60} min';
    } else if (hours == 1) {
      return '1 heure';
    } else {
      return '$hours heures';
    }
  }
}