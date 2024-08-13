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

class SubjectScreen extends StatelessWidget {
  SubjectScreen({super.key});

  final ManageSubjectServices _upload = ManageSubjectServices();
  final TextEditingController _namecontroller = TextEditingController();
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.offAllNamed(AppRoutes.getHomeRoute());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("Subjects",
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
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: Get.height * 0.8,
        child: QueryStreamBuilder(
          stream: _upload.fetchSubject(),
          builder: (context, documents) {
            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final SubjectModel subject = doc.data() as SubjectModel;
                String subjectId = subject.id;
                return ListCardBox(
                  title: subject.name,
                  subtitle: subject.id,
                  detail: DateFormat("dd-MM-yyyy h:mm a")
                      .format(subject.updatedAt.toDate()),
                  deleteFunc: () => _deleteDialog(context, subjectId),
                  onCardTap: () => Get.toNamed(AppRoutes.getTopicRoute(),
                      arguments: {
                        "subject_id": subjectId,
                        "subject_name": subject.name
                      }),
                  editFunc: () =>
                      _displayDialogUpdate(context, subject, subjectId),
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add Subject')),
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
        title: "Add Subject",
        idController: _idcontroller,
        nameController: _namecontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        idHint: "Id(subject_01)",
        onSave: () {
          // Create a new TopicModel with the data from the controllers
          SubjectModel newSubject = SubjectModel(
            id: _idcontroller.text.toString(),
            name: _namecontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
          _upload.uploadSubject(newSubject); // Upload the new topic
          Get.back(); // Close the bottom sheet
          AppSnackBar.success("Added Subject"); // Show success message
          _clearControllers(); // Clear all the controllers
        },
        onCancel: () {
          Get.back(); // Close the bottom sheet
          _clearControllers(); // Clear all the controllers
        },
      ),
    );
  }

  void _displayDialogUpdate(
      BuildContext context, SubjectModel subject, String subjectId) {
    _imageUrlcontroller.text = subject.imageUrl;
    _descriptioncontroller.text = subject.description;
    _namecontroller.text = subject.name;
    _idcontroller.text = subject.id;
    Get.bottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Update Subject",
        idController: _idcontroller,
        nameController: _namecontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        dynamicHint: "Subject (subject_01)", // Example of dynamic hint
        onSave: () {
          SubjectModel updatedSubject = subject.copyWith(
            id: _idcontroller.text.toString(),
            name: _namecontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            updatedAt: Timestamp.now(),
          );
          _upload.updateSubject(subjectId, updatedSubject);
          Get.back();
          AppSnackBar.success("Updated Subject");
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
    _idcontroller.clear();
    _descriptioncontroller.clear();
    _idcontroller.clear();
    _namecontroller.clear();
  }

  void _deleteDialog(BuildContext context, String subjectId) {
    Get.bottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Want to Delete it?",
        onCancel: () {
          Get.back();
        },
        onSave: () {
          _upload.deleteSubject(subjectId);
          Get.back();
          AppSnackBar.error("Deleted");
        },
      ),
    );
  }
}
