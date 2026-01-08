import 'package:flutter/material.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../packages/pages/packages_page.dart';

// Écran principal qui gère la navigation entre pages
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index de la page active (0=Accueil, 1=Forfaits, 2=Historique, 3=Aide)
  int _currentIndex = 0;

  // Fonction pour naviguer vers une page spécifique
  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Liste des pages accessibles via la navigation
  late final List<Widget> _pages = [
    // Page Accueil avec callback pour naviguer vers Forfaits
    HomePageContent(
      onNavigateToPackages: () => _navigateToPage(1), // Navigue vers index 1 (Forfaits)
    ),
    // Page Forfaits
    const PackagesPageContent(),
    // TODO: Page Historique
    // TODO: Page Aide
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Afficher la page selon l'index actuel
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      
      // Barre de navigation inférieure
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Naviguer vers la page sélectionnée
          _navigateToPage(index);
        },
      ),
    );
  }
}