import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_response.dart';

class AuthApi {
  // CORRECTION : La route est probablement dans /auth/login vue votre config serveur
  static const String _loginUrl = '/auth/login'; 

  static Future<ApiResponse<Map<String, dynamic>>> login({
    required String login,
    required String password,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        _loginUrl,
        data: {
          'login': login,     // ✅ Correspond à votre Schema Mongoose
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        
        // Sauvegarde automatique du Token et des infos utilisateur
        await _saveAuthData(data);
        
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error('Erreur : ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 404) {
        return ApiResponse.error("Identifiant ou mot de passe incorrect.");
      }
      return ApiResponse.error("Erreur réseau: ${e.message}");
    } catch (e) {
      return ApiResponse.error("Erreur inattendue: $e");
    }
  }

  static Future<void> _saveAuthData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Adaptation selon ce que votre backend renvoie (ex: nodejs renvoie souvent 'token')
    if (data.containsKey('token')) {
      await prefs.setString('auth_token', data['token']);
    }
    
    // Sauvegarder le rôle pour gérer les droits (admin/agent/user)
    if (data.containsKey('user')) {
      final user = data['user'];
      if (user['role'] != null) {
        await prefs.setString('user_role', user['role']);
      }
      if (user['name'] != null) {
        await prefs.setString('user_name', user['name']);
      }
    }
  }
}