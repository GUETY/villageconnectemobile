import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/welcome_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_actions.dart';

// Contenu de la page d'accueil (sans Scaffold, c'est MainScreen qui le fournit)
class HomePageContent extends StatelessWidget {
  // Callback pour naviguer vers la page Forfaits
  final VoidCallback? onNavigateToPackages;

  const HomePageContent({
    super.key,
    this.onNavigateToPackages,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // En-tête personnalisé
          const HomeHeader(),
          const SizedBox(height: 8),
          
          // Carte de bienvenue avec callback
          WelcomeCard(
            // Passer directement la callback (ou une fonction vide si null)
            onPackagePressed: onNavigateToPackages ?? () {},
          ),
          
          // Statistiques
          const StatsCard(),
          
          // Actions rapides
          QuickActionsCard(
            onBuyPackage: () {
              // Appeler la callback pour naviguer vers Forfaits
              onNavigateToPackages?.call();
            },
            onScanCode: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanner un code')),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}