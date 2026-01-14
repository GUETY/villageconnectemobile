import 'package_entity.dart';

class PackagesRepository {
  static List<PackageEntity> getAll() {
    return const [
      PackageEntity(
        id: '1',
        name: '1 Heure Express',
        description: 'Idéal pour navigation rapide',
        price: 500.0,
        duration: 1,
        isPopular: false,
        features: [
          '1 Appareil',
          'Support inclus',
        ],
      ),
      PackageEntity(
        id: '2',
        name: '3 Heures Standard',
        description: 'Idéal pour navigation rapide',
        price: 1200.0,
        duration: 3,
        isPopular: true,
        features: [
          '2 Appareils',
          'Support prioritaire',
        ],
      ),
      PackageEntity(
        id: '3',
        name: 'Journée Complète',
        description: 'Accès illimité toute la journée',
        price: 3000.0,
        duration: 24,
        isPopular: false,
        features: [
          '3 Appareils',
          'QoS premium',
        ],
      ),
      PackageEntity(
        id: '4',
        name: 'Pack Famille 7j',
        description: 'Idéal pour navigation rapide',
        price: 15000.0,
        duration: 168, // 7 jours
        isPopular: false,
        features: [
          '5 Appareils',
          'Support prioritaire',
        ],
      ),
    ];
  }
}