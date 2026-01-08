import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/theme/app_colors.dart';

// Page pour scanner un code QR avec prévisualisation en direct
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

// État de la page scanner
class _QRScannerPageState extends State<QRScannerPage> {
  // Contrôleur du scanner (gère la caméra)
  late MobileScannerController controller;
  
  // Flag pour éviter les scans multiples du même code
  bool _scanned = false;

  @override
  void initState() {
    super.initState();
    // Initialiser le contrôleur de scanner
    controller = MobileScannerController(
      autoStart: true,  // Démarrer automatiquement la caméra
      torchEnabled: false,  // Torche éteinte par défaut
    );
  }

  @override
  void dispose() {
    // Libérer les ressources (caméra, etc.)
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application avec bouton retour
      appBar: AppBar(
        // Titre de la page
        title: const Text('Scanner Code QR'),
        // Couleur de fond (bleu)
        backgroundColor: AppColors.primary,
        // Pas d'ombre
        elevation: 0,
        // Bouton retour personnalisé
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      
      // Corps : afficher la caméra pour scanner
      body: MobileScanner(
        // Passer le contrôleur
        controller: controller,
        
        // Callback quand un code QR est détecté
        onDetect: (capture) {
          // Si déjà scanné, ignorer
          if (_scanned) return;

          // Récupérer la liste des codes détectés
          final List<BarcodeCapture> barcodes = [capture];
          
          // Parcourir chaque capture détectée
          for (final barcodeCapture in barcodes) {
            // Extraire les codes de la capture
            for (final barcode in barcodeCapture.barcodes) {
              // Extraire la valeur du code QR
              final String? code = barcode.rawValue;

              // Si le code existe
              if (code != null) {
                // Marquer comme scanné
                _scanned = true;

                // Afficher un dialog de confirmation
                _showConfirmDialog(code);
              }
            }
          }
        },
      ),
      
      // Bouton flottant pour allumer/éteindre la torche
      floatingActionButton: FloatingActionButton(
        // Couleur de fond (bleu)
        backgroundColor: AppColors.primary,
        
        // Callback au clic
        onPressed: () async {
          // Basculer la torche (on/off)
          await controller.toggleTorch();
          // Rafraîchir l'interface
          setState(() {});
        },
        
        // Contenu du bouton (icône changeante)
        child: ValueListenableBuilder(
          // Écouter l'état de la torche
          valueListenable: controller.torchState,
          
          // Builder pour reconstruire l'icône
          builder: (context, state, child) {
            // Afficher l'icône correspondant à l'état
            switch (state) {
              // Torche allumée
              case TorchState.on:
                return const Icon(Icons.flashlight_on);
              
              // Torche éteinte
              case TorchState.off:
                return const Icon(Icons.flashlight_off);
              
              // Torche éteinte
              case TorchState.off:
                return const Icon(Icons.flash_off);
              
              // Mode auto (Android seulement)
              // case TorchState.auto:
              //   return const Icon(Icons.flash_auto);
            }
          },
        ),
      ),
    );
  }

  // Afficher un dialog pour confirmer le code scanné
  void _showConfirmDialog(String code) {
    showDialog(
      // Contexte pour le dialog
      context: context,
      
      // Ne pas fermer en cliquant en dehors
      barrierDismissible: false,
      
      // Builder du dialog
      builder: (context) => AlertDialog(
        // Titre du dialog
        title: const Text('Code Scanné'),
        
        // Contenu du dialog
        content: Column(
          // Taille minimale
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône de succès (cercle vert)
            const Icon(
              Icons.check_circle,
              color: AppColors.primary,
              size: 48,
            ),
            const SizedBox(height: 16),
            
            // Afficher le code scanné
            Text(
              'Code détecté :\n$code',
              // Texte centré
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        // Boutons du dialog
        actions: [
          // Bouton "Rescanner"
          TextButton(
            onPressed: () {
              // Fermer le dialog
              Navigator.of(context).pop();
              // Permettre un nouveau scan
              _scanned = false;
            },
            child: const Text('Rescanner'),
          ),
          
          // Bouton "Confirmer"
          ElevatedButton(
            onPressed: () {
              // Fermer le dialog
              Navigator.of(context).pop();
              // Fermer la page et retourner le code
              Navigator.of(context).pop(code);
            },
            // Style du bouton (bleu)
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }
}