import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/pages/general_informations/bovino_information.dart';
import 'package:gerenciador_bovino/pages/general_informations/vacina_information.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoVisualization extends StatelessWidget {
  final Data dados;
  final String? nome;
  final bool semRegistro;

  const InfoVisualization(
      {super.key, this.nome, required this.dados, required this.semRegistro});

  @override
  Widget build(BuildContext context) {
    int index = dados.datas['nomes']!.indexOf(nome!);

    // Se o nome não for encontrado, exibir uma mensagem
    if (index == -1 && semRegistro == false) {
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
      appBar: AppBar(
        title: Text(
          semRegistro == false ?
          "INFORMAÇÕES DO BOVINO - $nome"
          : "INFORMAÇÕES GERAIS",
          textAlign: TextAlign.center,
          style: GoogleFonts.anton(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 50),
                      child: ElevatedButton(
                      onPressed: () => {
                        if(semRegistro == false && nome != null) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const BovinoInformation()
                            )
                          )
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(double.infinity, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
                      ),
                      child: Center(
                        child: Text(
                          semRegistro == false ?
                          "INFORMAÇÕES DO BOVINO"
                          : "INFORMAÇÕES DE BOVINOS",
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
                      child: ElevatedButton(
                      onPressed: () => {
                        if(semRegistro == false && nome != null) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const VacinaInformation()
                            )
                          )
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(double.infinity, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
                      ),
                      child: Center(
                        child: Text(
                          semRegistro == false ?
                          "INFORMAÇÕES DAS VACINAS"
                          :"INFORMAÇÕES DE VACINAS",
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
