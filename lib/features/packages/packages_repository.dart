import 'package_entity.dart';

class PackagesRepository {
  static List<PackageEntity> getAll() {
    return const [
      PackageEntity(
        id: '1',
        name: '1 Heure Express',
        description: 'Idéal pour navigation rapide',
        price: 500,
        duration: 1,
        speed: 5,
        devices: 1,
        support: 'Support inclus',
      ),
      PackageEntity(
        id: '2',
        name: '3 Heures Standard',
        description: 'Idéal pour navigation rapide',
        price: 1200,
        duration: 3,
        speed: 10,
        devices: 2,
        support: 'Support prioritaire',
        isPopular: true,
      ),
      PackageEntity(
        id: '3',
        name: 'Journée Complète',
        description: 'Accès illimité toute la journée',
        price: 3000,
        duration: 24,
        speed: 15,
        devices: 3,
        support: 'QoS premium',
      ),
      PackageEntity(
        id: '4',
        name: 'Pack Famille 7j',
        description: 'Idéal pour navigation rapide',
        price: 15000,
        duration: 168, // 7 jours
        speed: 10,
        devices: 2,
        support: 'Support prioritaire',
      ),
    ];
  }
}