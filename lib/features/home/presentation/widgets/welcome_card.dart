import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Widget de carte de bienvenue avec CTA
class WelcomeCard extends StatelessWidget {
  final VoidCallback onPackagePressed;

  const WelcomeCard({
    super.key,
    required this.onPackagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          // Icône Wi-Fi
          const Icon(
            Icons.wifi,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          // Titre
          const Text(
            'Bienvenue !',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          const Text(
            'Achetez un forfait pour accéder à Internet haute vitesse dans votre zone',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 16),
          // Bouton
          ElevatedButton(
            onPressed: onPackagePressed,
            child: const Text('Voir les Forfaits'),
          ),
        ],
      ),
    );
  }
}