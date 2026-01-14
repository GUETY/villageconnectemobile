import 'payment_entity.dart';

// Repository : fournit les méthodes de paiement disponibles
class PaymentMethodsRepository {
  // Retourner la liste des méthodes de paiement
  static List<PaymentMethod> getAll() {
    return const [
      // Orange Money - Orange
      PaymentMethod(
        id: 'orange_money',
        name: 'Orange Money',
        description: 'Paiement sécurisé',
        icon: 'assets/icons/orange_money.svg',
        color: 'FF9900',  // Orange
      ),
      
      // MTN Mobile Money - Jaune
      PaymentMethod(
        id: 'mtn_mobile_money',
        name: 'MTN Mobile Money',
        description: 'Paiement sécurisé',
        icon: 'assets/icons/mtn_money.svg',
        color: 'FFCC00',  // Jaune
      ),
      
      // Moov Money - Orange clair
      PaymentMethod(
        id: 'moov_money',
        name: 'Moov Money',
        description: 'Paiement sécurisé',
        icon: 'assets/icons/moov_money.svg',
        color: 'FFC20E',  // Orange clair
      ),
      
      // Code Prépayé - Violet
      PaymentMethod(
        id: 'prepaid_code',
        name: 'Code Prépayé',
        description: 'Paiement sécurisé',
        icon: 'assets/icons/prepaid_code.svg',
        color: 'A855F7',  // Violet
      ),
    ];
  }
}