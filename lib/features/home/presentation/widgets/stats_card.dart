import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Widget pour afficher les statistiques
class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          const Text(
            'Mes Statistiques',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          // Grille de stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              // Stat 1 : Argent dépensé
              _StatItem(
                label: 'FCFA dépensés',
                value: '15 600',
              ),
              // Stat 2 : Sessions
              _StatItem(
                label: 'Sessions total',
                value: '24',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sous-texte
          const Text(
            'Forfait valide - 3 Heures Standard',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget interne pour une statistique individuelle
class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}