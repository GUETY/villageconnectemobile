import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Pour vérifier le token
import 'core/api/api_client.dart';
import 'core/theme/app_colors.dart';
import 'features/main/pages/main_screen.dart';
import 'features/auth/pages/login_page.dart'; // Import de la page de login

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ✅ C'est cette ligne qui active l'injection du token
  ApiClient.setupInterceptors(); 
  
  // Vérifier le token AVANT de lancer l'app
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('auth_token');
  
  // Si le token existe, l'utilisateur est déjà connecté
  final bool isLogged = token != null && token.isNotEmpty;

  runApp(MyApp(startScreen: isLogged ? const MainScreen() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Village Connecté',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      // C'est ici que la décision se fait
      home: startScreen, 
    );
  }
}