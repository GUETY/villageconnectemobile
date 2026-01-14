import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_response.dart';
import '../package_entity.dart';

// API pour gérer les forfaits
class ForfaitsApi {
  
  // 1. Récupérer tous les forfaits
  // Route backend : /api/forfaits
  static Future<ApiResponse<List<PackageEntity>>> getAll({String? token}) async {
    try {
      print('📡 Récupération des forfaits...');
      
      Options requestOptions = Options();
      if (token != null && token.isNotEmpty) {
        requestOptions.headers = {'Authorization': 'Bearer $token'};
      }

      // CORRECTION : Utilisation de 'forfaits' au lieu de 'packages'
      final response = await ApiClient.dio.get(
        'forfaits', 
        options: requestOptions
      );

      print('Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;
        List<dynamic> jsonList = [];
        
        // Logique de parsing robuste
        if (data is List) {
          jsonList = data;
        } else if (data is Map) {
          if (data['data'] != null) jsonList = data['data'];
          else if (data['forfaits'] != null) jsonList = data['forfaits'];
        }

        final packages = jsonList
            .map((json) {
              try {
                return PackageEntity.fromJson(json as Map<String, dynamic>);
              } catch (e) {
                print('❌ Erreur parsing forfait: $e');
                return null;
              }
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

  // 2. Récupérer un forfait par ID
  // Route backend : /api/forfaits/{id}
  static Future<ApiResponse<PackageEntity>> getById(String id) async {
    try {
      // CORRECTION : 'forfaits/$id'
      final response = await ApiClient.dio.get('forfaits/$id');

      if (response.statusCode == 200) {
        final data = response.data;
        Map<String, dynamic> jsonData = (data is Map && data.containsKey('data')) 
            ? data['data'] 
            : data;
        return ApiResponse.success(PackageEntity.fromJson(jsonData));
      }
      return ApiResponse.error('Forfait introuvable');
    } on DioException catch (e) {
      return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Erreur: $e');
    }
  }

  // 3. Initier un paiement / Acheter un forfait
  // Route backend : /api/transactions
  static Future<ApiResponse<Map<String, dynamic>>> initiatePayment({
    required String forfaitId,
    required String methodePaiement,
  }) async {
    try {
      print('📡 Création transaction pour le forfait $forfaitId via $methodePaiement...');
      
      // CORRECTION : Utilisation de 'transactions' pour créer l'achat
      final String endpoint = 'transactions'; 

      final response = await ApiClient.dio.post(
        endpoint, 
        data: {
          // CORRECTION : Adaptation des clés pour correspondre au français des routes
          'forfait_id': forfaitId,       // Probablement 'forfait_id' au lieu de 'package_id'
          'payment_method': methodePaiement, // ou 'mode_paiement' selon votre backend
          // 'amount': ... souvent calculé par le back grâce à l'ID
        },
      );

      print('Status Paiement: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Transaction créée avec succès');
        // La réponse doit contenir le code wifi ou les détails transaction
        return ApiResponse.success(response.data);
      }

      return ApiResponse.error('Erreur lors du paiement');
    } on DioException catch (e) {
        print('🚨 Erreur paiement: ${e.response?.data}'); 
        return ApiResponse.error(_handleDioError(e));
    } catch (e) {
      return ApiResponse.error('Erreur: $e');
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
        return 'Erreur réseau ou serveur';
    }
  }
}