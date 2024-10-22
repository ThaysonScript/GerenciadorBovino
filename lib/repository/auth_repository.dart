import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<User?> registerWithEmailAndPassword(BuildContext context, String email, String password);
  Future<User?> loginWithEmailAndPassword(BuildContext context, String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
}
