import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Utils/tost_snackbar.dart';
import '../models/category_model.dart';
import '../models/subject_model.dart';
import '../res/app_theme.dart';
import '../routes/app_routes.dart';
import '../services/upload_category_service.dart';
import '../services/upload_subject_service.dart';
import '../widgets/list_card_box.dart';
import '../widgets/query_stream_builder.dart';

class TopicScreen extends StatelessWidget {
  TopicScreen({super.key});
  final subjectId = Get.arguments["subject_id"];
  final subjectName = Get.arguments["subject_name"];
  final UploadSubjectServices _upload = UploadSubjectServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _subjectdcontroller = TextEditingController();
  final TextEditingController _statuscontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageUrlcontroller = TextEditingController();

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
            Get.offAllNamed(AppRoutes.getSubjectRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
            child: Text(
              "Topics",
              style: Theme.of(context).textTheme.displaySmall,
            ),
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
          color: AppTheme.allports800,
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
            color: AppTheme.allports800,
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add Topic')),
          errorWidget: const Center(child: Text('Something went wrong')),
        ),
      ),
    );
  }

  void _displayDialog(BuildContext context) {
    Get.bottomSheet(
        backgroundColor: AppTheme.allports100,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Add Topic", style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (topic_1)"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _namecontroller,
                decoration: const InputDecoration(hintText: "Name"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _subjectdcontroller,
                decoration: const InputDecoration(hintText: "cat_1"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _statuscontroller,
                decoration: const InputDecoration(hintText: "active/inactive"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptioncontroller,
                decoration: const InputDecoration(hintText: "Description"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _imageUrlcontroller,
                decoration: const InputDecoration(hintText: "ImageUrl"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: AppTheme.allports200,
                    textColor: AppTheme.allports800,
                    child: const Text("Cancel"),
                    onPressed: () {
                      _imageUrlcontroller.clear();
                      _statuscontroller.clear();
                      _subjectdcontroller.clear();
                      _descriptioncontroller.clear();
                      _idcontroller.clear();
                      _namecontroller.clear();
                      Get.back();
                    },
                  ),
                  MaterialButton(
                    color: AppTheme.allports700,
                    textColor: AppTheme.allports100,
                    child: const Text("Add"),
                    onPressed: () {
                      _upload.uploadTopic(TopicModel(
                          id: _idcontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          subjectId: _subjectdcontroller.text.toString(),
                          status: _statuscontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          createdAt: Timestamp.now(),
                          updatedAt: Timestamp.now()));

                      Get.back();
                      AppSnackBar.success("Added Topic");
                      _imageUrlcontroller.clear();
                      _statuscontroller.clear();
                      _subjectdcontroller.clear();
                      _descriptioncontroller.clear();
                      _idcontroller.clear();
                      _namecontroller.clear();
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void _displayUpdateDialog(BuildContext context, TopicModel topic) {
    _imageUrlcontroller.text = topic.imageUrl;
    _descriptioncontroller.text = topic.description;
    _namecontroller.text = topic.name;
    _idcontroller.text = topic.id;
    _statuscontroller.text = topic.status;
    _subjectdcontroller.text = topic.subjectId;

    Get.bottomSheet(
        isDismissible: false,
        backgroundColor: AppTheme.allports100,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Update Topic",
                  style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (topic_1)"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _namecontroller,
                decoration: const InputDecoration(hintText: "Name"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _subjectdcontroller,
                decoration: InputDecoration(hintText: topic.subjectId),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _statuscontroller,
                decoration: const InputDecoration(hintText: "active/inactive"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptioncontroller,
                decoration: const InputDecoration(hintText: "Description"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _imageUrlcontroller,
                decoration: const InputDecoration(hintText: "ImageUrl"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: AppTheme.allports200,
                    textColor: AppTheme.allports800,
                    child: const Text("Cancel"),
                    onPressed: () {
                      Get.back();
                      _imageUrlcontroller.clear();
                      _statuscontroller.clear();
                      _subjectdcontroller.clear();
                      _descriptioncontroller.clear();
                      _idcontroller.clear();
                      _namecontroller.clear();
                    },
                  ),
                  MaterialButton(
                    color: AppTheme.allports700,
                    textColor: AppTheme.allports100,
                    child: const Text("Update"),
                    onPressed: () {
                      TopicModel updatedTopic = topic.copyWith(
                          id: _idcontroller.text.toString(),
                          subjectId: _subjectdcontroller.text.toString(),
                          status: _statuscontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          updatedAt: Timestamp.now());
                      _upload.uploadTopic(updatedTopic);

                      Get.back();
                      AppSnackBar.success("Updated Topic");
                      _imageUrlcontroller.clear();
                      _descriptioncontroller.clear();
                      _idcontroller.clear();
                      _namecontroller.clear();
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void _deleteDialog(BuildContext context, String topicId) {
    Get.bottomSheet(
        backgroundColor: AppTheme.allports100,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Want to Delete it?",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: AppTheme.allports200,
                    textColor: AppTheme.allports800,
                    child: const Text("Cancel"),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  MaterialButton(
                    color: AppTheme.allports700,
                    textColor: AppTheme.allports100,
                    child: const Text("Delete"),
                    onPressed: () {
                      _upload.deleteTopic(subjectId, topicId);
                      Get.back();
                      AppSnackBar.error("Deleted");
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
