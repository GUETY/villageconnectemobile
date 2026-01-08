import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Widget pour afficher des icônes SVG facilement
class SvgIcon extends StatelessWidget {
  final String assetName;    // Chemin du fichier SVG
  final double size;         // Taille de l'icône
  final Color color;         // Couleur de l'icône

  const SvgIcon(
    this.assetName, {
    super.key,
    this.size = 24,
    this.color = const Color(0xFF4A5FFF),
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}