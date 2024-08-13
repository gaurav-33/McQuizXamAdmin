import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Utils/counter_util.dart';
import '../Utils/tost_snackbar.dart';
import '../controllers/create_test_controller.dart';
import '../models/all_ques_model.dart';
import '../models/test_paper_model.dart';
import '../routes/app_routes.dart';
import '../services/firestore_ref_service.dart';

class UploadTestPaper {
  late final FirestoreRefService _firestoreRefService;
  final testController = Get.find<CreateTestController>();
  UploadTestPaper() {
    _firestoreRefService = FirestoreRefService();
  }

  Future<void> getTestId() async {
    // Get the reference to the collection
    CollectionReference<MockTestModel> mockTestRef =
        _firestoreRefService.getMockTestRef(
            testController.selectedCategoryId.value,
            testController.selectedSubCatId.value);

    try {
      // Fetch the last document in the collection by ordering by ID in descending order
      final QuerySnapshot<MockTestModel> snapshot = await mockTestRef.get();

      // Check if there are any documents in the collection
      if (snapshot.docs.isEmpty) {
        // No documents in the collection or collection does not exist
        if (kDebugMode) {
          print('No documents found or the collection does not exist.');
        }
        testController.testId.value =
            "test_0001"; // Starting ID for the first document
      } else {
        // The last document exists; proceed with your logic
        final String lastId = snapshot.docs.last.id;
        if (kDebugMode) {
          print('Last ID: $lastId');
        }
        // Increment the last ID
        testController.testId.value =
            await CounterUtil().incrementId(lastId, 1);
      }
    } catch (e) {
      // Handle any errors that might occur
      if (kDebugMode) {
        AppSnackBar.error(e.toString());
        print('Error: $e');
      }
    }
  }

  Future<void> uploadTestPaper() async {
    try {
      await getTestId();
      testController.isUploading.value = true;
      final String testId = testController.testId.value;
      final String categoryId = testController.selectedCategoryId.value;
      final String subCatId = testController.selectedSubCatId.value;

      CollectionReference<MockTestModel> mockTestRef =
          _firestoreRefService.getMockTestRef(categoryId, subCatId);
      final MockTestModel mockTestModel = MockTestModel(
          owner: testController.selectedTeacher.value,
          id: testId,
          categoryId: categoryId,
          subcategoryId: subCatId,
          title: testController.testTitle.value,
          description: testController.testDescription.value,
          duration: testController.selectedDuration.value,
          totalMarks: testController.selectedQuestionCount.value *
              testController.selectedEachMark.value,
          negativeMarking: testController.selectedNegativeMark.value,
          status: testController.selectedStatus.value,
          examType: testController.selectedTestType.value,
          numberOfQuestions: testController.selectedQuestionCount.value,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now());

      await mockTestRef.doc(testId).set(mockTestModel);

      CollectionReference<AllQuestionModel> mockTestQuesRef =
          _firestoreRefService.getTestQuestionRef(testId, categoryId, subCatId);

      int s = 0;
      int e = testController.selectedQuestionList.length;
      for (var question in testController.selectedQuestionList) {
        await mockTestQuesRef.doc("$testId${question.id}").set(question);
        s++;
        testController.progress.value = s / e;
        await Future.delayed(const Duration(milliseconds: 10));
      }
      testController.isUploading.value = false;
      testController.progress.value = 0;
      AppSnackBar.success("Test Created Successfully");
      Get.offAllNamed(AppRoutes.getHomeRoute());
    } catch (e) {
      AppSnackBar.error("Can't Create: $e");
      if (kDebugMode) {
        print("Can't Create Test: $e");
      }
    }
  }
}
