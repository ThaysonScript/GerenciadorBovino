import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/pages/categories/info_visualization.dart';
import 'package:google_fonts/google_fonts.dart';

class AllRegisters extends StatelessWidget {
  final Data dados;

  const AllRegisters({required this.dados, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'TODOS OS REGISTROS',
            style: GoogleFonts.anton(fontSize: 30, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 186, 53, 33),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            itemCount: dados.datas['nomes']!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = dados.datas['data_cadastro']![index];
              var nome = dados.datas['nomes']![index];
              var idade = dados.datas['idade']![index];
              var peso = dados.datas['peso']![index];
              var vacinas = dados.datas['vacinas_cadastradas']![index];
              Object images = dados.datas['images']![index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoVisualization(
                        nome: nome,
                        dados: dados,
                        semRegistro: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromARGB(220, 42, 60, 71), width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        '$images'.isNotEmpty
                                    ? Image.file(File('$images'))
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
                            Text(
                              'DATA CADASTRO: $data',
                              style: GoogleFonts.anton(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'NOME: $nome',
                              style: GoogleFonts.anton(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'IDADE: $idade ANOS',
                              style: GoogleFonts.anton(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'PESO: $peso KG',
                              style: GoogleFonts.anton(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'VACINAS: $vacinas',
                              style: GoogleFonts.anton(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
