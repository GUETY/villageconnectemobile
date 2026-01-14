// Modèle générique pour les réponses API
class ApiResponse<T> {
  final bool success;         // Succès ou erreur
  final String? message;      // Message de l'API
  final T? data;              // Données (peut être null)
  final int? statusCode;      // Code HTTP

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  // Créer une réponse de succès
  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  // Créer une réponse d'erreur
  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}