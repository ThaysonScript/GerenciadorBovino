import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/repository/auth_repository.dart';

class AuthService implements AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User?> registerWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print('Erro ao registrar: $e');
      return null;
    }
  }

  @override
  Future<User?> loginWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print('Erro ao fazer login: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}