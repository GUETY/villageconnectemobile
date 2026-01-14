import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Widget réutilisable pour la navigation inférieure
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Important pour 4 items
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi),
          label: 'Forfaits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historique',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: 'Aide',
        ),
      ],
    );
  }
}