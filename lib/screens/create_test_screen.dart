import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcquizadmin/Utils/tost_snackbar.dart';
import 'package:mcquizadmin/widgets/query_stream_builder.dart';
import 'package:mcquizadmin/widgets/rect_button.dart';
import '../models/all_ques_model.dart';
import '../models/teacher_model.dart';
import '../models/test_config_model.dart';
import '../services/teacher_service.dart';
import '../services/upload_question_service.dart';
import '../widgets/drop_down_for_list.dart';
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
  final UploadCategoryServices _categoryServices = UploadCategoryServices();
  final UploadSubjectServices _subjectServices = UploadSubjectServices();
  final TeacherService _teacherService = TeacherService();
  final TextEditingController _searchedText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MCQUIZ ADMIN",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.getHomeRoute());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final testConfig = testController.testConfig.value;

          return testController.testConfig.value == null
              ? Center(child: const CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Create Tests",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      _title("Category"),
                      _buildCategoryDropdown(),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("SubCategory"),
                      testController.selectedCategoryId.value != ""
                          ? _buildSubCategoryDropdown()
                          : const SizedBox(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // _title("Subject"),
                      // _buildSubjectDropdown(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // _title("Topic"),
                      // testController.selectedSubjectId.value != ""
                      //     ? _buildTopicDropdown()
                      //     : const SizedBox(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Status"),
                      _buildStatusDropdown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      // _title("Question"),
                      // (testController.selectedTopicId.value != "" &&
                      //         testController.selectedSubjectId.value != "")
                      //     ? RectButton(
                      //         name: "Questions",
                      //         height: Get.height * 0.06,
                      //         width: Get.width * 0.5,
                      //         ontap: () {
                      //           _showQuestionDialog(context);
                      //         },
                      //       )
                      //     : const SizedBox(),

                      RectButton(
                        name: "Questions",
                        height: Get.height * 0.06,
                        width: Get.width * 0.5,
                        ontap: () {
                          _showQuestionDialog(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildUploadButton(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ));
        }),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: const TextStyle(color: AppTheme.darkColor, fontSize: 15),
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
      value:
          testConfig.testTypes.contains(testController.selectedTestType.value)
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
      value:
          testConfig.durations.contains(testController.selectedDuration.value)
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
      value: testConfig.questionCounts
              .contains(testController.selectedQuestionCount.value)
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
      value: testConfig.marksPerQuestion
              .contains(testController.selectedEachMark.value)
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
      value: testConfig.negativeMarks
              .contains(testController.selectedNegativeMark.value)
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

  // Widget _buildQuestionDropdown() {
  //   return AppDropDownBtn<AllQuestionModel>(
  //     stream: _questionServices.fetchAllQuestion(
  //         testController.selectedSubjectId.value,
  //         testController.selectedTopicId.value),
  //     itemBuilder: (AllQuestionModel question) => question.questionText,
  //     onChanged: (AllQuestionModel question, String id) {
  //       testController.selectedQuestion.value = question.questionText;
  //       testController.selectedQuestionId.value = id;
  //     },
  //     hintText: "Select Question",
  //     selectedItemId: testController.selectedQuestionId.value,
  //   );
  // }

  void _showQuestionDialog(BuildContext context) async {
    // testController.getAllQuestions();
    final theme = Theme.of(context);
    Get.bottomSheet(
        isScrollControlled: true,
        ignoreSafeArea: true,
        backgroundColor: theme.cardColor,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Obx(
            () {
              return Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.transit_enterexit_rounded)),
                  _title("Subject"),
                  _buildSubjectDropdown(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Questions Left: ${testController.selectedQuestionCount.value}",
                    // style: const TextStyle(color: AppTheme.darkColor),
                  ),
                  _title("Topic"),
                  testController.selectedSubjectId.value == ""
                      ? const SizedBox()
                      : TextFormField(
                          controller: _searchedText,
                          onChanged: (value) {
                            testController.searchQuery.value = value;
                          },
                          // style:  TextStyle(color: AppTheme.darkColor),
                          decoration: InputDecoration(
                            hintText: "Search Ques...",
                            // fillColor: AppTheme.lightColor,
                            // filled: true,
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //       // color: AppTheme.darkColor,
                            //       width: 2),
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //       // color: AppTheme.accentColor,
                            //       width: 2),
                            //   borderRadius: BorderRadius.circular(20),
                            // )
                          ),
                        ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(() {
                      if (testController.filteredQuestionList.isEmpty) {
                        return const Text(
                          "No Question Found",
                          style: TextStyle(color: AppTheme.darkColor),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: testController.filteredQuestionList.length,
                          itemBuilder: (context, index) {
                            final questionModel =
                                testController.filteredQuestionList[index];
                            return Card(
                              color: AppTheme.accentColor,
                              child: ListTile(
                                title: Text(
                                  questionModel.questionText,
                                  style: const TextStyle(
                                      color: AppTheme.darkColor),
                                ),
                                onTap: () {
                                  testController
                                      .toggleQuestionSelection(questionModel);
                                },
                                trailing: Obx(() => Icon(
                                      testController
                                              .isQuestionSelected(questionModel)
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: AppTheme.darkColor,
                                    )),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              );
            },
          ),
        ));
  }

  Widget _buildUploadButton() {
    return RectButton(
      name: "Create Test",
      icon: Icons.create_new_folder,
      height: Get.height * 0.08,
      iconSize: Get.width * 0.05,
      ontap: () {
        testController.checkAllFields();
        testController.fieldsChecked.value == true ? success() : error();
      },
    );
  }

  void success() {
    print("Ready to Upload");
    AppSnackBar.success("REady to Uplad");
  }

  void error() {
    print("Choose All Fields");
    AppSnackBar.error("Choose All Fields");
  }
}
