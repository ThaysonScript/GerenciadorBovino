class Bovino {
  final int? id;
  final String nome;
  final String idade;
  final String peso;
  final String imagem;
  final List<String> vacinas;
  final String dataCadastro;  // Nova propriedade para a data de cadastro

  Bovino({
    this.id,
    required this.nome,
    required this.idade,
    required this.peso,
    required this.imagem,
    required this.vacinas,
    required this.dataCadastro, // Inicialização da data de cadastro
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'peso': peso,
      'imagem': imagem,
      'vacinas': vacinas.join(','), // Armazenar vacinas como uma string separada por vírgulas
      'dataCadastro': dataCadastro,  // Incluir a data de cadastro no map
    };
  }

  static Bovino fromMap(Map<String, dynamic> map) {
    return Bovino(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
      peso: map['peso'],
      imagem: map['imagem'],
      vacinas: map['vacinas'].split(','),
      dataCadastro: map['dataCadastro'],  // Atribuir o valor de dataCadastro
    );
  }

  // Método para obter a data atual formatada
  static String getCurrentDate() {
    return DateTime.now().toIso8601String(); // Retorna a data no formato ISO 8601
  }
}
