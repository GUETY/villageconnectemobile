import 'package:flutter/material.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../packages/pages/packages_page.dart';
import '../../history/pages/main_history_page.dart';
import '../../help/pages/main_help_page.dart';

// Écran principal qui gère la navigation entre pages
class MainScreen extends StatefulWidget {
  // Permet d'ouvrir directement un onglet (0=Accueil, 1=Forfaits, 2=Historique, 3=Aide)
  const MainScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index de la page active (0=Accueil, 1=Forfaits, 2=Historique, 3=Aide)
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _clampIndex(widget.initialIndex);
  }

  int _clampIndex(int value) {
    if (value < 0) return 0;
    if (value >= _pages.length) return _pages.length - 1;
    return value;
  }

  // Fonction pour naviguer vers une page spécifique
  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = _clampIndex(index);
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
    // Page Historique
    const HistoryPageContent(),
    // Page Aide
    const HelpPageContent(),
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