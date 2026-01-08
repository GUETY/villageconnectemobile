import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../packages_repository.dart';
import '../widgets/package_card.dart';
import '../widgets/packages_header.dart';

// Contenu de la page forfaits (sans Scaffold, sans BottomNav)
class PackagesPageContent extends StatelessWidget {
  const PackagesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupérer tous les forfaits disponibles
    final packages = PackagesRepository.getAll();

    return SingleChildScrollView(
      child: Column(
        children: [
          // --- En-tête avec gradient ---
          Container(
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
                Row(
                  children: const [
                    // Icône Wi-Fi
                    Icon(Icons.wifi, color: AppColors.white, size: 24),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre principal
                        Text(
                          'Wi-Fi Communautaire',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Sous-titre
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
                // Icône utilisateur
                const CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person, color: AppColors.primary),
                ),
              ],
            ),
          ),

          // Titre de section "Nos Forfaits"
          const PackagesHeader(),

          // Liste des cartes de forfaits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: packages.length,
            itemBuilder: (context, index) {
              return PackageCard(
                package: packages[index],
                onBuyPressed: () {
                  // Action lors du clic sur "Acheter maintenant"
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Achat de ${packages[index].name} lancé'),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}