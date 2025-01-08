import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final int? id;
  final String nome;
  final String email;
  final String senha;
  late Timestamp? timestamp;

  AppUser(
      {this.id,
      required this.nome,
      required this.email,
      required this.senha,
      this.timestamp});

  // Método toMap para converter o objeto em um mapa exigido pelo sqlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'timestamp': timestamp?.millisecondsSinceEpoch
    };
  }

  // Método fromMap para converter de mapa para objeto (quando você buscar os dados do banco) e usar na aplicacao
  static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
        id: map['id'],
        nome: map['nome'],
        email: map['email'],
        senha: map['senha'],
        timestamp: map['timestamp']);
  }
}
