import 'package:flutter/material.dart';
import 'help_entity.dart';

class HelpRepository {
  // Étapes pour se connecter
  static List<ConnectionStep> getConnectionSteps() {
    return const [
      ConnectionStep(
        number: 1,
        title: 'Achetez un forfait',
        description: 'Choisissez et payez votre forfait préféré',
      ),
      ConnectionStep(
        number: 2,
        title: 'Connectez-vous au Wi-Fi',
        description: 'Sélectionnez "Wi-Fi Communautaire" dans vos réseaux',
      ),
      ConnectionStep(
        number: 3,
        title: 'Saisissez votre code',
        description: 'Entrez le code reçu sur la page qui s\'ouvre',
      ),
      ConnectionStep(
        number: 4,
        title: 'Profitez d\'Internet',
        description: 'Vous êtes maintenant connecté',
        isCompleted: true,
      ),
    ];
  }

  // Questions fréquentes
  static List<FaqItem> getFaqs() {
    return const [
      FaqItem(
        icon: Icons.help_outline,
        question: 'Mon code ne fonctionne pas',
        answer: 'Vérifiez que vous êtes connecté au bon réseau "Wi-Fi Communautaire" et que le code n\'est pas expiré.',
      ),
      FaqItem(
        icon: Icons.wifi_tethering_error,
        question: 'Internet est lent',
        answer: 'Rapprochez-vous du point d\'accès Wi-Fi ou vérifiez votre forfait et les limites de vitesse.',
      ),
      FaqItem(
        icon: Icons.monetization_on_outlined,
        question: 'Comment obtenir un remboursement?',
        answer: 'Contactez notre support dans les 24h si votre code n\'a pas été utilisé.',
      ),
    ];
  }
}
