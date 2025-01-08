import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/database/sqlite_database.dart';
import 'package:gerenciador_bovino/models/bovino.dart';
import 'package:gerenciador_bovino/models/vacina.dart';
import 'package:gerenciador_bovino/models/acessorio.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BovinoRepository {
  final SqliteDatabase _sqliteDatabase = SqliteDatabase.instance;

  Future<int> registrarBovino({
    required String nome,
    required int idade,
    required String imagemPath,
    required DateTime dataCompra,
    required double precoCompra,
    required double peso,
    required DateTime dataPeso,
    List<Vacina>? vacinas,
    List<Acessorio>? acessorios,
  }) async {
    final db = await _sqliteDatabase.database;

    // Iniciar transação
    return await db.transaction((txn) async {
      // Inserir o bovino
      int bovinoId = await txn.insert('Bovino', {
        'nome': nome,
        'idade': idade,
        'imagem': imagemPath,
        'data_compra': dataCompra.toIso8601String(),
        'preco': precoCompra,
        'peso': peso,
        'data_peso': dataPeso.toIso8601String(),
      });

      // Adicionar vacinas associadas
      if (vacinas != null) {
        for (Vacina vacina in vacinas) {
          await txn.insert('Bovino_Vacina', {
            'bovino_id': bovinoId,
            'vacina_id': vacina.id,
            'aplicacoes': 1, // Exemplo: define uma aplicação por padrão
          });
        }
      }

      // Adicionar acessórios associados
      if (acessorios != null) {
        for (Acessorio acessorio in acessorios) {
          await txn.insert('Bovino_Acessorio', {
            'bovino_id': bovinoId,
            'acessorio_id': acessorio.id,
            'aplicacoes': 1, // Exemplo: define uma aplicação por padrão
          });
        }
      }

      // Registrar imagens
      int imagemId = await txn.insert('Imagem', {'caminho': imagemPath});
      await txn.insert('Bovino_Imagem', {
        'bovino_id': bovinoId,
        'imagem_id': imagemId,
      });

      return bovinoId;
    });
  }

  Future<List<Map<String, dynamic>>> getAllBovinos() async {
    final db = await _sqliteDatabase.database;
    return await db.query('Bovino');
  }

  Future<void> saveBovino(GlobalKey<FormState> formKey, Bovino bovino) async {
    final db = await _sqliteDatabase.database;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      debugPrint('Tentando salvar o bovino...');
      debugPrint('Nome: ${bovino.nome}');
      debugPrint('Idade: ${bovino.idade}');
      debugPrint('Peso: ${bovino.peso}');
      debugPrint('Imagem: ${bovino.imagens}');
      debugPrint(
          'Vacinas selecionadas: ${bovino.vacinas.map((v) => v.nome).toList()}');

      try {
        if (bovino.idade <= 0) throw Exception('Idade inválida.');
        if (bovino.peso <= 0) throw Exception('Peso inválido.');
        if (bovino.imagens.isEmpty)
          throw Exception('Imagem não foi selecionada.');

        debugPrint('Chamando método registrarBovino...');

        int bovinoId = await db.insert(
          'Bovino',
          bovino.toMap(), // Insert using the toMap() method
          // conflictAlgorithm: ConflictAlgorithm.replace,
        );

        debugPrint('Bovino registrado com sucesso! ID: $bovinoId');
      } catch (e) {
        debugPrint('Erro ao registrar o bovino: $e');
      }
    } else {
      debugPrint('Formulário inválido.');
    }
  }
}
