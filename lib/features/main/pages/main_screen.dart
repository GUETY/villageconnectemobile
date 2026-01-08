import 'package:flutter/material.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../home/presentation/pages/home_page.dart';
import '../../packages/pages/packages_page.dart';

// Écran principal contenant toutes les pages avec navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // Index de la page active

  // Liste des pages accessibles via la navigation
  final List<Widget> _pages = const [
    HomePageContent(),      // Page Accueil
    PackagesPageContent(),  // Page Forfaits
    // TODO: Historique et Aide
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Afficher la page correspondant à l'index
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // Barre de navigation
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}