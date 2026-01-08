import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Widget d'en-tête avec le titre du service
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône + texte principal
              Row(
                children: [
                  const Icon(Icons.wifi, color: AppColors.white, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Wi-Fi Communautaire',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Accès Internet Rural',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Icône utilisateur
          const CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(Icons.person, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}