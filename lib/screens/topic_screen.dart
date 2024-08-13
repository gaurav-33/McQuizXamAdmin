import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Utils/toast_snack_bar.dart';
import '../models/subject_model.dart';
import '../routes/app_routes.dart';
import '../services/manage_subject_service.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/list_card_box.dart';
import '../widgets/query_stream_builder.dart';

class TopicScreen extends StatelessWidget {
  TopicScreen({super.key});
  final subjectId = Get.arguments["subject_id"];
  final subjectName = Get.arguments["subject_name"];
  final ManageSubjectServices _upload = ManageSubjectServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _subjectdcontroller = TextEditingController();
  final TextEditingController _statuscontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageUrlcontroller = TextEditingController();

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
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.getSubjectRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("Topics",
              style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: _buildUI()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: Get.height * 0.8,
        child: QueryStreamBuilder(
          stream: _upload.fetchTopic(subjectId),
          builder: (context, documents) {
            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final TopicModel topic = doc.data() as TopicModel;
                String topicId = topic.id;
                return ListCardBox(
                  title: topic.name,
                  subtitle: topic.id,
                  detail: DateFormat("dd-MM-yyyy h:mm a")
                      .format(topic.updatedAt.toDate()),
                  deleteFunc: () => _deleteDialog(context, topicId),
                  editFunc: () => _displayUpdateDialog(context, topic),
                  onCardTap: () => Get.toNamed(
                      AppRoutes.getUploadQuestionRoute(),
                      arguments: {
                        "subject_id": subjectId,
                        "subject_name": subjectName,
                        "topic_id": topicId,
                        "topic_name": topic.name
                      }),
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add Topic')),
          errorWidget: const Center(child: Text('Something went wrong')),
        ),
      ),
    );
  }

  void _displayDialog(BuildContext context) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      backgroundColor: theme.cardColor,
      CustomDialogForm(
        title: "Add Topic",
        idController: _idcontroller,
        nameController: _namecontroller,
        dynamicFieldController:
            _subjectdcontroller, // Example of renamed controller
        statusController: _statuscontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        dynamicHint: "Subject (subject_01)", // Example of dynamic hint
        onSave: () {
          // Create a new TopicModel with the data from the controllers
          TopicModel newTopic = TopicModel(
            id: _idcontroller.text.toString(),
            name: _namecontroller.text.toString(),
            subjectId: _subjectdcontroller.text.toString(),
            status: _statuscontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
          _upload.uploadTopic(newTopic); // Upload the new topic
          Get.back(); // Close the bottom sheet
          AppSnackBar.success("Added Topic"); // Show success message
          _clearControllers(); // Clear all the controllers
        },
        onCancel: () {
          Get.back(); // Close the bottom sheet
          _clearControllers(); // Clear all the controllers
        },
      ),
    );
  }

  void _displayUpdateDialog(BuildContext context, TopicModel topic) {
    // Populate the controllers with the existing topic data
    _imageUrlcontroller.text = topic.imageUrl;
    _descriptioncontroller.text = topic.description;
    _namecontroller.text = topic.name;
    _idcontroller.text = topic.id;
    _statuscontroller.text = topic.status;
    _subjectdcontroller.text = topic.subjectId;

    Get.bottomSheet(
      isDismissible: false,
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Update Topic",
        idController: _idcontroller,
        nameController: _namecontroller,
        dynamicFieldController:
            _subjectdcontroller, // Example of renamed controller
        statusController: _statuscontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        dynamicHint: "Subject (subject_01)", // Example of dynamic hint
        onSave: () {
          TopicModel updatedTopic = topic.copyWith(
            id: _idcontroller.text.toString(),
            subjectId: _subjectdcontroller.text.toString(),
            status: _statuscontroller.text.toString(),
            name: _namecontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            updatedAt: Timestamp.now(),
          );
          _upload.updateTopic(
              updatedTopic.subjectId, updatedTopic.id, updatedTopic);
          Get.back();
          AppSnackBar.success("Updated Topic");
          _clearControllers();
        },
        onCancel: () {
          Get.back();
          _clearControllers();
        },
      ),
    );
  }

  void _clearControllers() {
    _imageUrlcontroller.clear();
    _statuscontroller.clear();
    _subjectdcontroller.clear();
    _descriptioncontroller.clear();
    _idcontroller.clear();
    _namecontroller.clear();
  }

  void _deleteDialog(BuildContext context, String topicId) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      backgroundColor: theme.cardColor,
      CustomDialogForm(
        title: "Want to Delete it?",
        onCancel: () {
          Get.back();
        },
        onSave: () {
          _upload.deleteTopic(subjectId, topicId);
          Get.back();
          AppSnackBar.error("Deleted");
        },
      ),
    );
  }
}
