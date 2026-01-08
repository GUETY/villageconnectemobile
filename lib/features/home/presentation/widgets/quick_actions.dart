import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Widget pour les actions rapides
class QuickActionsCard extends StatelessWidget {
  final VoidCallback onBuyPackage;
  final VoidCallback onScanCode;

  const QuickActionsCard({
    super.key,
    required this.onBuyPackage,
    required this.onScanCode,
  });

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
            'Actions Rapides',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          // Action 1 : Acheter forfait
          _QuickActionButton(
            icon: Icons.shopping_bag,
            title: 'Acheter un Forfait',
            subtitle: 'Choisir et payer en ligne',
            color: AppColors.primary,
            onPressed: onBuyPackage,
          ),
          const SizedBox(height: 12),
          // Action 2 : Scanner code
          _QuickActionButton(
            icon: Icons.qr_code_scanner,
            title: 'Scanner Code',
            subtitle: 'Code reçu par SMS/WhatsApp',
            color: const Color(0xFFB946EF), // Violet
            onPressed: onScanCode,
            showTrailing: true,
          ),
        ],
      ),
    );
  }
}

// Widget interne pour un bouton d'action
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onPressed;
  final bool showTrailing;

  const _QuickActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onPressed,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Icône
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.white, size: 20),
              ),
              const SizedBox(width: 12),
              // Texte
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              // Icône trailing (optionnel)
              if (showTrailing)
                const Icon(Icons.more_vert, color: AppColors.textLight),
            ],
          ),
        ),
      ),
    );
  }
}