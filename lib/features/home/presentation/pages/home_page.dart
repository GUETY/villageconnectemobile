import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// Importation de tes widgets personnalisés
import '../widgets/home_header.dart';   
import '../widgets/welcome_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_actions.dart'; // Ou quick_actions_card.dart selon ton fichier

// Cette page n'affiche QUE le contenu de l'accueil (Cartes, Stats...)
// Elle délègue la navigation au parent (MainScreen)
class HomePageContentOnly extends StatelessWidget {
  final VoidCallback onGoToPackages;
  final VoidCallback onGoToScanner;

  const HomePageContentOnly({
    super.key,
    required this.onGoToPackages,
    required this.onGoToScanner,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // L'AppBar est ici pour l'accueil spécifiquement
      appBar: AppBar(
        title: const Text('Village Connecté'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const HomeHeader(), 
            
            const SizedBox(height: 16),
            
            // Carte Bienvenue
            WelcomeCard(
              onPackagePressed: onGoToPackages, 
            ),
            
            const SizedBox(height: 16),
            
            // Carte Stats
            const StatsCard(),
            
            const SizedBox(height: 16),
            
            // Actions Rapides
            QuickActionsCard(
              onBuyPackage: onGoToPackages,
              onScanCode: onGoToScanner,
            ), 
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}