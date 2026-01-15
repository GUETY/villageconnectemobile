import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Client API configuré avec Dio
class ApiClient {
  // ⚠️ Mise à jour vers l'API en ligne
  // AJOUT du '/' final pour éviter que le segment /api soit écrasé lors de la résolution des liens
  static const String baseUrl = 'https://api.villageconnecte.voisilab.online/api/'; 

  // Instance Dio singleton
  static final Dio dio = Dio(
    BaseOptions(
      // URL de base réelle de votre API
      baseUrl: baseUrl,
      
      // Timeout de connexion (30 secondes)
      connectTimeout: const Duration(seconds: 10),
      
      // Timeout de réception (30 secondes)
      receiveTimeout: const Duration(seconds: 10),
      
      // Headers par défaut
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Configurer le token d'authentification
  static void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Supprimer le token
  static void removeAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  // Initialiser les intercepteurs (logs, gestion d'erreurs)
  static void setupInterceptors() {
    // On vide pour éviter d'ajouter l'intercepteur plusieurs fois
    dio.interceptors.clear();

    dio.interceptors.add(
      InterceptorsWrapper(
        // Avant d'envoyer la requête
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('auth_token');

          // DEBUG : Afficher l'URL exacte
          print('🌐 [${options.method}] ${options.uri}');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print('✅ Token injecté: ${token.substring(0, 20)}...');
          } else {
            print('❌ AUCUN TOKEN - L\'utilisateur doit se connecter');
          }
          return handler.next(options);
        },
        
        // Erreur
        onError: (DioException e, handler) async {
          final statusCode = e.response?.statusCode;
          print('🛑 Erreur $statusCode sur : ${e.requestOptions.uri}');
          
          if (e.response != null) {
            print('🔍 Réponse serveur : ${e.response?.data}');
          }

          // Gestion spécifique erreur 401 (Unauthorized)
          if (statusCode == 401) {
            print('🚨 ERREUR 401 - Token invalide ou expiré');
            print('💡 Solutions possibles:');
            print('   1. L\'utilisateur doit se reconnecter');
            print('   2. Le token a expiré');
            print('   3. Le token n\'existe pas dans SharedPreferences');
            
            // Supprimer le token invalide
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('auth_token');
            print('🗑️ Token supprimé - Reconnexion nécessaire');
          }
          
          return handler.next(e);
        },
      ),
    );
  }
}