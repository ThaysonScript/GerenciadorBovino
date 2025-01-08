import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/layout/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';

class Gestures extends StatelessWidget {
  final Color cor;
  final String texto;
  final Future<void> Function()? acaoClique;

  const Gestures(
      {super.key,
      required this.cor,
      required this.texto,
      required this.acaoClique});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: acaoClique,
      child: Container(
        width: ResponsiveLayout.scaleWidth(280),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: cor,
        ),
        child: Center(
          child: Text(
            texto,
            style: GoogleFonts.anton(fontSize: 35),
          ),
        ),
      ),
    );
  }
}
