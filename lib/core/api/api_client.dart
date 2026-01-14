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

          // DEBUG : Afficher l'URL exacte pour comprendre le 404
          print('🌐 [${options.method}] URL appelée : ${options.uri}');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token'; // Le format standard est souvent "Bearer " + token
            print('✅ Token injecté pour ${options.path}'); // DEBUG
          } else {
             print('❌ AUCUN TOKEN TROUVÉ pour ${options.path}'); // DEBUG
          }
          return handler.next(options);
        },
        
        // Erreur
        onError: (DioException e, handler) {
          // Afficher plus de détails sur le 404
          print('🛑 Erreur ${e.response?.statusCode} sur : ${e.requestOptions.uri}');
          if (e.response != null) {
             print('🔍 Réponse serveur : ${e.response?.data}');
          }
          
          return handler.next(e);
        },
      ),
    );
  }
}