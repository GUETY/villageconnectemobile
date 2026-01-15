import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import '../../../core/theme/app_colors.dart';
import '../history_repository.dart';
import '../widgets/history_card.dart';
=======
import 'package:villageconnecte_mobile/core/theme/app_colors.dart';
import 'package:villageconnecte_mobile/features/history/history_entity.dart';
import 'package:villageconnecte_mobile/features/history/history_repository.dart';
import 'package:villageconnecte_mobile/features/history/widgets/history_card.dart';
>>>>>>> Stashed changes

// Page Historique principale (sans Scaffold, gérée par MainScreen)
class HistoryPageContent extends StatefulWidget {
  const HistoryPageContent({super.key});

  @override
  State<HistoryPageContent> createState() => _HistoryPageContentState();
}

class _HistoryPageContentState extends State<HistoryPageContent> {
  late Future<List<HistoryItem>> _purchasesFuture;

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  // Charger les achats depuis l'API
  void _loadPurchases() {
    setState(() {
      _purchasesFuture = HistoryRepository.getPurchases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _loadPurchases();
        await _purchasesFuture;
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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

            const SizedBox(height: 12),

            // Section titre avec bouton de rechargement
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mes Achats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.primary),
                    onPressed: _loadPurchases,
                    tooltip: 'Actualiser',
                  ),
                ],
              ),
            ),

            // Liste des achats avec FutureBuilder
            FutureBuilder<List<HistoryItem>>(
              future: _purchasesFuture,
              builder: (context, snapshot) {
                // Chargement
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Erreur
                if (snapshot.hasError) {
                  final errorMessage = snapshot.error.toString();
                  final isAuthError = errorMessage.contains('401') || 
                                     errorMessage.contains('NON_AUTHENTIFIÉ') ||
                                     errorMessage.contains('Unauthorized');

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            isAuthError ? Icons.lock_outline : Icons.error_outline,
                            size: 64,
                            color: isAuthError ? Colors.orange : Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isAuthError ? 'Non authentifié' : 'Erreur de chargement',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isAuthError ? Colors.orange.shade700 : Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isAuthError 
                              ? 'Veuillez vous connecter pour accéder à votre historique'
                              : 'Impossible de charger l\'historique',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (isAuthError) {
                                // Rediriger vers la page de connexion
                                Navigator.of(context).pushReplacementNamed('/login');
                              } else {
                                _loadPurchases();
                              }
                            },
                            icon: Icon(isAuthError ? Icons.login : Icons.refresh),
                            label: Text(isAuthError ? 'Se connecter' : 'Réessayer'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Données chargées
                final purchases = snapshot.data ?? [];

                if (purchases.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun achat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Votre historique d\'achats apparaîtra ici',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: purchases.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HistoryCard(item: purchases[index]);
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
