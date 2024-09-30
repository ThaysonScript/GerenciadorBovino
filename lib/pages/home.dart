import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/categories/info_visualization.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  AppUser user;
  Home(this.user, {super.key});

  final Data dados = Data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text(
                  "BEM VINDO(A) - ${user.name}",
                  style: GoogleFonts.anton(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 42, 60, 71)),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("CATEGORIAS",
                    style: GoogleFonts.anton(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 42, 60, 71))),
              ),
            ),
            const Divider(
                thickness: 3,
                height: 10,
                endIndent: 200,
                color: Color.fromARGB(255, 42, 60, 71))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 53, 33),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "CADASTRAR BOVINO",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 53, 33),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "CADASTRAR VACINAS",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 53, 33),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "VISUALIZAR INFORMAÇÕES",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 186, 53, 33),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "DELETAR INFORMAÇÕES",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.anton(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 520),
                child: Text("CADASTROS RECENTES",
                    style: GoogleFonts.anton(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 42, 60, 71))),
              ),
            ),
            const Divider(
                thickness: 3,
                height: 10,
                endIndent: 200,
                color: Color.fromARGB(255, 42, 60, 71))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 560),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: dados.datas['nomes']!.length, // Número de bois

            itemBuilder: (BuildContext context, int index) {
              var data = dados.datas['data_cadastro']![index];
              var nome = dados.datas['nomes']![index];
              var idade = dados.datas['idade']![index];
              var peso = dados.datas['peso']![index];
              var vacinas = dados.datas['vacinas_cadastradas']![index];

              Object images = dados.datas['images']![index];

              return GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => InfoVisualization(nome: nome, dados: dados,)
                    )
                  )
                },
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color.fromARGB(220, 42, 60, 71),
                          width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          '$images',
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                          thickness: 3,
                          color: Color.fromARGB(220, 42, 60, 71),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                                'DATA CADASTRO: $data\nNOME: $nome\nIDADE: $idade ANOS\nPESO: $peso KG\nVACINAS: $vacinas',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        )
      ],
    ));
  }
}
