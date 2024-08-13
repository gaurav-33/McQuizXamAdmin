import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/file_picker_util.dart';
import '../Utils/toast_snack_bar.dart';
import '../controllers/upload_progress_controller.dart';
import '../routes/app_routes.dart';
import '../services/manage_question_service.dart';
import '../widgets/liquid_progress_indicator.dart';
import '../widgets/rect_button.dart';

class UploadQuestionScreen extends StatelessWidget {
  UploadQuestionScreen({super.key});

  final UploadProgressController progressController =
      Get.find<UploadProgressController>();

  final String subjectId = Get.arguments["subject_id"];
  final String subject = Get.arguments["subject_name"];
  final String topicId = Get.arguments["topic_id"];
  final String topic = Get.arguments["topic_name"];
  final ManageQuestionServices _questionServices = ManageQuestionServices();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Get.offAllNamed(AppRoutes.getSubjectRoute());
          },
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Upload Question",
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                RectButton(
                  name: subject,
                  height: Get.height * 0.10,
                ),
                const SizedBox(
                  height: 24,
                ),
                RectButton(
                  name: topic,
                  height: Get.height * 0.10,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Choose .CSV file for this TOPIC",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 24,
                ),
                RectButton(
                  name: ".csv",
                  icon: Icons.upload_file,
                  height: Get.height * 0.1,
                  width: Get.width * 0.5,
                  ontap: () async {
                    FilePickerResult? result = await pickCsvFile();
                    if (result != null) {
                      // File picked successfully
                      PlatformFile file = result.files.first;
                      progressController.fileName.value = file.name;
                      progressController.filePath.value = file.path!;
                      if (kDebugMode) {
                        print('File path: ${file.path}');
                      }

                      // Handle the picked file here
                    } else {
                      // User canceled the picker
                      AppSnackBar.error("No File Picked");
                      if (kDebugMode) {
                        print('No file picked');
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "File Name: ${progressController.fileName.value}",
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                RectButton(
                  name: "Upload It",
                  icon: Icons.upload_outlined,
                  height: Get.height * 0.1,
                  width: Get.width * 0.7,
                  ontap: () async {
                    if (progressController.fileName.value != "" &&
                        progressController.isUploading.value == false) {
                      await _questionServices.uploadQues(
                          filePath: progressController.filePath.value,
                          subjectId: subjectId,
                          topicId: topicId,
                          topic: topic,
                          subject: subject);
                    }
                    // uploadDialog();
                    // _counterService.uploadCounter("q000001", 50);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                progressController.progress.value > 0
                    ? Text(
                        "Uploaded This: ${progressController.quesId.value}",
                        style: theme.textTheme.titleMedium,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 24,
                ),
                progressController.progress.value > 0
                    ? RichText(
                        text: TextSpan(
                            text: ((progressController.progress.value * 10000)
                                        .truncateToDouble() /
                                    100)
                                .toString(),
                            style: theme.textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "  %",
                                style: theme.textTheme.titleSmall,
                              )
                            ]),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                CustomPaint(
                  size: Size(Get.width * 0.3, Get.width * 0.3),
                  painter:
                      LiquidPainter(progressController.progress.value, 1.0),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
