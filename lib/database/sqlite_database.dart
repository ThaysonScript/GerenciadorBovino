import 'package:gerenciador_bovino/database/tables.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteDatabase {
  static final SqliteDatabase instance = SqliteDatabase._internal();

  static Database? _database;

  SqliteDatabase._internal();

  Future<void> _criarTabelas(Database db, int version) async {
    // tabelas padroes e gerais
    await Tables().gerarTabelaUsuario(db, version);
    await Tables().gerarTabelaBovino(db, version);
    await Tables().gerarTabelaVacina(db, version);
    await Tables().gerarTabelaAcessorio(db, version);

    // tabela imagem e seus relacionamentos
    await Tables().gerarTabelaImagem(db, version);
    await Tables().gerarTabelaRelacionamentoBovinoImagem(db, version);
    await Tables().gerarTabelaRelacionamentoVacinaImagem(db, version);
    await Tables().gerarTabelaRelacionamentoAcessorioImagem(db, version);

    // tabela de relacionamento de bovino
    await Tables().gerarTabelaRelacionamentoBovinoVacina(db, version);
    await Tables().gerarTabelaRelacionamentoBovinoAcessorio(db, version);
  }

  Future<Database> _iniciarBanco() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/gerenciador_bovino.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _criarTabelas,
    );
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _iniciarBanco();
    return _database!;
  }
}
