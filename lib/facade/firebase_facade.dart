import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_bovino/services/auth_service.dart';
import 'package:gerenciador_bovino/services/firestore_service.dart';

class FirebaseFacade {
  // Instâncias dos serviços
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  // Métodos de Autenticação
  Future<User?> register(BuildContext context, String email, String password) {
    return _authService.registerWithEmailAndPassword(context, email, password);
  }

  Future<User?> login(BuildContext context, String email, String password) {
    return _authService.loginWithEmailAndPassword(context, email, password);
  }

  Future<void> logout() {
    return _authService.signOut();
  }

  User? getCurrentUser() {
    return _authService.getCurrentUser();
  }

  // Métodos do Firestore
  Future<void> addDocument(String collection, Map<String, dynamic> data) {
    return _firestoreService.addDocument(collection, data);
  }

  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data) {
    return _firestoreService.updateDocument(collection, documentId, data);
  }

  Future<void> deleteDocument(String collection, String documentId) {
    return _firestoreService.deleteDocument(collection, documentId);
  }

  Future<List<Map<String, dynamic>>> getDocuments(String collection) {
    return _firestoreService.getDocuments(collection);
  }

  Future<Map<String, dynamic>?> getDocumentById(String collection, String documentId) {
    return _firestoreService.getDocumentById(collection, documentId);
  }
}
