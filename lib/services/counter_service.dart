import 'package:flutter/foundation.dart';

import '../Utils/tost_snackbar.dart';
import '../models/counter_model.dart';
import 'firestore_ref_service.dart';

class CounterService {
  late final FirestoreRefService _firestoreRefService;

  CounterService() {
    _firestoreRefService = FirestoreRefService();
  }

  Future<void> uploadCounter(String counterId) async {
    try {
      // counterId = CounterUtil().incrementId(counterId, noOfQuestion);

      CounterModel counterModel = CounterModel(counterId: counterId);

      await _firestoreRefService.countercollectionref
          .doc("ques")
          .set(counterModel);
      if (kDebugMode) {
        print("$counterId Counter uploaded Successfully");
      }
    } catch (e) {
      AppSnackBar.error("Uploading QCounter: ${e.toString()}");
      if (kDebugMode) {
        print("Error while uploading counter value: $e");
      }
    }
  }

  Future<String> fetchCounter() async {
    try {
      // Fetch the document from Firestore
      final counterDoc =
          await _firestoreRefService.countercollectionref.doc("ques").get();

      // Ensure the document exists and has data
      if (counterDoc.exists && counterDoc.data() != null) {
        // Extract the counterId from the document data
        final counterId = counterDoc.data()!.counterId;
        return counterId;
      } else {
        return "";
      }
    } catch (e) {
      AppSnackBar.error("Fetching QCounter: ${e.toString()}");
      if (kDebugMode) {
        print("Error while fetching counter value: $e");
      }
      return "";
    }
  }
}
