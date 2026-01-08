import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/welcome_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_actions.dart';

// Contenu de la page d'accueil (sans Scaffold, sans BottomNav)
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // En-tête personnalisé
          const HomeHeader(),
          const SizedBox(height: 8),
          // Carte de bienvenue
          WelcomeCard(
            onPackagePressed: () {
              // Ne pas utiliser Navigator.push, juste afficher un message
              // La navigation se fera via la bottomNavBar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliquez sur "Forfaits" dans le menu'),
                ),
              );
            },
          ),
          // Statistiques
          const StatsCard(),
          // Actions rapides
          QuickActionsCard(
            onBuyPackage: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cliquez sur "Forfaits" dans le menu'),
                ),
              );
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