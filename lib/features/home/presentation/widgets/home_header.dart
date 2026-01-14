import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/pages/login_page.dart';

// Widget d'en-tête avec le titre du service
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  Future<void> _logout(BuildContext context) async {
    // 1. Supprimer les données locales
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      // 2. Rediriger vers la page de login en effaçant l'historique
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Partie Gauche : Titre et Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.wifi, color: AppColors.white, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Wi-Fi Communautaire',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
            ],
          ),

          // Partie Droite : Menu Utilisateur (Cliquable)
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout(context);
              }
            },
            offset: const Offset(0, 40), // Décale le menu sous l'icône
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Se déconnecter', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            // L'élément déclencheur (l'avatar)
            child: const CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}