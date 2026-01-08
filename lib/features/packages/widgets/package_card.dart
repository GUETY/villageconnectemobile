import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart'; // correction du chemin
import '../package_entity.dart';

// Carte affichant un forfait
class PackageCard extends StatelessWidget {
  final PackageEntity package;
  final VoidCallback onBuyPressed;

  const PackageCard({
    super.key,
    required this.package,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        // Bordure bleue si populaire, gris clair sinon
        border: Border.all(
          color: package.isPopular ? AppColors.primary : AppColors.greyLight,
          width: package.isPopular ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- En-tête : nom + description + badge ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nom du forfait
                      Text(
                        package.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Description courte
                      Text(
                        package.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Badge "Populaire" si nécessaire
                if (package.isPopular)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Populaire',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // --- Détails techniques (durée, débit, appareils, support) ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _DetailItem(
                        icon: Icons.schedule,
                        label: 'Durée',
                        value: '${package.duration} heures',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _DetailItem(
                        icon: Icons.speed,
                        label: 'Débit',
                        value: '${package.speed.toStringAsFixed(0)} Mbps',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _DetailItem(
                        icon: Icons.devices,
                        label: 'Appareils',
                        value: '${package.devices} appareils',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _DetailItem(
                        icon: Icons.headset_mic,
                        label: 'Support',
                        value: package.support,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // --- Prix et bouton d'achat ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Ligne prix
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Prix',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      '${package.price.toStringAsFixed(0)} FCFA',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Bouton "Acheter maintenant"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBuyPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: package.isPopular
                          ? AppColors.primary
                          : AppColors.greyLight,
                      foregroundColor: package.isPopular
                          ? AppColors.white
                          : AppColors.textDark,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Acheter maintenant'),
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

// Élément de détail (icône + label + valeur)
class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label (petit)
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                ),
              ),
              // Valeur (plus visible)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}