import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../package_entity.dart';
import '../payment_entity.dart';
import 'payment_succes_page.dart';

// Page pour traiter le paiement (écran de chargement)
class PaymentProcessingPage extends StatefulWidget {
  final PackageEntity package;
  final PaymentMethod paymentMethod;

  const PaymentProcessingPage({
    super.key,
    required this.package,
    required this.paymentMethod,
  });

  @override
  State<PaymentProcessingPage> createState() => _PaymentProcessingPageState();
}

class _PaymentProcessingPageState extends State<PaymentProcessingPage> {
  // Future qui simule le traitement du paiement
  late Future<bool> _paymentFuture;

  @override
  void initState() {
    super.initState();
    // Lancer le traitement du paiement (3 secondes de simulation)
    _paymentFuture = _processPayment();
  }

  // Simuler le traitement du paiement
  Future<bool> _processPayment() async {
    // Attendre 3 secondes
    await Future.delayed(const Duration(seconds: 3));
    // Retourner true (succès)
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _paymentFuture,
        builder: (context, snapshot) {
          // --- Paiement en cours ---
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildProcessingUI();
          }

          // --- Paiement réussi ---
          if (snapshot.hasData && snapshot.data == true) {
            // Générer le code d'accès
            final accessCode = AccessCode(
              code: _generateAccessCode(),
              qrCode: _generateQRCode(),
              packageName: widget.package.name,
              durationHours: widget.package.duration,
              price: widget.package.price,
            );

            // Naviguer vers la page de succès après un court délai
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => PaymentSuccessPage(
                    accessCode: accessCode,
                  ),
                ),
              );
            });
          }

          // Afficher l'UI de traitement par défaut
          return _buildProcessingUI();
        },
      ),
    );
  }

  // UI pendant le traitement du paiement
  Widget _buildProcessingUI() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spinner animé (cercle de chargement)
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                // Couleur du spinner (bleu)
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                // Épaisseur de la ligne
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            
            // Texte principal
            const Text(
              'Traitement du paiement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            
            // Texte secondaire
            const Text(
              'Veuillez patienter...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Générer un code alphanumérique aléatoire (ex: WOU-321-Z76)
  String _generateAccessCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String code = '';
    
    // Générer 11 caractères avec des tirets aux positions 3 et 7
    for (int i = 0; i < 11; i++) {
      if (i == 3 || i == 7) {
        // Ajouter un tiret
        code += '-';
      } else {
        // Ajouter un caractère aléatoire
        code += chars[(DateTime.now().millisecond + i) % chars.length];
      }
    }
    return code;
  }

  // Générer les données du QR code
  String _generateQRCode() {
    return 'https://wifi.villageconnecte.com/auth?code=${_generateAccessCode()}';
  }
}