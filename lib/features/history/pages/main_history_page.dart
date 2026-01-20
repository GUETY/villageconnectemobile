import 'package:flutter/material.dart';
import 'package:villageconnecte_mobile/core/theme/app_colors.dart';
import 'package:villageconnecte_mobile/features/history/history_entity.dart';
import 'package:villageconnecte_mobile/features/history/widgets/history_card.dart';
import 'package:villageconnecte_mobile/features/packages/data/forfaits_api.dart';

// Page Historique principale (sans Scaffold, gérée par MainScreen)
class HistoryPageContent extends StatelessWidget {
  const HistoryPageContent({super.key});

  Future<List<HistoryItem>> _fetchHistory() async {
    final response = await ForfaitsApi.getMyCodes(); // ou getMyTransactions()
    print(response.data); // <--- Ajoute cette ligne ici pour voir la structure de la réponse API
    if (response.success && response.data != null) {
      return (response.data as List)
          .map((json) => HistoryItem.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryItem>>(
      future: _fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Erreur lors du chargement de l\'historique'));
        }
        final purchases = snapshot.data ?? [];

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

              const SizedBox(height: 12),

              // Section titre
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Mes Achats',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),

              // Liste des achats
              ListView.builder(
                itemCount: purchases.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryCard(item: purchases[index]);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
