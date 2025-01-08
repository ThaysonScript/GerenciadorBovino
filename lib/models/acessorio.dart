import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/models/bovino.dart';
import 'package:gerenciador_bovino/models/enums.dart';

/// ACESSORIOS
/// 
/// nome
/// imagens
/// preco_compra
/// data_compra
/// qtd_aplicacoes = [int: qtd aplicada]
/// vencimento
/// bovinosPertencentes
/// 
class Acessorio {
  final int? id;
  final String nome;
  final List<Image> imagens;
  final Double preco;
  final DateTime dataCompra;
  final Map<String, Aplicacoes> quantidadeAplicacoes;
  final DateTime vencimento;
  final List<Bovino> bovinosPertencentes;
  final Timestamp timestamp;

  Acessorio(
      {this.id,
      required this.nome,
      this.imagens = const [],
      required this.preco,
      required this.dataCompra,
      this.quantidadeAplicacoes = const {},
      required this.vencimento,
      this.bovinosPertencentes = const [],
      required this.timestamp
      });

  // Método toMap para converter o objeto em um mapa exigido pelo sqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imagens': imagens,
      'preco': preco,
      'dataCompra': dataCompra,
      'quantidade_aplicacoes': jsonEncode(quantidadeAplicacoes),
      'vencimento': vencimento,
      'bovinos_pertencentes': bovinosPertencentes
          .map((bovinosPertencentes) => bovinosPertencentes.toMap())
          .toList(),
      'timestamp': timestamp.millisecondsSinceEpoch
    };
  }

  // Método fromMap para converter de mapa para objeto (quando você buscar os dados do banco) e usar na aplicacao
  static Acessorio fromMap(Map<String, dynamic> map) {
    return Acessorio(
        id: map['id'],
        nome: map['nome'],
        imagens: List<Image>.from(map['imagens'] ?? []),
        preco: map['preco'],
        dataCompra: map['dataCompra'],
        bovinosPertencentes: (map['bovinos_pertencentes'] as List<dynamic>?)
                ?.map((item) => Bovino.fromMap(item))
                .toList() ??
            [],
        vencimento: map['vencimento'],
        quantidadeAplicacoes: Map<String, Aplicacoes>.from(jsonDecode(map['quantidade_aplicacoes'] ?? '{}')),
        timestamp: map['timestamp']);
  }
}
