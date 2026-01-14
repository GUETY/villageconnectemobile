import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../auth/pages/login_page.dart';

// Importation des pages
import '../../home/presentation/pages/home_page.dart'; // Contient HomePageContentOnly
import '../../packages/pages/packages_page.dart';
import '../../scanner/pages/qr_scanner_page.dart'; // IMPORTANT : importer le scanner ici
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // Fonction pour naviguer vers une page spécifique
  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Ajoutez cette fonction dans _MainScreenState
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime le token et les infos
    
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false, // Supprime tout l'historique de navigation
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Définition des pages
    // Note : On ne peut pas utiliser 'const' ici car on passe des fonctions callback
    final List<Widget> pages = [
      // Index 0 : Accueil (avec callbacks pour naviguer)
      HomePageContentOnly(
        onGoToPackages: () => _navigateToPage(1), // Aller aux forfaits
        onGoToScanner: () {
          // Scanner est une page modale ou une page à part ?
          // Si c'est un onglet (cas idéal), il faudrait l'ajouter à la navbar.
          // Pour l'instant, on ouvre le scanner en plein écran par dessus :
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRScannerPage()),
          );
        },
      ),
      
      // Index 1 : Forfaits
      const PackagesPageContent(),
      
      // Index 2 : Historique
      const HistoryPageContent(),
      
      // Index 3 : Aide
      const HelpPageContent(),
    ];

    // Titres pour l'AppBar (sauf accueil qui a la sienne)
    final List<String> titles = [
      '',                 // Titre géré par HomePageContentOnly
      'Nos Forfaits',
      'Historique',
      'Aide & Support',
    ];

    return Scaffold(
      // AppBar globale (affichée seulement si ce n'est pas l'accueil)
      appBar: _currentIndex == 0 
          ? null // L'accueil a sa propre AppBar dans HomePageContentOnly
          : AppBar(
              title: Text(titles[_currentIndex]),
              backgroundColor: AppColors.primary,
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                 // Ajout du bouton de déconnexion dans l'AppBar
                 IconButton(
                   icon: const Icon(Icons.logout),
                   onPressed: _logout,
                   tooltip: 'Se déconnecter',
                 ),
              ],
            ),
      
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _navigateToPage,
      ),
    );
  }
}