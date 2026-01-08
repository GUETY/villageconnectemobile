import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/formatted_number.dart';
import '../../../../core/widgets/svg_icon.dart';

// Widget pour afficher les statistiques
class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Marge externe
      margin: const EdgeInsets.all(16),
      // Padding interne
      padding: const EdgeInsets.all(16),
      // Décoration
      decoration: BoxDecoration(
        // Fond blanc
        color: AppColors.white,
        // Coins arrondis
        borderRadius: BorderRadius.circular(12),
        // Ombre subtile
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Titre "Mes Statistiques" ---
          const Text(
            'Mes Statistiques',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),

          // --- Grille de statistiques ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Stat 1 : Argent dépensé
              _StatsItemCard(
                svgIcon: 'assets/icons/money.svg', // ← Utiliser SVG
                label: 'dépensés',
                value: 15600,
                isCurrency: true,
              ),
              // Ligne de séparation
              Container(
                width: 1,
                height: 60,
                color: AppColors.greyLight,
              ),
              // Stat 2 : Sessions
              _StatsItemCard(
                svgIcon: 'assets/icons/clock.svg', // ← Utiliser SVG
                label: 'Sessions total',
                value: 24,
                isCurrency: false,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- Sous-texte (forfait actif) ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // Fond bleu clair
              color: AppColors.primaryLight,
              // Coins arrondis
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '✓ Forfait valide - 3 Heures Standard',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Widget interne pour une statistique individuelle ---
class _StatsItemCard extends StatelessWidget {
  final String svgIcon; // Chemin du SVG
  final String label; // Label (ex: "FCFA dépensés")
  final int value; // Valeur numérique
  final bool isCurrency; // True si c'est une devise (FCFA)

  const _StatsItemCard({
    required this.svgIcon,
    required this.label,
    required this.value,
    required this.isCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // --- Icône SVG colorée ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              // Fond bleu clair
              color: AppColors.primaryLight,
              // Forme circulaire
              shape: BoxShape.circle,
            ),
            child: SvgIcon(
              svgIcon,
              size: 24,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),

          // --- Nombre formaté (avec séparateurs) ---
          if (isCurrency)
            FormattedNumber(
              value.toDouble(),
              suffix: 'FCFA',
              color: AppColors.primary,
              bold: true,
            )
          else
            FormattedNumber(
              value.toDouble(),
              color: AppColors.primary,
              bold: true,
            ),
          const SizedBox(height: 8),

          // --- Label ---
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}