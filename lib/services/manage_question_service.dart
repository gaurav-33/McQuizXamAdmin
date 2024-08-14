import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Utils/counter_util.dart';
import '../Utils/file_picker_util.dart';
import '../Utils/toast_snack_bar.dart';
import '../controllers/upload_progress_controller.dart';
import '../models/all_ques_model.dart';
import '../routes/app_routes.dart';
import '../services/counter_service.dart';
import 'firestore_ref_service.dart';

class ManageQuestionServices {
  late final FirestoreRefService _firestoreRefService;

  ManageQuestionServices() {
    _firestoreRefService = FirestoreRefService();
  }
  final progressController = Get.find<UploadProgressController>();

  Future<void> uploadAllQuestion(AllQuestionModel questionModel) async {
    try {
      // Upload the category data
      CollectionReference<AllQuestionModel> questionRef = _firestoreRefService
          .getAllQuesRef(questionModel.subjectId, questionModel.topicId);
      await questionRef.doc(questionModel.id).set(questionModel);
      if (kDebugMode) {
        print('${questionModel.id} question uploaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to upload Question: $e');
      }
    }
  }

  // Stream<QuerySnapshot> fetchAllQuestion(String subjectId, String topicId) {
  //   return _firestoreRefService.getAllQuesRef(subjectId, topicId).snapshots();
  // }

  void updateQuestion(AllQuestionModel questionModel) async {
    await _firestoreRefService
        .getAllQuesRef(questionModel.subjectId, questionModel.topicId)
        .doc(questionModel.id)
        .update(questionModel.toJson());
  }

  void deleteSubject(
      String subjectId, String topicId, String questionId) async {
    await _firestoreRefService
        .getAllQuesRef(subjectId, topicId)
        .doc(questionId)
        .delete();
  }

  Future<void> uploadQues({
    required String filePath,
    required String subjectId,
    required String topicId,
    required String topic,
    required String subject,
  }) async {
    List<List<dynamic>> csvData = await readCsvFile(filePath);
    try {
      final CounterUtil counterUtil = CounterUtil();
      final CounterService counterService = CounterService();
      final String oldQuesId = await CounterService().fetchCounter();
      late String newQuesId = oldQuesId;

      progressController.progress.value = 0;
      final int csvLength = csvData.length;

      for (var i = 1; i < csvData.length; i++) {
        newQuesId = await counterUtil.incrementId(newQuesId, 1);
        progressController.quesId.value = newQuesId;
        final String opTxt1 = csvData[i][1].toString();
        final String opTxt2 = csvData[i][2].toString();
        final String opTxt3 = csvData[i][3].toString();
        final String opTxt4 = csvData[i][4].toString();

        final bool isCrr1 =
            csvData[i][5].toString().toUpperCase() == "A" ? true : false;
        final bool isCrr2 =
            csvData[i][5].toString().toUpperCase() == "B" ? true : false;
        final bool isCrr3 =
            csvData[i][5].toString().toUpperCase() == "C" ? true : false;
        final bool isCrr4 =
            csvData[i][5].toString().toUpperCase() == "D" ? true : false;

        List<AllOptionModel> optionsList = [
          AllOptionModel(optionId: "A", text: opTxt1, isCorrect: isCrr1),
          AllOptionModel(optionId: "B", text: opTxt2, isCorrect: isCrr2),
          AllOptionModel(optionId: "C", text: opTxt3, isCorrect: isCrr3),
          AllOptionModel(optionId: "D", text: opTxt4, isCorrect: isCrr4),
        ];

        final AllQuestionModel tempQues = AllQuestionModel(
            id: newQuesId,
            subjectId: subjectId,
            topicId: topicId,
            topic: topic,
            subject: subject,
            questionText: csvData[i][0],
            questionType: "multiple_choice",
            options: optionsList,
            explanation: csvData[i][6].toString(),
            difficulty: "easy",
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now());
        progressController.isUploading.value = true;
        await uploadAllQuestion(tempQues);
        optionsList.clear();
        progressController.progress.value = (i / csvLength);
        await Future.delayed(const Duration(milliseconds: 10));
      }
      progressController.progress.value = 0;
      await counterService.uploadCounter(newQuesId);
      progressController.resetAll();
      AppSnackBar.success("Uploaded All Question");
      Get.offAllNamed(AppRoutes.getSubjectRoute());
      progressController.isUploading.value = false;
    } catch (e) {
      progressController.resetAll();
      progressController.isUploading.value = false;
      AppSnackBar.error(e.toString());
      if (kDebugMode) {
        print("Error in Iterating ques. $e");
      }
    }
  }
}
