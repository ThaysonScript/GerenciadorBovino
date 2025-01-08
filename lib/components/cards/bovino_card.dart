import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BovinoCard extends StatelessWidget {
  final String dataCadastro;
  final String nome;
  final String idade;
  final String peso;
  final String vacinas;
  final String image;

  const BovinoCard({
    required this.dataCadastro,
    required this.nome,
    required this.idade,
    required this.peso,
    required this.vacinas,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegação
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(220, 42, 60, 71),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                image.isNotEmpty
                    ? Image.file(File(image))
                    : const Icon(Icons.image),
                const SizedBox(width: 5),
                const VerticalDivider(
                  thickness: 3,
                  color: Color.fromARGB(220, 42, 60, 71),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('DATA CADASTRO: $dataCadastro', style: GoogleFonts.anton(fontSize: 17)),
                    Text('NOME: $nome', style: GoogleFonts.anton(fontSize: 17)),
                    Text('IDADE: $idade ANOS', style: GoogleFonts.anton(fontSize: 17)),
                    Text('PESO: $peso KG', style: GoogleFonts.anton(fontSize: 17)),
                    Text('VACINAS: $vacinas', style: GoogleFonts.anton(fontSize: 17)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
