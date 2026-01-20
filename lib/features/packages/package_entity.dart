// Removed unused import

// Modèle de données décrivant un forfait internet
class PackageEntity {
  final String id;          // Identifiant unique du forfait
  final String name;        // Nom affiché du forfait
  final String description; // Brève description
  final int duration;       // en minutes
  final double price;       // Prix en FCFA
  final bool isPopular;     // Indique si le forfait est mis en avant
  final List<String> features; // Liste des fonctionnalités du forfait

  // Constructeur immuable
  const PackageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.duration, // Ajoute ce champ
    required this.price,
    required this.isPopular,
    required this.features,
  });

  // Créer une instance depuis JSON (réponse API)
  factory PackageEntity.fromJson(Map<String, dynamic> json) {
    return PackageEntity(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0, // Ajoute ce champ
      price: (json['prix'] ?? json['price'] ?? 0).toDouble(),
      isPopular: json['populaire'] ?? json['is_popular'] ?? false,
      features: json['features'] != null 
          ? List<String>.from(json['features'] as List)
          : [],
    );
  }

  // Convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': name,
      'description': description,
      'duree': duration,
      'prix': price,
      'populaire': isPopular,
      'features': features,
    };
  }

  @override
  String toString() => 'PackageEntity(id: $id, name: $name, price: $price)';
}