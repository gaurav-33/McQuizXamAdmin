import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_ref_service.dart';

class FetchTestPaperService {
  late final FirestoreRefService _firestoreRefService;

  FetchTestPaperService() {
    _firestoreRefService = FirestoreRefService();
  }

  Stream<QuerySnapshot> fetchTestPaper(String categoryId, String subCatId) {
    return _firestoreRefService
        .getMockTestRef(categoryId, subCatId)
        .snapshots();
  }

  void deleteTestPaper(
      String categoryId, String subCatId, String testId) async {
    CollectionReference testPapersref = await _firestoreRefService
        .getMockTestRef(categoryId, subCatId)
        .doc(testId)
        .collection("test_questions");

    // Retrieve all documents in the collection
    QuerySnapshot snapshot = await testPapersref.get();

    // Delete each document in the collection
    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    await _firestoreRefService
        .getMockTestRef(categoryId, subCatId)
        .doc(testId)
        .delete();
  }
}
