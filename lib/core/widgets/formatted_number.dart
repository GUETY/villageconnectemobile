import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/number_formatter.dart';

// Widget pour afficher un nombre formaté de manière stylisée
class FormattedNumber extends StatelessWidget {
  final double number;           // Le nombre à afficher
  final String? suffix;          // Suffixe (ex: "FCFA", "€")
  final TextStyle? style;        // Style personnalisé (optionnel)
  final bool bold;               // Texte gras
  final Color color;             // Couleur du texte

  const FormattedNumber(
    this.number, {
    super.key,
    this.suffix,
    this.style,
    this.bold = true,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    // Formater le nombre avec séparateurs
    final formatted = NumberFormatter.formatCurrency(number);
    
    // Construire le texte final
    final text = suffix != null ? '$formatted $suffix' : formatted;

    return Text(
      text,
      style: style ??
          TextStyle(
            fontSize: 20,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
    );
  }
}