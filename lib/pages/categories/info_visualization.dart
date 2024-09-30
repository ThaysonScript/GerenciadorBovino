import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoVisualization extends StatelessWidget {
  final Data dados;
  final String nome;

  const InfoVisualization({super.key, required this.nome, required this.dados});

  @override
  Widget build(BuildContext context) {
    int index = dados.datas['nomes']!.indexOf(nome);
    
    // Se o nome não for encontrado, exibir uma mensagem
    if (index == -1) {
      return Scaffold(
        appBar: AppBar(title: const Text('Informações do Bovino')),
        body: const Center(child: Text('Boi não encontrado')),
      );
    }

    // // Obtendo os dados correspondentes
    // String idade = dados.datas['idade']![index];
    // String peso = dados.datas['peso']![index];
    // List<String> vacinas = List<String>.from(dados.datas['vacinas_cadastradas']![index] as Iterable);
    // String dataCadastro = dados.datas['data_cadastro']![index];
    // String imagem = dados.datas['images']![index]; // Ajuste conforme necessário

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "INFORMAÇÕES DO BOVINO - $nome",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.anton(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 50),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 186, 53, 33),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            "INFORMAÇÕES DO BOVINO",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.anton(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 50),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 186, 53, 33),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            "INFORMAÇÕES DE VACINAS",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.anton(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
