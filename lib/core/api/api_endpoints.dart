// Classe contenant toutes les URLs des endpoints API
class ApiEndpoints {
  // Base URL (déjà dans ApiClient)
  static const String baseUrl = 'https://api.villageconnecte.voisilab.online/api';

  // --- Forfaits ---
  static const String forfaits = '/forfaits';
  static String forfaitById(String id) => '/forfaits/$id';

  // --- Paiements ---
  static const String initiatePayment = '/paiements/initier';
  static const String verifyPayment = '/paiements/verifier';
  static String paymentStatus(String transactionId) => '/paiements/$transactionId/statut';

  // --- Codes d'accès ---
  static const String generateCode = '/codes/generer';
  static const String validateCode = '/codes/valider';
  static String codeDetails(String code) => '/codes/$code';

  // --- Authentification ---
  static const String login = '/auth/connexion';
  static const String register = '/auth/inscription';
  static const String logout = '/auth/deconnexion';
}