import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mcquizadmin/Utils/tost_snackbar.dart';
import 'package:mcquizadmin/services/test_config_service.dart';
import '../models/test_config_model.dart';
import '../services/firestore_ref_service.dart';

class CreateTestController extends GetxController {
  RxList categoryList = [].obs;
  RxString selectedCategory = "".obs;
  RxString selectedCategoryId = "".obs;
  RxString selectedSubCat = "".obs;
  RxString selectedSubCatId = "".obs;
  RxString selectedSubject = "".obs;
  RxString selectedSubjectId = "".obs;
  RxString selectedTopic = "".obs;
  RxString selectedTopicId = "".obs;
  RxString selectedTeacher = "".obs;
  RxString selectedTeacherId = "".obs;
  Rxn<TestConfigModel> testConfig = Rxn<TestConfigModel>();
  RxInt selectedDuration = 0.obs;
  RxDouble selectedEachMark = 0.0.obs;
  RxDouble selectedNegativeMark = 0.0.obs;
  RxInt selectedQuestionCount = 0.obs;
  RxString selectedStatus = "".obs;
  RxString selectedTestType = "".obs;
  late final FirestoreRefService _firestoreRefService;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _firestoreRefService = FirestoreRefService();
    fetchTestConfig();
  }

  Future<void> fetchTestConfig() async {
    try {
      DocumentSnapshot<TestConfigModel> snapshot =
      await _firestoreRefService.testconfigcolelctionref.doc('settings').get();

      if (snapshot.exists) {
        testConfig.value = snapshot.data();
      } else {
        if (kDebugMode) {
          print("Document does not exist!");
        }
      }
      // TestConfigModel settings = TestConfigModel(
      //     testTypes: ["Private", "Public"],
      //     questionCounts: [5,10,15,20,25,30,40,50],
      //     marksPerQuestion: [1,2,3,4,4],
      //     negativeMarks: [0,-0.25,-0.50,-0.75,-1.0],
      //     durations: [5,10,15,20,25,30,45,60],
      //     status: ["Pending", "Activated", "Deactivated"]
      // );
      // await _firestoreRefService.testconfigcolelctionref
      //     .doc("settings")
      //     .set(settings);
      // AppSnackBar.success("uploaded");
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching test config: $e");
      }
    }
  }
}
