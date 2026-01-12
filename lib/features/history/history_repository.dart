import 'history_entity.dart';

class HistoryRepository {
  static List<HistoryItem> getPurchases() {
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
