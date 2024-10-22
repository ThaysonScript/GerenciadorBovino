abstract class FirestoreRepository {
  Future<void> addDocument(String collection, Map<String, dynamic> data);
  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data);
  Future<void> deleteDocument(String collection, String documentId);
  Future<List<Map<String, dynamic>>> getDocuments(String collection);
  Future<Map<String, dynamic>?> getDocumentById(String collection, String documentId);
}
