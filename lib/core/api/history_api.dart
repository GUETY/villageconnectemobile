import 'package:dio/dio.dart';
import 'package:villageconnecte_mobile/core/api/api_client.dart';
import 'package:villageconnecte_mobile/features/history/history_entity.dart';

/// API pour gérer l'historique des achats utilisateur
/// Base de données en ligne via https://api.villageconnecte.voisilab.online
class HistoryApi {
  // Endpoints API
  // Principal: liste des forfaits achetés par l'utilisateur
  static const String _forfaitsEndpoint = '/forfaits';
  // Général: informations d'accès utilisateur
  static const String _userAccessEndpoint = '/user-access';
  // Historique alternatif
  static const String _purchaseHistoryEndpoint = '/historique/achats';

  /// Récupérer l'historique des achats de l'utilisateur en temps réel
  /// Retourne la liste des achats depuis la base de données
  static Future<List<HistoryItem>> getUserPurchaseHistory() async {
    try {
      print('📡 [HISTORY API] Récupération des forfaits achetés (BASE DE DONNÉES)...');
      print('🌐 [HISTORY API] Endpoint: ${ApiClient.baseUrl}$_forfaitsEndpoint');
      
      // Appel API principal: liste des forfaits
      final response = await ApiClient.dio.get(_forfaitsEndpoint);

      print('✅ [HISTORY API] Réponse reçue - Status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        print('📦 [HISTORY API] Données RÉELLES (forfaits): $data');

        // Cas 1: Réponse directe sous forme de liste
        if (data is List) {
          return _parseHistoryList(data);
        }

        // Cas 2: Réponse avec structure objet
        if (data is Map<String, dynamic>) {
          // Chercher la liste dans différentes clés possibles
          final List? items = data['data'] ?? 
                              data['forfaits'] ??
                              data['achats'] ?? 
                              data['purchases'] ?? 
                              data['historique'] ??
                              data['accesses'] ??
                              data['user_accesses'];
          
          if (items != null) {
            return _parseHistoryList(items);
          }

          // Si la réponse est un seul objet, le transformer en liste
          if (data.containsKey('id') || data.containsKey('nom') || data.containsKey('name') || data.containsKey('forfait')) {
            return [HistoryItem.fromJson(data)];
          }
        }

        print('⚠️ Format de réponse API non reconnu');
        throw Exception('Format de données non reconnu');
      }

      throw Exception('Erreur serveur: ${response.statusCode}');
    } on DioException catch (e) {
      print('❌ Erreur Dio: ${e.type} - ${e.message}');
      
      if (e.response != null) {
        print('🔍 Réponse erreur: ${e.response?.statusCode} - ${e.response?.data}');
        
        // Gestion spécifique de l'erreur 401
        if (e.response?.statusCode == 401) {
          throw Exception('NON_AUTHENTIFIÉ: Veuillez vous connecter pour accéder à l\'historique');
        }
      }
      
      rethrow;
    } catch (e) {
      print('❌ Erreur inattendue lors de la récupération de l\'historique: $e');
      rethrow;
    }
  }

  /// Récupérer l'historique via l'endpoint général user-access
  static Future<List<HistoryItem>> getUserAccessHistory() async {
    try {
      print('📡 [HISTORY API] Récupération via endpoint général (user-access)...');
      print('🌐 [HISTORY API] Endpoint: ${ApiClient.baseUrl}$_userAccessEndpoint');

      final response = await ApiClient.dio.get(_userAccessEndpoint);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return _parseHistoryList(data);
        }

        if (data is Map<String, dynamic>) {
          final List? items = data['data'] ?? data['achats'] ?? data['purchases'] ?? data['accesses'];
          if (items != null) {
            return _parseHistoryList(items);
          }
        }

        throw Exception('Format de données non reconnu');
      }

      throw Exception('Erreur serveur: ${response.statusCode}');
    } catch (e) {
      print('❌ Erreur endpoint user-access: $e');
      rethrow;
    }
  }

  /// Récupérer l'historique alternatif (endpoint /historique/achats)
  static Future<List<HistoryItem>> getAlternativePurchaseHistory() async {
    try {
      print('📡 Récupération de l\'historique (endpoint alternatif)...');
      
      final response = await ApiClient.dio.get(_purchaseHistoryEndpoint);

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is List) {
          return _parseHistoryList(data);
        }

        if (data is Map<String, dynamic>) {
          final List? items = data['data'] ?? data['achats'];
          if (items != null) {
            return _parseHistoryList(items);
          }
        }

        throw Exception('Format de données non reconnu');
      }

      throw Exception('Erreur serveur: ${response.statusCode}');
    } catch (e) {
      print('❌ Erreur endpoint alternatif: $e');
      rethrow;
    }
  }

  /// Parser la liste de données JSON en liste d'objets HistoryItem
  static List<HistoryItem> _parseHistoryList(List items) {
    try {
      final List<HistoryItem> historyItems = [];
      
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          try {
            historyItems.add(HistoryItem.fromJson(item));
          } catch (e) {
            print('⚠️ Erreur parsing item: $e - Item: $item');
          }
        }
      }
      
      print('✅ ${historyItems.length} achats parsés avec succès');
      return historyItems;
    } catch (e) {
      print('❌ Erreur parsing liste: $e');
      rethrow;
    }
  }

  /// Récupérer les détails d'un achat spécifique
  static Future<HistoryItem> getPurchaseDetails(String purchaseId) async {
    try {
      final response = await ApiClient.dio.get('$_purchaseHistoryEndpoint/$purchaseId');

      if (response.statusCode == 200) {
        final data = response.data;
        
        if (data is Map<String, dynamic>) {
          // Si la réponse contient une clé 'data', l'utiliser
          final itemData = data['data'] ?? data;
          return HistoryItem.fromJson(itemData);
        }

        throw Exception('Format de données invalide');
      }

      throw Exception('Erreur serveur: ${response.statusCode}');
    } catch (e) {
      print('❌ Erreur récupération détails: $e');
      rethrow;
    }
  }

  /// Récupérer l'historique avec tentative sur les deux endpoints
  /// Essaie d'abord user-access, puis historique/achats en fallback
  static Future<List<HistoryItem>> getHistoryWithFallback() async {
    try {
      // Tentative 1: forfaits (principal)
      return await getUserPurchaseHistory();
    } catch (e1) {
      print('⚠️ Échec endpoint forfaits, tentative endpoint user-access...');
      
      try {
        // Tentative 2: user-access (général)
        return await getUserAccessHistory();
      } catch (e2) {
        print('⚠️ Échec user-access, tentative endpoint historique/achats...');
        try {
          // Tentative 3: historique/achats (alternatif)
          return await getAlternativePurchaseHistory();
        } catch (e3) {
          print('❌ Échec des trois endpoints');
          rethrow;
        }
      }
    }
  }
}
