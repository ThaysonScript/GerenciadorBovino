import 'package:gerenciador_bovino/models/bovino.dart';
import 'package:gerenciador_bovino/models/vacina.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'produtos.db');
    return await openDatabase(
      path,
      version: 2, // Atualize para versão 2
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE vacinas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      data TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE bovinos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      idade TEXT NOT NULL,
      peso TEXT NOT NULL,
      imagem TEXT NOT NULL,
      vacinas TEXT,
      dataCadastro TEXT NOT NULL
    )
  ''');
  }

  // Métodos para Vacinas
  Future<void> insertVacina(Vacina vacina) async {
    final db = await database;
    await db.insert(
      'vacinas',
      vacina.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Vacina>> getVacinas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('vacinas');

    return List.generate(maps.length, (i) {
      return Vacina.fromMap(maps[i]);
    });
  }

  Future<void> updateVacina(Vacina vacina) async {
    final db = await database;
    await db.update('vacinas', vacina.toMap(),
        where: 'id = ?', whereArgs: [vacina.id]);
  }

  Future<void> deleteVacina(int id) async {
    final db = await database;
    await db.delete(
      'vacinas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Métodos para Bovinos
  Future<void> insertBovino(Bovino bovino) async {
    final db = await database;

    // Convertendo a lista de vacinas para string separada por vírgulas
    String vacinasString = bovino.vacinas.join(',');

    await db.insert(
      'bovinos',
      {
        'nome': bovino.nome,
        'idade': bovino.idade,
        'peso': bovino.peso,
        'imagem': bovino.imagem,
        'vacinas': vacinasString, // Armazenando a string de vacinas
        'dataCadastro': bovino.dataCadastro, // Incluir data de cadastro
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Bovino>> getBovinos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bovinos');

    return List.generate(maps.length, (i) {
      // Convertendo a string de vacinas de volta para lista
      List<String> vacinas =
          maps[i]['vacinas'] != null ? maps[i]['vacinas'].split(',') : [];

      return Bovino(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        idade: maps[i]['idade'],
        peso: maps[i]['peso'],
        imagem: maps[i]['imagem'],
        vacinas: vacinas,
        dataCadastro: maps[i]['dataCadastro'], // Obtendo a data de cadastro
      );
    });
  }

  Future<void> updateBovino(Bovino bovino) async {
    final db = await database;
    String vacinasString = bovino.vacinas.join(',');

    await db.update(
      'bovinos',
      {
        'nome': bovino.nome,
        'idade': bovino.idade,
        'peso': bovino.peso,
        'imagem': bovino.imagem,
        'vacinas': vacinasString, // Atualizando a string de vacinas
        'dataCadastro': bovino.dataCadastro, // Atualizando a data de cadastro
      },
      where: 'id = ?',
      whereArgs: [bovino.id],
    );
  }

  Future<void> deleteBovino(int id) async {
    final db = await database;
    await db.delete(
      'bovinos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
