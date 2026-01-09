import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../help_repository.dart';
import '../widgets/connection_step_card.dart';
import '../widgets/faq_card.dart';
import '../widgets/support_contact_card.dart';

// Page Aide principale (sans Scaffold, gérée par MainScreen)
class HelpPageContent extends StatelessWidget {
  const HelpPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = HelpRepository.getConnectionSteps();
    final faqs = HelpRepository.getFaqs();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.wifi, color: AppColors.white, size: 24),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wi-Fi Communautaire',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Accès Internet Rural',
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: Icon(Icons.person, color: AppColors.primary),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Section "Comment se connecter ?"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Comment se connecter ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                // Liste des étapes
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: steps
                        .map((step) => ConnectionStepCard(step: step))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section "Questions Fréquentes"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Questions Fréquentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                // Liste des FAQs
                ...faqs.map((faq) => FaqCard(faq: faq)).toList(),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Section "Besoins d'Aide ?"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Besoins d\'Aide ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                // Bouton Appelez-nous
                SupportContactCard(
                  icon: Icons.phone,
                  title: 'Appelez-nous?',
                  subtitle: '+225 XX XX XX XX XX',
                  backgroundColor: const Color(0xFFE8F5E9),
                  iconColor: AppColors.success,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Appel vers +225 XX XX XX XX XX')),
                    );
                  },
                ),
                // Bouton WhatsApp
                SupportContactCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'WhatsApp',
                  subtitle: 'Support instantané',
                  backgroundColor: AppColors.primaryLight,
                  iconColor: AppColors.primary,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ouverture de WhatsApp...')),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
