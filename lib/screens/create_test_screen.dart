import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcquizadmin/models/all_ques_model.dart';
import 'package:mcquizadmin/models/teacher_model.dart';
import 'package:mcquizadmin/models/test_config_model.dart';
import 'package:mcquizadmin/services/teacher_service.dart';
import 'package:mcquizadmin/services/test_config_service.dart';
import 'package:mcquizadmin/services/upload_question_service.dart';
import 'package:mcquizadmin/widgets/drop_down_for_list.dart';
import '../controllers/create_test_controller.dart';
import '../models/category_model.dart';
import '../models/subject_model.dart';
import '../services/upload_category_service.dart';
import '../services/upload_subject_service.dart';
import '../widgets/drop_down_widget.dart';
import '../res/app_theme.dart';
import '../routes/app_routes.dart';

class CreateTestScreen extends StatelessWidget {
  CreateTestScreen({super.key});

  CreateTestController testController = Get.put(CreateTestController());
  UploadCategoryServices _categoryServices = UploadCategoryServices();
  UploadSubjectServices _subjectServices = UploadSubjectServices();
  TeacherService _teacherService = TeacherService();
  UploadQuestionServices _questionServices = UploadQuestionServices();

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: const Text(
         "MCQUIZ ADMIN",
       ),
       leading: IconButton(
         icon: const Icon(
           Icons.arrow_back,
           color: AppTheme.allports100,
         ),
         onPressed: () {
           Get.offAllNamed(AppRoutes.getHomeRoute());
         },
       ),
     ),
     body: SingleChildScrollView(
       child: Obx((){
         final testConfig = testController.testConfig.value;

         return testController.testConfig.value == null ? const CircularProgressIndicator(): Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               children: [
                 const SizedBox(
                   height: 20,
                 ),
                 Text(
                   "Create Test",
                   style: Theme.of(context).textTheme.displaySmall,
                 ),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Category"),
                 _buildCategoryDropdown(),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("SubCategory"),
                 testController.selectedCategoryId.value != ""
                     ? _buildSubCategoryDropdown()
                     : const SizedBox(),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Subject"),
                 _buildSubjectDropdown(),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Topic"),
                 testController.selectedSubjectId.value != ""
                     ? _buildTopicDropdown()
                     : const SizedBox(),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Owner"),
                 _buildTeacherDropDown(),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Type"),
                 _buildTestTypeDropdown(testConfig!),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("No. Of Questions"),
                 _buildQuesCountDropDown(testConfig),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Each Question Marks"),
                 _buildPositiveMarkDropDown(testConfig),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Negative Mark"),
                 _buildNegativeMarkDropDown(testConfig),
                 const SizedBox(
                   height: 20,
                 ),
                 _title("Duration"),
                 _buildDurationDropdown(testConfig),
                 const SizedBox(height: 20,),
                 _title("Status"),
                 _buildStatusDropdown(testConfig),
                 const SizedBox(height: 20,),
                 _title("Category"),
                 (testController.selectedTopicId.value != "" && testController.selectedSubjectId.value != "")
                     ? _buildQuestionDropdown()
                     : const SizedBox(),
               ],
             ));
       }),
     ),
   );
  }

  Widget _buildCategoryDropdown() {
    return AppDropDownBtn<CategoryModel>(
      stream: _categoryServices.fetchCategory(),
      itemBuilder: (CategoryModel category) => category.name,
      onChanged: (CategoryModel category, String id) {
        testController.selectedCategory.value = category.name;
        testController.selectedCategoryId.value = id;
      },
      hintText: "Select Category",
      selectedItemId: testController.selectedCategoryId.value,
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(color: AppTheme.allports900, fontSize: 15),
    );
  }

  Widget _buildSubCategoryDropdown() {
    return AppDropDownBtn<SubCategoryModel>(
      stream: _categoryServices
          .fetchSubCategory(testController.selectedCategoryId.value),
      itemBuilder: (SubCategoryModel subcategory) => subcategory.name,
      onChanged: (SubCategoryModel subcategory, String id) {
        testController.selectedSubCat.value = subcategory.name;
        testController.selectedSubCatId.value = id;
      },
      hintText: "Select SubCategory",
      selectedItemId: testController.selectedSubCatId.value,
    );
  }

  Widget _buildSubjectDropdown() {
    return AppDropDownBtn<SubjectModel>(
      stream: _subjectServices.fetchSubject(),
      itemBuilder: (SubjectModel subject) => subject.name,
      onChanged: (SubjectModel subject, String id) {
        testController.selectedSubject.value = subject.name;
        testController.selectedSubjectId.value = id;
      },
      hintText: "Select Subject",
      selectedItemId: testController.selectedSubjectId.value,
    );
  }

  Widget _buildTopicDropdown() {
    return AppDropDownBtn<TopicModel>(
      stream:
          _subjectServices.fetchTopic(testController.selectedSubjectId.value),
      itemBuilder: (TopicModel topic) => topic.name,
      onChanged: (TopicModel topic, String id) {
        testController.selectedTopic.value = topic.name;
        testController.selectedTopicId.value = id;
      },
      hintText: "Select Topic",
      selectedItemId: testController
          .selectedTopicId.value, // Ensure this matches an item ID
    );
  }

  Widget _buildTeacherDropDown() {
    return AppDropDownBtn<TeacherModel>(
        stream: _teacherService.fetchTeacher(),
        itemBuilder: (TeacherModel teacher) => teacher.name,
        onChanged: (TeacherModel teacher, String id) {
          testController.selectedTeacher.value = teacher.name;
          testController.selectedTeacherId.value = id;
        },
        hintText: "Select Teacher",
        selectedItemId: testController.selectedTeacherId.value);
  }

  Widget _buildTestTypeDropdown(TestConfigModel testConfig) {
    return DropDownForList<String>(
      items: testConfig.testTypes,
      hint: "Select Test Type",
      selectedItemId: testController.selectedTestType.value.toString(),
      value: testConfig.testTypes.contains(testController.selectedTestType.value)
          ? testController.selectedTestType.value
          : null,
      onChanged: (String? value) {
        if (value != null) {
          testController.selectedTestType.value = value;
        }
      },
    );
  }

  Widget _buildDurationDropdown(TestConfigModel testConfig) {
    return DropDownForList<int>(
      items: testConfig.durations,
      hint: "Select Duration",
      selectedItemId: testController.selectedDuration.value.toString(),
      value: testConfig.durations.contains(testController.selectedDuration.value)
          ? testController.selectedDuration.value
          : null,
      onChanged: (int? value) {
        if (value != null) {
          testController.selectedDuration.value = value;
        }
      },
    );
  }

  Widget _buildQuesCountDropDown(TestConfigModel testConfig) {
    return DropDownForList<int>(
      items: testConfig.questionCounts,
      hint: "Select Question Count",
      selectedItemId: testController.selectedQuestionCount.value.toString(),
      value: testConfig.questionCounts.contains(testController.selectedQuestionCount.value)
          ? testController.selectedQuestionCount.value
          : null,
      onChanged: (int? value) {
        if (value != null) {
          testController.selectedQuestionCount.value = value;
        }
      },
    );
  }

  Widget _buildPositiveMarkDropDown(TestConfigModel testConfig) {
    return DropDownForList<double>(
      items: testConfig.marksPerQuestion,
      hint: "Select Marks",
      selectedItemId: testController.selectedEachMark.value.toString(),
      value: testConfig.marksPerQuestion.contains(testController.selectedEachMark.value)
          ? testController.selectedEachMark.value
          : null,
      onChanged: (double? value) {
        if (value != null) {
          testController.selectedEachMark.value = value;
        }
      },
    );
  }

  Widget _buildNegativeMarkDropDown(TestConfigModel testConfig) {
    return DropDownForList<double>(
      items: testConfig.negativeMarks,
      hint: "Select Negative",
      selectedItemId: testController.selectedNegativeMark.value.toString(),
      value: testConfig.negativeMarks.contains(testController.selectedNegativeMark.value)
          ? testController.selectedNegativeMark.value
          : null,
      onChanged: (double? value) {
        if (value != null) {
          testController.selectedNegativeMark.value = value;
        }
      },
    );
  }

  Widget _buildStatusDropdown(TestConfigModel testConfig) {
    return DropDownForList<String>(
      items: testConfig.status,
      hint: "Select Status",
      selectedItemId: testController.selectedStatus.value.toString(),
      value: testConfig.status.contains(testController.selectedStatus.value)
          ? testController.selectedStatus.value
          : null,
      onChanged: (String? value) {
        if (value != null) {
          testController.selectedStatus.value = value;
        }
      },
    );
  }

  Widget _buildQuestionDropdown() {
    return AppDropDownBtn<AllQuestionModel>(
      stream: _questionServices.fetchAllQuestion(testController.selectedSubjectId.value, testController.selectedTopicId.value),
      itemBuilder: (AllQuestionModel question) => question.questionText,
      onChanged: (AllQuestionModel question, String id) {
        testController.selectedQuestion.value = question.questionText;
        testController.selectedQuestionId.value = id;
      },
      hintText: "Select Question",
      selectedItemId: testController.selectedQuestionId.value,
    );
  }
}
