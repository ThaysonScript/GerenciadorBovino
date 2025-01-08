import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/components/buttons/custom_elevated_button.dart';
import 'package:gerenciador_bovino/components/cards/bovino_card.dart';
import 'package:gerenciador_bovino/components/secoes/section_title.dart';
import 'package:gerenciador_bovino/data/data.dart';
import 'package:gerenciador_bovino/database/repository/bovino_repository.dart';
import 'package:gerenciador_bovino/models/app_user.dart';
import 'package:gerenciador_bovino/pages/all_registers.dart';
import 'package:gerenciador_bovino/pages/categories/bovino_register.dart';
import 'package:gerenciador_bovino/pages/categories/info_visualization.dart';
import 'package:gerenciador_bovino/pages/categories/vacina_register.dart';

class Home extends StatefulWidget {
  final AppUser user;
  const Home(this.user, {super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final Data dados = Data();
  int visibleItems = 0;
  bool useFictitiousData = false;
  List<String> vacinasCadastradas = [];

  void loadData() async {
    try {
      final bovinoRepository = BovinoRepository();
      final loadedBovinos = await bovinoRepository.getAllBovinos();

      // Processar os dados do banco
      setState(() {
        dados.datas['data_cadastro'] = List<String>.from(
          loadedBovinos.map((bovino) {
            var dataCompra = bovino['data_compra'];
            if (dataCompra != null && dataCompra.isNotEmpty) {
              // Converter para DateTime
              var parsedDate = DateTime.parse(dataCompra);
              // Extrair dia, mês e ano manualmente
              return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
            } else {
              return ''; // Caso não tenha data, retorna uma string vazia
            }
          }),
        );

        dados.datas['nomes'] = List<String>.from(
            loadedBovinos.map((bovino) => bovino['nome'] ?? ''));

        dados.datas['idade'] = List<String>.from(
            loadedBovinos.map((bovino) => bovino['idade'].toString()));

        dados.datas['peso'] = List<String>.from(
            loadedBovinos.map((bovino) => bovino['peso'].toString()));

        dados.datas['vacinas_cadastradas'] =
            List<String>.from(loadedBovinos.map((bovino) => 'N/A'));

        dados.datas['images'] = List<String>.from(
            loadedBovinos.map((bovino) => bovino['imagem'] ?? ''));
      });
    } catch (e) {
      print("Erro ao carregar os dados: $e");
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
    WidgetsBinding.instance.addObserver(this);

    // Redefina o estado ao inicializar o widget, mesmo após o Hot Reload
    visibleItems = 3;
  }

  @override
  void dispose() {
    // Remove o observer quando o widget for descartado
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    try {
      // final FirebaseFacade firebaseFacade = FirebaseFacade();

      if (state == AppLifecycleState.paused ||
          state == AppLifecycleState.detached) {
        // firebaseFacade.logout();
      }
    } catch (e) {
      print(e);
    }
  }

  // Dentro do build de _HomeState
@override
Widget build(BuildContext context) {
  visibleItems = dados.datas['nomes']?.length ?? 0;
  if (visibleItems > 3) {
    visibleItems = 3; // Limita a exibição a no máximo 3 itens
  }
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 186, 53, 33),
    ),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SectionTitle(title: "CATEGORIAS"),
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
                    CustomElevatedButton(
                      text: "CADASTRAR BOVINO",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BovinoRegister(),
                          ),
                        ).then((_) {
                          loadData();
                        });
                      },
                    ),
                    CustomElevatedButton(
                      text: "CADASTRAR VACINAS",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VacinaRegister(),
                          ),
                        ).then((_) {
                          loadData();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      text: "VER INFORMAÇÕES",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoVisualization(
                              dados: dados,
                              semRegistro: true,
                            ),
                          ),
                        );
                      },
                    ),
                    CustomElevatedButton(
                      text: "DELETAR INFORMAÇÕES",
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionTitle(title: "CADASTROS RECENTES"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index < dados.datas['nomes']!.length) {
                var data = dados.datas['data_cadastro']![index];
                var nome = dados.datas['nomes']![index];
                var idade = dados.datas['idade']![index];
                var peso = dados.datas['peso']![index];
                var vacinas = dados.datas['vacinas_cadastradas']![index];
                var image = dados.datas['images']![index];

                return BovinoCard(
                  dataCadastro: data,
                  nome: nome,
                  idade: idade,
                  peso: peso,
                  vacinas: vacinas,
                  image: image,
                );
              } else {
                return SizedBox.shrink();
              }
            },
            childCount: visibleItems,
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: CustomElevatedButton(
                text: "VER TODOS OS REGISTROS",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllRegisters(dados: dados),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}