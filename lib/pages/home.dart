import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/db/database_helper.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/all_registers.dart';
import 'package:gerenciador_bovino/pages/categories/bovino_register.dart';
import 'package:gerenciador_bovino/pages/categories/info_visualization.dart';
import 'package:gerenciador_bovino/pages/categories/vacina_register.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final AppUser user;
  const Home(this.user, {super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Data dados = Data();
  int visibleItems = 0;
  bool useFictitiousData = false;

  // Adicione uma lista para armazenar as vacinas
  List<String> vacinasCadastradas = [];

  void loadData() async {
    if (useFictitiousData) {
      setState(() {
        dados.datas = Data().datas;
      });
    } else {
      final dbHelper = DatabaseHelper();
      final loadedBovinos = await dbHelper.getBovinos();

      // Ordenar os bovinos pela data de cadastro
      loadedBovinos.sort((a, b) {
        // Convertendo a data para DateTime para ordenar
        DateTime dataA = DateTime.parse(a.dataCadastro);
        DateTime dataB = DateTime.parse(b.dataCadastro);
        return dataB.compareTo(dataA); // Ordem decrescente
      });

      // Atualizando a lista de dados após ordenar
      setState(() {
        dados.datas['data_cadastro'] =
            loadedBovinos.map((bovino) => bovino.dataCadastro).toList();
        dados.datas['nomes'] =
            loadedBovinos.map((bovino) => bovino.nome).toList();
        dados.datas['idade'] =
            loadedBovinos.map((bovino) => bovino.idade).toList();
        dados.datas['peso'] =
            loadedBovinos.map((bovino) => bovino.peso).toList();
        dados.datas['vacinas_cadastradas'] =
            loadedBovinos.map((bovino) => bovino.vacinas.join(', ')).toList();
        dados.datas['images'] =
            loadedBovinos.map((bovino) => bovino.imagem).toList();
      });
    }
  }

  // Método que será chamado quando as vacinas forem atualizadas
  void updateVacinas(List<String> novasVacinas) {
    setState(() {
      vacinasCadastradas = novasVacinas; // Atualize a lista de vacinas
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    // Redefina o estado ao inicializar o widget, mesmo após o Hot Reload
    visibleItems = 3;
  }

  @override
  Widget build(BuildContext context) {
    visibleItems = dados.datas['nomes']?.length ?? 0;
    if (visibleItems > 3) {
      visibleItems = 3; // Limita a exibição a no máximo 3 itens
    }
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "BEM VINDO(A)   -   ${widget.user.name.isNotEmpty ? widget.user.name : ""}",
              style: GoogleFonts.anton(fontSize: 20, color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 186, 53, 33)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // const SizedBox(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 20, top: 40, bottom: 20),
                  //   ),
                  // ),
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
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BovinoRegister())).then((_) {
                              loadData();
                            })
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
                                horizontal: 10,
                                vertical: 10), // Padding interno
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
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VacinaRegister())).then((_) {
                              loadData();
                            })
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
                                horizontal: 10,
                                vertical: 10), // Padding interno
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
                                    builder: (context) => InfoVisualization(
                                          nome: widget.user.name,
                                          dados: dados,
                                          semRegistro: true,
                                        )))
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
                                horizontal: 10,
                                vertical: 10), // Padding interno
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
                                horizontal: 10,
                                vertical: 10), // Padding interno
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
                  // Verifica se o índice é válido dentro da lista
                  if (index < dados.datas['nomes']!.length) {
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
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'DATA CADASTRO: $data',
                                      style: GoogleFonts.anton(fontSize: 17),
                                    ),
                                    Text(
                                      'NOME: $nome',
                                      style: GoogleFonts.anton(fontSize: 17),
                                    ),
                                    Text(
                                      'IDADE: $idade ANOS',
                                      style: GoogleFonts.anton(fontSize: 17),
                                    ),
                                    Text(
                                      'PESO: $peso KG',
                                      style: GoogleFonts.anton(fontSize: 17),
                                    ),
                                    Text(
                                      'VACINAS: $vacinas',
                                      style: GoogleFonts.anton(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox
                        .shrink(); // Não exibe nada se o índice for inválido
                  }
                },
                childCount: visibleItems, // Limita a quantidade de itens a 3
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
                      borderRadius: BorderRadius.circular(
                          10), // Borda levemente arredondada
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
