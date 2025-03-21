import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/all_ques_model.dart';
import '../models/category_model.dart';
import '../routes/app_routes.dart';
import '../services/manage_category_service.dart';
import '../services/manage_question_service.dart';
import '../services/manage_subject_service.dart';
import '../services/teacher_service.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({super.key});

  ManageCategoryServices _uploadCategoryServices = ManageCategoryServices();
  ManageSubjectServices _uploadSubjectServices = ManageSubjectServices();
  TeacherService _teacherService = TeacherService();
  ManageQuestionServices _questionServices = ManageQuestionServices();
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
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.getHomeRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () async {
              // await _upload.uploadDoc();
              // await _upload.fetchCategory();
              // await _upload.uploadCat();
              // await _uploadCategoryServices.uploadCat();
              // await _uploadSubjectServices.uploadSub();
            },
            child: const Text("Upload IT"),
          ),
          // Expanded(
          //   child: StreamBuilder(
          //       stream: _questionServices.fetchAllQuestion(
          //           "subject_05", "topic_01"),
          //       builder: (context, snapshot) {
          //         List categoryDocs = snapshot.data?.docs ?? [];
          //         if (categoryDocs.isEmpty) {
          //           return const Center(
          //             child: Text(
          //               "Add Category",
          //               style: TextStyle(color: Colors.black, fontSize: 15),
          //             ),
          //           );
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const SizedBox(
          //             height: 200,
          //             width: 200,
          //             child: CircularProgressIndicator(
          //               color: Colors.black,
          //               strokeWidth: 3.0,
          //             ),
          //           );
          //         }
          //
          //         return ListView.builder(
          //             itemCount: categoryDocs.length,
          //             itemBuilder: (context, index) {
          //               AllQuestionModel cat = categoryDocs[index].data();
          //               return Card(
          //                 // color: Colors.grey[350],
          //                 child: ListTile(
          //                   onTap: () {},
          //                   title: Text(
          //                     cat.questionText,
          //                     style: Theme.of(context).textTheme.titleMedium,
          //                   ),
          //                   // subtitle: Text(DateFormat("dd-MM-yyyy h:mm a")
          //                   //     .format(cat.updatedAt.toDate())),
          //                   trailing: Text(cat.id),
          //                 ),
          //               );
          //             });
          //       }),
          // ),
          // const SizedBox(
          //   height: 50,
          // ),
          // Expanded(
          //   child: StreamBuilder(
          //       stream: _uploadCategoryServices.fetchSubCategory("cat_01"),
          //       builder: (context, snapshot) {
          //         List subCatDocs = snapshot.data?.docs ?? [];
          //         if (subCatDocs.isEmpty) {
          //           return const Center(
          //             child: Text(
          //               "Add SubCategory",
          //               style: TextStyle(color: Colors.black, fontSize: 15),
          //             ),
          //           );
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const SizedBox(
          //             height: 200,
          //             width: 200,
          //             child: CircularProgressIndicator(
          //               color: Colors.black,
          //               strokeWidth: 3.0,
          //             ),
          //           );
          //         }
          //         return ListView.builder(
          //             itemCount: subCatDocs.length,
          //             itemBuilder: (context, index) {
          //               SubCategoryModel subcat = subCatDocs[index].data();
          //               return Card(
          //                 color: Colors.grey[350],
          //                 child: ListTile(
          //                   title: Text(subcat.name),
          //                   subtitle: Text(DateFormat("dd-MM-yyyy h:mm a")
          //                       .format(subcat.updatedAt.toDate())),
          //                   trailing: Text(subcat.id),
          //                 ),
          //               );
          //             });
          //       }),
          // ),
        ],
      ),
    );
  }
}
