import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

// En-tête de la section "Nos Forfaits"
class PackagesHeader extends StatelessWidget {
  const PackagesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre principal de la section
          Text(
            'Nos Forfaits',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 8),
          // Slogan / sous-titre
          Text(
            'Choisissez l\'offre qui vous convient',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}