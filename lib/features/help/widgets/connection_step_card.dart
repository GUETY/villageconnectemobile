import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../help_entity.dart';

class ConnectionStepCard extends StatelessWidget {
  final ConnectionStep step;

  const ConnectionStepCard({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numéro ou icône de complétion
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: step.isCompleted ? AppColors.success : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: step.isCompleted
                  ? const Icon(Icons.check, color: AppColors.white, size: 22)
                  : Text(
                      '${step.number}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Titre et description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
