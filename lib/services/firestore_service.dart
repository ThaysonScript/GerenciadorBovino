import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciador_bovino/repository/firestore_repository.dart';

class FirestoreService implements FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      print('Erro ao adicionar documento: $e');
    }
  }

  @override
  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
    } catch (e) {
      print('Erro ao atualizar documento: $e');
    }
  }

  @override
  Future<void> deleteDocument(String collection, String documentId) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e) {
      print('Erro ao deletar documento: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDocuments(String collection) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>}).toList();
    } catch (e) {
      print('Erro ao obter documentos: $e');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>?> getDocumentById(String collection, String documentId) async {
    try {
      DocumentSnapshot document = await _firestore.collection(collection).doc(documentId).get();
      return document.exists ? document.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print('Erro ao obter documento: $e');
      return null;
    }
  }
}
