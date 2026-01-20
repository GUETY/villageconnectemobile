import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_response.dart';
import '../package_entity.dart';

// API pour gérer les forfaits
class ForfaitsApi {
  
  // 1. Récupérer tous les forfaits (GET /api/forfaits)
  static Future<ApiResponse<List<PackageEntity>>> getAll({String? token}) async {
    try {
      print('📡 Récupération des forfaits...');
      
      Options requestOptions = Options();
      if (token != null && token.isNotEmpty) {
        requestOptions.headers = {'Authorization': 'Bearer $token'};
      }

      final response = await ApiClient.dio.get('forfaits', options: requestOptions);

      if (response.statusCode == 200) {
        final data = response.data;
        List<dynamic> jsonList = [];
        if (data is List) jsonList = data;
        else if (data is Map) {
          if (data['data'] != null) jsonList = data['data'];
          else if (data['forfaits'] != null) jsonList = data['forfaits'];
        }

        final packages = jsonList
            .map((json) {
                try { return PackageEntity.fromJson(json as Map<String, dynamic>); } 
                catch (e) { return null; }
            })
            .whereType<PackageEntity>()
            .toList();

        return ApiResponse.success(packages);
      }
      return ApiResponse.error('Erreur: ${response.statusCode}');
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Erreur inconnue: $e');
    }
  }

  // 2. Récupérer un forfait par ID (GET /api/forfaits/{id})
  static Future<ApiResponse<PackageEntity>> getById(String id) async {
    try {
      final response = await ApiClient.dio.get('forfaits/$id');
      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, dynamic> jsonData = (data is Map && data.containsKey('data')) ? data['data'] : data;
        return ApiResponse.success(PackageEntity.fromJson(jsonData));
      }
      return ApiResponse.error('Forfait introuvable');
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Erreur: $e');
    }
  }

  // 3. Initier un paiement (POST /api/transactions)
  // Cette méthode crée la transaction et peut retourner le code directement si le back est configuré ainsi
  static Future<ApiResponse<Map<String, dynamic>>> initiatePayment({
    required String forfaitId,
    required String methodePaiement,
    String? phoneNumber,
    int? duration, // <-- AJOUT ICI
  }) async {
    try {
      print('📡 Achat forfait $forfaitId via $methodePaiement sur /api/transactions');
      
      final Map<String, dynamic> payload = {
        'forfait_id': forfaitId,
        'payment_method': methodePaiement,
      };

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        payload['phone_number'] = phoneNumber;
      }

      if (duration != null) {
        payload['duration'] = duration; // <-- AJOUT ICI
      }

      final response = await ApiClient.dio.post(
        'transactions',
        data: payload,
      );

      print('✅ Réponse Paiement: ${response.statusCode}');
      print('📦 Données reçues: ${response.data}');

      // On renvoie toute la donnée (qui peut contenir le code généré, ex: 'access_code')
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(response.data);
      }

      return ApiResponse.error('Erreur lors du paiement');
    } on DioException catch (e) {
      print('🚨 Erreur API transaction: ${e.response?.data}');
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Erreur: $e');
    }
  }

  // 4. NOUVEAU : Récupérer les codes générés (GET /api/codes)
  // Utilisez cette fonction après le paiement si le code n'est pas renvoyé directement par la transaction
  // ou pour afficher l'historique "Mes Codes".
  static Future<ApiResponse<List<dynamic>>> getMyCodes() async {
    try {
      print('📡 Récupération des codes sur /api/codes');
      
      // Le token est injecté automatiquement par l'interceptor ApiClient si l'utilisateur est connecté
      final response = await ApiClient.dio.get('codes');

      if (response.statusCode == 200) {
        final data = response.data;
         List<dynamic> codesList = [];

         // Adaptation selon la réponse du backend
         if (data is List) codesList = data;
         else if (data is Map && data['data'] != null) codesList = data['data'];

        print('✅ ${codesList.length} codes récupérés');
        return ApiResponse.success(codesList);
      }
      return ApiResponse.error('Impossible de récupérer les codes');
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    }
  }

  static String _handleDioError(DioException error) {
    if (error.response?.statusCode == 404) {
      return "Route introuvable (404). Vérifiée: ${error.requestOptions.path}";
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Serveur injoignable (Timeout)';
      case DioExceptionType.badResponse:
        return 'Erreur serveur (${error.response?.statusCode})';
      case DioExceptionType.connectionError:
        return 'Pas de connexion internet';
      default:
        return 'Erreur réseau';
    }
  }
}