import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Utils/tost_snackbar.dart';
import '../models/category_model.dart';
import '../res/app_theme.dart';
import '../routes/app_routes.dart';
import '../services/upload_category_service.dart';
import '../widgets/list_card_box.dart';
import '../widgets/query_stream_builder.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});
  final categoryId = Get.arguments["category_id"];
  final UploadCategoryServices _upload = UploadCategoryServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _categoryIdcontroller = TextEditingController();
  final TextEditingController _statuscontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageUrlcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            Get.offAllNamed(AppRoutes.getCategoryRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
            child: Text(
              "Sub Categories",
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
          stream: _upload.fetchSubCategory(categoryId),
          builder: (context, documents) {
            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final SubCategoryModel subcat = doc.data() as SubCategoryModel;
                String subcatId = subcat.id;
                return ListCardBox(
                  title: subcat.name,
                  subtitle: subcat.id,
                  detail: DateFormat("dd-MM-yyyy h:mm a")
                      .format(subcat.updatedAt.toDate()),
                  deleteFunc: () => _deleteDialog(context, subcatId),
                  editFunc: () => _displayUpdateDialog(context, subcat),
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
                color: AppTheme.allports800,
                strokeWidth: 2,
              )),
          emptyWidget: const Center(child: Text('Add SubCategory')),
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
              Text("Add SubCategory",
                  style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (subcat_1)"),
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
                controller: _categoryIdcontroller,
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
                      _categoryIdcontroller.clear();
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
                      _upload.uploadSubCategory(SubCategoryModel(
                          id: _idcontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          categoryId: _categoryIdcontroller.text.toString(),
                          status: _statuscontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          createdAt: Timestamp.now(),
                          updatedAt: Timestamp.now()));
                      Get.back();
                      AppSnackBar.success("Added SubCategory");

                      _imageUrlcontroller.clear();
                      _statuscontroller.clear();
                      _categoryIdcontroller.clear();
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

  void _displayUpdateDialog(BuildContext context, SubCategoryModel subcat) {
    _imageUrlcontroller.text = subcat.imageUrl;
    _descriptioncontroller.text = subcat.description;
    _namecontroller.text = subcat.name;
    _idcontroller.text = subcat.id;
    _statuscontroller.text = subcat.status;
    _categoryIdcontroller.text = subcat.categoryId;

    Get.bottomSheet(
        isDismissible: false,
        backgroundColor: AppTheme.allports100,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Update SubCategory",
                  style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (subcat_1)"),
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
                controller: _categoryIdcontroller,
                decoration: InputDecoration(hintText: subcat.categoryId),
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
                      _categoryIdcontroller.clear();
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
                      SubCategoryModel updatedsubcat = subcat.copyWith(
                          id: _idcontroller.text.toString(),
                          categoryId: _categoryIdcontroller.text.toString(),
                          status: _statuscontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          updatedAt: Timestamp.now());
                      _upload.updateSubCategory(
                          subcat.categoryId, subcat.id, updatedsubcat);
                      Get.back();
                      AppSnackBar.success("Updated SubCategory");

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

  void _deleteDialog(BuildContext context, String subcatId) {
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
                      _upload.deleteSubCategory(categoryId, subcatId);
                      Get.back();
                      AppSnackBar.error("Deleted SubCategory");
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
