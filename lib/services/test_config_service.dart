// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import '../controllers/create_test_controller.dart';
// import '../services/firestore_ref_service.dart';
//
// import '../models/test_config_model.dart';
//
// class TestConfigService{
//   late final FirestoreRefService _firestoreRefService;
//   final testController = Get.find<CreateTestController>();
//   TestConfigService(){
//     _firestoreRefService = FirestoreRefService();
//   }
//
//  Future<void> fetchTestConfig() async {
//     try {
//       DocumentSnapshot<TestConfigModel> snapshot =
//           await _firestoreRefService.testconfigcolelctionref.doc('settings').get();
//
//       if (snapshot.exists) {
//         testController.testConfig.value = snapshot.data();
//       } else {
//         if (kDebugMode) {
//           print("Document does not exist!");
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error fetching test config: $e");
//       }
//     }
//   }
// }
