class Vacina {
  final int? id;
  final String nome;
  final String data;

  Vacina({this.id, required this.nome, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data': data,
    };
  }

  static Vacina fromMap(Map<String, dynamic> map) {
    return Vacina(
      id: map['id'],
      nome: map['nome'],
      data: map['data'],
    );
  }
}
