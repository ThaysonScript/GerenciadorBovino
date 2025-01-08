import 'dart:convert';
import 'package:gerenciador_bovino/models/acessorio.dart';
import 'package:gerenciador_bovino/models/vacina.dart';

/// BOVINO
///
/// nome
/// idade = null
/// imagens
/// data_compra
/// preco_compra
/// peso
/// data_peso
/// vacinas_associadas
/// acessorios_associados
///
class Bovino {
  late int? id;
  late String nome;
  late int idade;
  late List<String> imagens;
  late DateTime dataCompra;
  late double peso;
  late double precoCompra;
  late List<Vacina> vacinas;
  late List<Acessorio> acessorios;
  late DateTime timestamp;

  Bovino({
    this.id,
    required this.nome,
    required this.idade,
    this.imagens = const [],
    required this.dataCompra,
    required this.peso,
    required this.precoCompra,
    this.vacinas = const [],
    this.acessorios = const [],
    required this.timestamp,
  });

  // Método toMap para converter o objeto em um mapa exigido pelo sqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'imagens': jsonEncode(imagens), // Convert List<String> to JSON string
      'data_compra': dataCompra.toIso8601String(),
      'peso': peso,
      'preco_compra': precoCompra,
      'vacinas': jsonEncode(vacinas.map((vacina) => vacina.toMap()).toList()),
      'acessorios':
          jsonEncode(acessorios.map((acessorio) => acessorio.toMap()).toList()),
      'timestamp': timestamp.microsecondsSinceEpoch
    };
  }

  // Método fromMap para converter de mapa para objeto (quando você buscar os dados do banco) e usar na aplicacao
  static Bovino fromMap(Map<String, dynamic> map) {
    return Bovino(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      imagens: (map['imagens'] != null)
          ? List<String>.from(jsonDecode(map['imagens']))
          : [],
      dataCompra: DateTime.parse(map['data_compra']),
      peso: map['peso'],
      precoCompra: map['preco_compra'],
      vacinas: (map['vacinas'] != null)
          ? List<Vacina>.from(jsonDecode(map['vacinas'])
              .map((vacinaMap) => Vacina.fromMap(vacinaMap)))
          : [],
      acessorios: (map['acessorios'] != null)
          ? List<Acessorio>.from(jsonDecode(map['acessorios'])
              .map((acessorioMap) => Acessorio.fromMap(acessorioMap)))
          : [],
      timestamp: DateTime.fromMicrosecondsSinceEpoch(map['timestamp']),
    );
  }
}
