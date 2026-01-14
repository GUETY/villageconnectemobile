// Modèle de données pour les méthodes de paiement
class PaymentMethod {
  final String id;           // Identifiant unique
  final String name;         // Nom (Orange Money, MTN, etc.)
  final String description;  // Description (Paiement sécurisé)
  final String icon;         // Icône SVG
  final String color;        // Couleur hexadécimale

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Modèle pour le code d'accès généré après paiement
class AccessCode {
  final String code;
  final String qrCode;
  final String packageName;
  final int durationHours;
  final double price;

  AccessCode({
    required this.code,
    required this.qrCode,
    required this.packageName,
    required this.durationHours,
    required this.price,
  });
}