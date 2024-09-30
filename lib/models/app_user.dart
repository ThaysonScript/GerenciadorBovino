import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/repositories/user_repository.dart';

class AppUser implements UserRepository {
  late int uid;
  late String name;
  late String email;
  late String password;

  @override
  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
  }

  @override
  Future<void> createUser(
      BuildContext context, String email, String senha) async {
    try {
      if (email.isNotEmpty && senha.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: senha,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preencha todos os campos')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Future<void> userSignIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email: ${e.code}')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Wrong password provided for that user: ${e.code}')));
      }
    }
  }
}
