import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../package_entity.dart';
import '../payment_entity.dart';
import '../data/forfaits_api.dart'; // <-- Ajouté
import 'payment_succes_page.dart';

// Page pour traiter le paiement (écran de chargement)
class PaymentProcessingPage extends StatefulWidget {
  final PackageEntity package;
  final PaymentMethod paymentMethod;
  final String? phoneNumber;

  const PaymentProcessingPage({
    super.key,
    required this.package,
    required this.paymentMethod,
    this.phoneNumber,
  });

  @override
  State<PaymentProcessingPage> createState() => _PaymentProcessingPageState();
}

class _PaymentProcessingPageState extends State<PaymentProcessingPage> {
  late Future<Map<String, dynamic>?> _paymentFuture;

  @override
  void initState() {
    super.initState();
    _paymentFuture = _processPayment();
  }

  // Traiter le paiement via l'API (Cynepay ou autre)
  Future<Map<String, dynamic>?> _processPayment() async {
    try {
      final response = await ForfaitsApi.initiatePayment(
        forfaitId: widget.package.id,
        methodePaiement: widget.paymentMethod.id,
        phoneNumber: widget.phoneNumber,
        duration: widget.package.duration,
      );
      if (response.success && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        _showError(response.message ?? 'Erreur lors du paiement');
        return null;
      }
    } catch (e) {
      _showError('Erreur inattendue: $e');
      return null;
    }
  }

  void _showError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _paymentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildProcessingUI();
          }

          if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!;
            final code = data['access_code'] ?? data['code'] ?? '';
            final qrCode = data['qr_code'] ?? 'https://wifi.villageconnecte.com/auth?code=$code';

            final accessCode = AccessCode(
              code: code,
              qrCode: qrCode,
              packageName: widget.package.name,
              durationHours: widget.package.duration,
              price: widget.package.price,
            );

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

          return _buildProcessingUI();
        },
      ),
    );
  }

  Widget _buildProcessingUI() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Traitement du paiement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
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
}