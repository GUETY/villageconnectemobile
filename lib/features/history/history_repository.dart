import 'package:villageconnecte_mobile/core/api/history_api.dart';
import 'history_entity.dart';

class HistoryRepository {
  // Récupérer l'historique des achats depuis l'API en temps réel
  static Future<List<HistoryItem>> getPurchases() async {
    try {
      print('🔄 [REPOSITORY] Chargement de l\'historique depuis la BASE DE DONNÉES...');
      
      // Utiliser la nouvelle API dédiée à l'historique
      // Tentative avec fallback automatique entre les endpoints
      final purchases = await HistoryApi.getHistoryWithFallback();
      
      if (purchases.isEmpty) {
        print('⚠️ [REPOSITORY] Aucun achat trouvé dans la base de données');
      } else {
        print('✅ [REPOSITORY] ${purchases.length} achats RÉELS récupérés de la BASE');
      }
      
      return purchases;
      
    } catch (e) {
      print('❌ [REPOSITORY] Erreur connexion à l\'API: $e');
      print('💡 [REPOSITORY] Vérifiez:');
      print('   1. Connexion Internet');
      print('   2. API disponible: https://api.villageconnecte.voisilab.online');
      print('   3. Token d\'authentification valide');
      print('⚠️ [REPOSITORY] Affichage des données de DÉMONSTRATION par défaut');
      
      // En cas d'erreur API, retourner des données de démonstration
      return _getMockPurchases();
    }
  }

  // Données de démonstration (fallback)
  static List<HistoryItem> _getMockPurchases() {
    return const [
      HistoryItem(
        id: 'h1',
        name: '3 Heures Standard',
        dateLabel: '2025-08-20',
        code: 'ABC - 789 - DEF',
        price: 1200,
        currency: 'FCFA',
        isActive: true,
        usageLabel: '2h 45min',
      ),
      HistoryItem(
        id: 'h2',
        name: '1 Heure Express',
        dateLabel: '2025-08-19',
        code: 'GHI - 456 - JKL',
        price: 500,
        currency: 'FCFA',
        isActive: false,
        usageLabel: '1h 00min',
      ),
      HistoryItem(
        id: 'h3',
        name: '3 Heures Standard',
        dateLabel: '2025-08-18',
        code: 'MNO - 123 - PQR',
        price: 3000,
        currency: 'FCFA',
        isActive: false,
        usageLabel: '18h 30min',
      ),
    ];
  }
}
