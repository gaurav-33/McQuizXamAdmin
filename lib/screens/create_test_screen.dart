import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/toast_snack_bar.dart';
import '../controllers/create_test_controller.dart';
import '../models/category_model.dart';
import '../models/subject_model.dart';
import '../models/teacher_model.dart';
import '../models/test_config_model.dart';
import '../routes/app_routes.dart';
import '../services/manage_category_service.dart';
import '../services/manage_subject_service.dart';
import '../services/teacher_service.dart';
import '../services/upload_test_paper.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/drop_down_for_list.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/liquid_progress_indicator.dart';
import '../widgets/rect_button.dart';

class CreateTestScreen extends StatelessWidget {
  CreateTestScreen({super.key});

  CreateTestController testController = Get.put(CreateTestController());
  final ManageCategoryServices _categoryServices = ManageCategoryServices();
  final ManageSubjectServices _subjectServices = ManageSubjectServices();
  final TeacherService _teacherService = TeacherService();
  final TextEditingController _searchedText = TextEditingController();

  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MCQUIZ ADMIN",
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
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
              ? const Center(child: CircularProgressIndicator())
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
                      _title("Category", context),
                      _buildCategoryDropdown(),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("SubCategory", context),
                      testController.selectedCategoryId.value != ""
                          ? _buildSubCategoryDropdown()
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Owner", context),
                      _buildTeacherDropDown(),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Type", context),
                      _buildTestTypeDropdown(testConfig!),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("No. Of Questions", context),
                      _buildQuesCountDropDown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Each Question Marks", context),
                      _buildPositiveMarkDropDown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Negative Mark", context),
                      _buildNegativeMarkDropDown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Duration", context),
                      _buildDurationDropdown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Status", context),
                      _buildStatusDropdown(testConfig),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Subject", context),
                      _buildSubjectDropdown(),
                      const SizedBox(
                        height: 20,
                      ),
                      _title("Topic", context),
                      testController.selectedSubjectId.value != ""
                          ? _buildTopicDropdown()
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),

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
                      _buildUploadButton(context),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ));
        }),
      ),
    );
  }

  Widget _title(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
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

  void _showQuestionDialog(BuildContext context) async {
    testController.getAllQuestions();
    final theme = Theme.of(context);
    Get.bottomSheet(
        // isScrollControlled: true,
        ignoreSafeArea: true,
        backgroundColor: theme.cardColor,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Obx(
            () {
              return Column(
                children: [
                  Text(
                    "Questions Left: ${testController.selectedQuestionLeft.value}",
                    // style: const TextStyle(color: AppTheme.darkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _searchedText,
                    onChanged: (value) {
                      testController.searchQuery.value = value;
                    },
                    // style:  TextStyle(color: AppTheme.darkColor),
                    decoration: const InputDecoration(
                      hintText: "Search Ques...",
                    ),
                  ),
                  Expanded(child: Obx(() {
                    // if(testController.selectedTopicId.value != ""){
                    //   testController.getAllQuestions();
                    // }
                    if (testController.filteredQuestionList.isEmpty) {
                      return Text(
                        "No Question Found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    } else {
                      return ListView.builder(
                        itemCount: testController.filteredQuestionList.length,
                        itemBuilder: (context, index) {
                          final questionModel =
                              testController.filteredQuestionList[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                questionModel.questionText,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
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
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme
                                        ?.error,
                                  )),
                            ),
                          );
                        },
                      );
                    }
                  })),
                ],
              );
            },
          ),
        ));
  }

  Widget _buildUploadButton(BuildContext context) {
    return RectButton(
      name: "Create Test",
      icon: Icons.create_new_folder,
      height: Get.height * 0.08,
      iconSize: Get.width * 0.05,
      ontap: () {
        testController.checkAllFields();
        testController.fieldsChecked.value == true
            ? _buildTestDialog(context)
            : AppSnackBar.error("Choose All Fields");
      },
    );
  }

  void _buildTestDialog(BuildContext context) {
    Get.bottomSheet(
        isDismissible: false,
        backgroundColor: Theme.of(context).cardColor, Obx(() {
      if (testController.progress.value > 0) {
        return Container(
          height: 300,
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    text: ((testController.progress.value * 10000)
                                .truncateToDouble() /
                            100)
                        .toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                    children: [
                      TextSpan(
                        text: "  %",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ]),
              ),
              const Spacer(),
              CustomPaint(
                size: const Size(100, 100),
                painter: LiquidPainter(testController.progress.value, 1),
              ),
            ],
          ),
        );
      }
      return CustomDialogForm(
        title: "Add Test Details",
        idController: _idcontroller,
        idHint: "test_0001...(generated automatically, don't change it)",
        nameController: _titlecontroller,
        descriptionController: _descriptioncontroller,
        onCancel: () {
          Get.back();
          _idcontroller.clear();
          _titlecontroller.clear();
          _descriptioncontroller.clear();
        },
        onSave: () {
          if (_titlecontroller.text.isNotEmpty) {
            if (testController.isUploading.value == false) {
              testController.testTitle.value = _titlecontroller.text.toString();
              testController.testDescription.value = _descriptioncontroller.text.toString();
              UploadTestPaper().uploadTestPaper();
            }
          } else {
            AppSnackBar.error("Enter Name and Description");
          }
        },
      );
    }));
  }
}
