import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: GetBuilder<CreateTestController>(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Text(
                  "Create Test",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 20,),
                Text(
                  "Category",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                _buildCategoryDropdown(),
                const SizedBox(height: 20,),
                Text(
                  "Sub Category",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                testController.selectedCategoryId.value != "" ? _buildSubCategoryDropdown() : const SizedBox(),
                const SizedBox(height: 20,),
                Text(
                  "Subject",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                _buildSubjectDropdown(),
                const SizedBox(height: 20,),
                Text(
                  "Topic",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                testController.selectedSubjectId.value != "" ? _buildTopicDropdown() : const SizedBox(),
                const SizedBox(height: 20,),
              ],
            )
          );
        }),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return AppDropDownBtn<CategoryModel>(
      stream: _categoryServices.fetchCategory(),
      itemBuilder: (CategoryModel category) => category.name,
      onChanged: (CategoryModel category, String id) {
        testController.setSelectedCategory(category.name, id);
      },
      hintText: "Select Category",
      selectedItemId: testController.selectedCategoryId.value,
    );
  }

  Widget _buildSubCategoryDropdown() {
    return AppDropDownBtn<SubCategoryModel>(
      stream: _categoryServices.fetchSubCategory(testController.selectedCategoryId.value),
      itemBuilder: (SubCategoryModel subcategory) => subcategory.name,
      onChanged: (SubCategoryModel subcategory, String id) {
        testController.setSelectedSubCat(subcategory.name, id);
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
        testController.setSelectedSubject(subject.name, id);
      },
      hintText: "Select Subject",
      selectedItemId: testController.selectedSubjectId.value,

    );
  }

  Widget _buildTopicDropdown() {
    return AppDropDownBtn<TopicModel>(
      stream: _subjectServices.fetchTopic(testController.selectedSubjectId.value),
      itemBuilder: (TopicModel topic) => topic.name,
      onChanged: (TopicModel topic, String id) {
        testController.setSelectedTopic(topic.name, id);
      },
      hintText: "Select Topic",
      selectedItemId: testController.selectedTopicId.value, // Ensure this matches an item ID
    );
  }


}
