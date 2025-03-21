import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../Utils/toast_snack_bar.dart';
import '../models/all_ques_model.dart';
import '../models/test_config_model.dart';
import '../services/firestore_ref_service.dart';
import '../services/manage_question_service.dart';

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
  RxInt selectedQuestionLeft = 0.obs;
  RxString selectedStatus = "".obs;
  RxString selectedTestType = "".obs;
  RxString selectedQuestionId = "".obs;
  RxBool fieldsChecked = false.obs;
  RxList<AllQuestionModel> questionList = <AllQuestionModel>[].obs;
  RxList<AllQuestionModel> selectedQuestionList = <AllQuestionModel>[].obs;
  var searchQuery = ''.obs;
  RxList<AllQuestionModel> filteredQuestionList = <AllQuestionModel>[].obs;

  RxString testId = "".obs;
  RxString testTitle = "".obs;
  RxString testDescription = "".obs;
  RxBool isUploading = false.obs;
  RxDouble progress = 0.0.obs;

  late final FirestoreRefService _firestoreRefService;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _firestoreRefService = FirestoreRefService();
    fetchTestConfig();
    debounce(searchQuery, (_) => filterQuestions(),
        time: const Duration(milliseconds: 500));
  }

  // check all the fields
  void checkAllFields() {
    fieldsChecked.value = selectedCategoryId.value != "" ? true : false;
    fieldsChecked.value = selectedSubCatId.value != "" ? true : false;
    fieldsChecked.value = selectedSubjectId.value != "" ? true : false;
    fieldsChecked.value = selectedTopicId.value != "" ? true : false;
    fieldsChecked.value = selectedTeacherId.value != "" ? true : false;
    fieldsChecked.value = selectedDuration.value != 0 ? true : false;
    fieldsChecked.value = selectedEachMark.value != 0.0 ? true : false;
    fieldsChecked.value = selectedQuestionCount.value != 0 ? true : false;
    fieldsChecked.value = selectedStatus.value != "" ? true : false;
    fieldsChecked.value = selectedTestType.value != "" ? true : false;
    fieldsChecked.value =
        selectedQuestionCount.value != 0 && selectedQuestionLeft.value == 0
            ? true
            : false;
  }

  Stream<QuerySnapshot> _fetchAllQuestion(String subjectId, String topicId) {
    return _firestoreRefService.getAllQuesRef(subjectId, topicId).snapshots();
  }

  Future<void> getAllQuestions() async {
    var dataStream = _fetchAllQuestion(
        selectedSubjectId.value, selectedTopicId.value);

    await for (var data in dataStream) {
      if (data.docs.isEmpty) {
        questionList.clear();
      } else {
        questionList.value = data.docs.map((doc) {
          return doc.data() as AllQuestionModel;
        }).toList();
      }
      // Initial load, all questions should be displayed
      filteredQuestionList.assignAll(questionList);
    }
  }

  void filterQuestions() {
    if (searchQuery.isEmpty) {
      filteredQuestionList.assignAll(questionList);
    } else {
      filteredQuestionList.assignAll(
        questionList
            .where((q) => q.questionText
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
            .toList(),
      );
    }
  }

  void toggleQuestionSelection(AllQuestionModel question) {
    final isSelected = selectedQuestionList.any((q) => q.id == question.id);

    if (isSelected) {
      selectedQuestionList.removeWhere((q) => q.id == question.id);
      selectedQuestionLeft.value =
          selectedQuestionCount.value - selectedQuestionList.length;
    } else if (selectedQuestionList.length < selectedQuestionCount.value) {
      selectedQuestionList.add(question);
      selectedQuestionLeft.value =
          selectedQuestionCount.value - selectedQuestionList.length;
    } else {
      AppSnackBar.error(
        "Limit Reached ,You can only select ${selectedQuestionCount.value} questions.",
      );
    }
  }

  bool isQuestionSelected(AllQuestionModel question) {
    return selectedQuestionList.any((q) => q.id == question.id);
  }

  Future<void> fetchTestConfig() async {
    try {
      DocumentSnapshot<TestConfigModel> snapshot = await _firestoreRefService
          .testconfigcolelctionref
          .doc('settings')
          .get();

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
