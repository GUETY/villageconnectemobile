import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../package_entity.dart';
import '../payment_entity.dart';
import '../payment_methods_repository.dart';
import 'payment_processing_page.dart';

// Page pour sélectionner le mode de paiement
class PaymentSelectionPage extends StatelessWidget {
  // Le forfait sélectionné à payer
  final PackageEntity package;

  const PaymentSelectionPage({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    // Récupérer toutes les méthodes de paiement
    final paymentMethods = PaymentMethodsRepository.getAll();

    return Scaffold(
      // AppBar avec bouton retour
      appBar: AppBar(
        title: const Text('Paiement'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- En-tête avec le forfait sélectionné ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  // Titre du forfait
                  Text(
                    package.name,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Description du forfait
                  Text(
                    package.description,
                    style: const TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // --- Résumé du paiement ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  const Text(
                    'Résumé du paiement',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Ligne : Forfait
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Forfait',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                      Text(
                        package.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Ligne : Durée
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Durée',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                      Text(
                        '${package.duration} heures',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),
                  
                  // Ligne : Montant total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Montant total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        '${package.price.toStringAsFixed(0)} FCFA',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Titre : Choisir méthode de paiement ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Choisissez votre mode de paiement',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // --- Liste des méthodes de paiement ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return _PaymentMethodCard(
                  method: method,
                  onTap: () {
                    // Naviguer vers la page de traitement du paiement
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PaymentProcessingPage(
                          package: package,
                          paymentMethod: method,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// --- Widget pour une carte de méthode de paiement ---
class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.method,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // Bordure colorée selon la méthode
            border: Border.all(
              color: Color(int.parse('FF${method.color}', radix: 16)),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Row(
            children: [
              // Carré de couleur avec icône paiement
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(int.parse('FF${method.color}', radix: 16)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.payment,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              
              // Texte : nom et description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom de la méthode
                    Text(
                      method.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    // Description
                    Text(
                      method.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Flèche droite
              const Icon(Icons.arrow_forward, color: AppColors.textGrey),
            ],
          ),
        ),
      ),
    );
  }
}