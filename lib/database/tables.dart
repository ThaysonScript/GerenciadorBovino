import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Tables {
  Future<void> gerarTabelaUsuario(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Usuario (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          senha TEXT NOT NULL,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');
  }

  /// BOVINO
  ///
  /// nome
  /// idade = null
  /// imagens
  /// data_compra
  /// preco_compra
  /// peso
  /// vacinas_associadas
  /// acessorios_associados
  Future<void> gerarTabelaBovino(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Bovino (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          idade INTEGER,
          imagens TEXT,
          data_compra TEXT,
          peso REAL,
          preco_compra REAL,
          vacinas TEXT,
          acessorios TEXT,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
    ''');
  }

  ///  * VACINA
  ///
  /// nome
  /// imagens
  /// preco_compra
  /// data_compra
  /// qtd_aplicacoes = [int: qtd aplicada, Double: mls aplicados/null, int: dose em comprimido por exemplo/algo parecido]
  /// vencimento
  /// bovinosPertencentes
  Future<void> gerarTabelaVacina(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Vacina (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          preco REAL NOT NULL,
          vencimento DATE NOT NULL,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
      ''');
  }

  /// ACESSORIOS
  ///
  /// nome
  /// imagens
  /// preco_compra
  /// data_compra
  /// qtd_aplicacoes = [int: qtd aplicada]
  /// vencimento
  /// bovinosPertencentes
  Future<void> gerarTabelaAcessorio(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Acessorio (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          preco REAL NOT NULL,
          vencimento DATE NOT NULL,
          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
      ''');
  }

  // -- Tabela de relacionamento Bovino_Vacina
  Future<void> gerarTabelaRelacionamentoBovinoVacina(
      Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Bovino_Vacina (
          bovino_id INTEGER NOT NULL,
          vacina_id INTEGER NOT NULL,
          aplicacoes INTEGER DEFAULT 0,
          FOREIGN KEY (bovino_id) REFERENCES Bovino (id) ON DELETE CASCADE,
          FOREIGN KEY (vacina_id) REFERENCES Vacina (id) ON DELETE CASCADE,
          PRIMARY KEY (bovino_id, vacina_id)
        );
      ''');
  }

// -- Tabela de relacionamento Bovino_Acessorio
  Future<void> gerarTabelaRelacionamentoBovinoAcessorio(
      Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Bovino_Acessorio (
          bovino_id INTEGER NOT NULL,
          acessorio_id INTEGER NOT NULL,
          aplicacoes INTEGER DEFAULT 0,
          FOREIGN KEY (bovino_id) REFERENCES Bovino (id) ON DELETE CASCADE,
          FOREIGN KEY (acessorio_id) REFERENCES Acessorio (id) ON DELETE CASCADE,
          PRIMARY KEY (bovino_id, acessorio_id)
        );
      ''');
  }

  // -- Tabela Imagens (usada para relacionar com Bovino, Vacina e Acessorio)
  Future<void> gerarTabelaImagem(Database db, int version) async {
    return await db.execute('''
      CREATE TABLE Imagem (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          caminho TEXT NOT NULL
      );
    ''');
  }

  // -- Tabela de relacionamento Bovino_Imagem
  Future<void> gerarTabelaRelacionamentoBovinoImagem(
      Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Bovino_Imagem (
          bovino_id INTEGER NOT NULL,
          imagem_id INTEGER NOT NULL,
          FOREIGN KEY (bovino_id) REFERENCES Bovino (id) ON DELETE CASCADE,
          FOREIGN KEY (imagem_id) REFERENCES Imagem (id) ON DELETE CASCADE,
          PRIMARY KEY (bovino_id, imagem_id)
        );
      ''');
  }

  // -- Tabela de relacionamento Vacina_Imagem
  Future<void> gerarTabelaRelacionamentoVacinaImagem(
      Database db, int version) async {
    return await db.execute('''
      CREATE TABLE Vacina_Imagem (
        vacina_id INTEGER NOT NULL,
        imagem_id INTEGER NOT NULL,
        FOREIGN KEY (vacina_id) REFERENCES Vacina (id) ON DELETE CASCADE,
        FOREIGN KEY (imagem_id) REFERENCES Imagem (id) ON DELETE CASCADE,
        PRIMARY KEY (vacina_id, imagem_id)
      );
    ''');
  }

  // -- Tabela de relacionamento Acessorio_Imagem
  Future<void> gerarTabelaRelacionamentoAcessorioImagem(
      Database db, int version) async {
    return await db.execute('''
      CREATE TABLE Acessorio_Imagem (
          acessorio_id INTEGER NOT NULL,
          imagem_id INTEGER NOT NULL,
          FOREIGN KEY (acessorio_id) REFERENCES Acessorio (id) ON DELETE CASCADE,
          FOREIGN KEY (imagem_id) REFERENCES Imagem (id) ON DELETE CASCADE,
          PRIMARY KEY (acessorio_id, imagem_id)
      );
    ''');
  }
}
