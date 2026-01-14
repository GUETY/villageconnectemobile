import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../data/forfaits_api.dart';
import '../package_entity.dart';
import '../widgets/package_card.dart';
import '../widgets/packages_header.dart';

// Contenu de la page forfaits
class PackagesPageContent extends StatefulWidget {
  const PackagesPageContent({super.key});

  @override
  State<PackagesPageContent> createState() => _PackagesPageContentState();
}

class _PackagesPageContentState extends State<PackagesPageContent> {
  // Liste des forfaits
  List<PackageEntity> _packages = [];
  
  // État de chargement
  bool _isLoading = true;
  
  // Message d'erreur
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Charger les forfaits au démarrage
    _loadPackages();
  }

  // Charger les forfaits depuis l'API
  Future<void> _loadPackages() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Appeler l'API
    final response = await ForfaitsApi.getAll();

    if (mounted) {
      setState(() {
        if (response.success && response.data != null) {
          // Succès
          _packages = response.data!;
          _isLoading = false;
        } else {
          // Erreur
          _errorMessage = response.message ?? 'Erreur inconnue';
          _isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Afficher le loader
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }

    // Afficher l'erreur
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadPackages,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      );
    }

    // Afficher les forfaits
    if (_packages.isEmpty) {
      return const Center(
        child: Text('Aucun forfait disponible'),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // En-tête
          const PackagesHeader(),
          
          // Liste des forfaits
          ..._packages.map((package) {
            return PackageCard(
              package: package,
              onBuyPressed: () {
                // Action d'achat
              },
            );
          }).toList(),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}