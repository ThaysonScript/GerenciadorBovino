import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/all_registers.dart';
import 'package:gerenciador_bovino/pages/categories/info_visualization.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final AppUser user;
  const Home(this.user, {super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Data dados = Data();
  int visibleItems = 3;

  @override
  void initState() {
    super.initState();
    // Redefina o estado ao inicializar o widget, mesmo após o Hot Reload
    visibleItems = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40, bottom: 20),
                  child: Text(
                    "BEM VINDO(A) - ${widget.user.name}",
                    style: GoogleFonts.anton(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 42, 60, 71)),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
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
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(180, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
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
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(180, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
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
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => InfoVisualization(nome: widget.user.name, dados: dados, semRegistro: true,)
                          )
                        )
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(180, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
                      ),
                      child: Center(
                        child: Text(
                          "VER INFORMAÇÕES",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.anton(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 186, 53, 33), // Cor do texto branco
                        fixedSize:
                            const Size(180, 150), // Tamanho mínimo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Borda levemente arredondada
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10), // Padding interno
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
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30),
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
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
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
                                )));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromARGB(220, 42, 60, 71),
                              width: 3)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Image.asset('$images'),
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
                  ));
            },
            // childCount: dados.datas['nomes']!.length,
            childCount: visibleItems,
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                // Navega para a tela com todos os registros
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRegisters(dados: dados),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 186, 53, 33),
                minimumSize: const Size(300, 70), // Tamanho mínimo do botão
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Borda levemente arredondada
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding interno
              ),
              child: Text(
                "VER TODOS OS REGISTROS",
                style: GoogleFonts.anton(fontSize: 20, color: Colors.white),
              ),
            ),
          )),
        ),
      ],
    ));
  }
}

/*

Stack(
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
    )

*/