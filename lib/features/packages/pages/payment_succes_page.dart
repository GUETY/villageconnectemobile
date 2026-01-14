import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../payment_entity.dart';

// Page affichant le code d'accès après paiement réussi
class PaymentSuccessPage extends StatelessWidget {
  final AccessCode accessCode;

  const PaymentSuccessPage({
    super.key,
    required this.accessCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar avec bouton fermer
      appBar: AppBar(
        title: const Text('Paiement Réussi'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Fermer et revenir à l'accueil (première page)
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- En-tête de succès (fond vert) ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Vert succès
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Icône checkmark en cercle
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.white,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  
                  // Titre
                  const Text(
                    'Paiement Réussi !',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Sous-titre
                  const Text(
                    'Votre code d\'accès est prêt',
                    style: TextStyle(
                      color: Color(0xFFE8F5E9), // Vert très clair
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // --- Détails du forfait ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyLight),
              ),
              child: Column(
                children: [
                  // Forfait
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Forfait',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                      Text(
                        accessCode.packageName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Durée
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Durée',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                      Text(
                        '${accessCode.durationHours} heures',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Prix payé
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Montant payé',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                      Text(
                        '${accessCode.price.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Section Code d'accès ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD), // Bleu très clair
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Column(
                children: [
                  // Titre
                  const Text(
                    'Votre code d\'accès',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Code alphanumérique (grand et visible)
                  Text(
                    accessCode.code,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Ligne de séparation
                  Divider(color: AppColors.primary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  
                  // Titre QR code
                  const Text(
                    'Code QR pour connexion rapide',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Afficher le QR code
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: accessCode.qrCode.isNotEmpty
                        ? SizedBox(
                            width: 200,
                            height: 200,
                            child: QrImageView(
                              data: accessCode.qrCode,
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Code QR non disponible',
                                style: TextStyle(color: AppColors.textGrey),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            // --- Boutons d'action ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Bouton Copier le code
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Copier le code dans le presse-papiers
                        Clipboard.setData(
                          ClipboardData(text: accessCode.code),
                        );
                        
                        // Afficher un message de confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copié dans le presse-papiers !'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copier le code'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Bouton Partager
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implémenter le partage
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Partage non implémenté'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Partager'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Section Instructions ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0), // Orange très clair
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFF9800),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre avec icône
                  Row(
                    children: [
                      const Icon(
                        Icons.info,
                        color: Color(0xFFFF9800),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Étape 1
                  _buildInstructionStep(
                    '1',
                    'Connectez-vous au réseau "Wi-Fi Communautaire"',
                  ),
                  const SizedBox(height: 8),
                  
                  // Étape 2
                  _buildInstructionStep(
                    '2',
                    'Une page s\'ouvrira automatiquement',
                  ),
                  const SizedBox(height: 8),
                  
                  // Étape 3
                  _buildInstructionStep(
                    '3',
                    'Saisissez votre code ou scannez le QR',
                  ),
                  const SizedBox(height: 8),
                  
                  // Étape 4
                  _buildInstructionStep(
                    '4',
                    'Profitez d\'Internet !',
                  ),
                ],
              ),
            ),

            // --- Bouton Retour à l'accueil ---
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Revenir à l'écran d'accueil
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Retour à l\'accueil'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Helper pour construire une étape d'instruction
  static Widget _buildInstructionStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Numéro en cercle orange
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFFF9800),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Texte de l'étape
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}