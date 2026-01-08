// Removed unused import

// Modèle de données décrivant un forfait internet
class PackageEntity {
  final String id;          // Identifiant unique du forfait
  final String name;        // Nom affiché du forfait
  final String description; // Brève description
  final double price;       // Prix en FCFA
  final int duration;       // Durée en heures
  final double speed;       // Débit en Mbps
  final int devices;        // Nombre d’appareils autorisés
  final String support;     // Niveau/type de support
  final bool isPopular;     // Indique si le forfait est mis en avant

  // Constructeur immuable
  const PackageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.speed,
    required this.devices,
    required this.support,
    this.isPopular = false,
  });
}