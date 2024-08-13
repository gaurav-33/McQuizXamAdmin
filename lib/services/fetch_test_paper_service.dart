import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_ref_service.dart';

class FetchTestPaperService{
  late final FirestoreRefService _firestoreRefService;

  FetchTestPaperService(){
    _firestoreRefService = FirestoreRefService();
  }



  Stream<QuerySnapshot> fetchTestPaper(String categoryId, String subCatId) {
    return _firestoreRefService.getMockTestRef(categoryId, subCatId).snapshots();
  }

  void deleteTestPaper(String categoryId, String subCatId, String testId) async {
    await _firestoreRefService
        .getMockTestRef(categoryId, subCatId)
        .doc(testId)
        .delete();
  }
}