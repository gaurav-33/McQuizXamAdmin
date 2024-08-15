import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Utils/toast_snack_bar.dart';
import '../models/category_model.dart';
import '../routes/app_routes.dart';
import '../services/manage_category_service.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/list_card_box.dart';
import '../widgets/query_stream_builder.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({super.key});
  final categoryId = Get.arguments["category_id"];
  final category = Get.arguments["category"];
  final ManageCategoryServices _upload = ManageCategoryServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _categoryIdcontroller = TextEditingController();
  final TextEditingController _statuscontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageUrlcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            Get.offAllNamed(AppRoutes.getCategoryRoute());
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text("SubCategory",
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
                  onCardTap: (){
                    Get.toNamed(AppRoutes.getTestRoute(), arguments: {
                      "category_id" : categoryId,
                      "category" : category,
                      "subCat_id": subcatId,
                      "subCat" : subcat.name
                    });
                  },
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add SubCategory')),
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
        title: "Add SubCategory",
        idController: _idcontroller,
        nameController: _namecontroller,
        dynamicFieldController:
            _categoryIdcontroller, // Example of renamed controller
        statusController: _statuscontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        dynamicHint: "Category (cat_01)", // Example of dynamic hint
        onSave: () {
          // Create a new TopicModel with the data from the controllers
          SubCategoryModel newSubCat = SubCategoryModel(
            id: _idcontroller.text.trim().toLowerCase().toString(),
            name: _namecontroller.text.trim().toString(),
            categoryId: _categoryIdcontroller.text.trim().toLowerCase().toString(),
            status: _statuscontroller.text.trim().toString(),
            description: _descriptioncontroller.text.trim().toString(),
            imageUrl: _imageUrlcontroller.text.trim().toString(),
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
          _upload.uploadSubCategory(newSubCat); // Upload the new topic
          Get.back(); // Close the bottom sheet
          AppSnackBar.success("Added SubCategory"); // Show success message
          _clearControllers(); // Clear all the controllers
        },
        onCancel: () {
          Get.back(); // Close the bottom sheet
          _clearControllers(); // Clear all the controllers
        },
      ),
    );
  }

  void _displayUpdateDialog(BuildContext context, SubCategoryModel subCat) {
    // Populate the controllers with the existing topic data
    _imageUrlcontroller.text = subCat.imageUrl;
    _descriptioncontroller.text = subCat.description;
    _namecontroller.text = subCat.name;
    _idcontroller.text = subCat.id;
    _statuscontroller.text = subCat.status;
    // _categoryIdcontroller.text = subCat.categoryId;
    _categoryIdcontroller.text = categoryId;

    Get.bottomSheet(
      isDismissible: false,
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Update SubCategory",
        idController: _idcontroller,
        nameController: _namecontroller,
        dynamicFieldController:
            _categoryIdcontroller, // Example of renamed controller
        statusController: _statuscontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        dynamicHint: "Category (cat_01)", // Example of dynamic hint
        onSave: () {
          SubCategoryModel updatedSubCat = subCat.copyWith(
            id: _idcontroller.text.trim().toLowerCase().toString(),
            categoryId: _categoryIdcontroller.text.trim().toString(),
            status: _statuscontroller.text.trim().toString(),
            name: _namecontroller.text.trim().toString(),
            description: _descriptioncontroller.text.trim().toString(),
            imageUrl: _imageUrlcontroller.text..trim().toString(),
            updatedAt: Timestamp.now(),
          );
          _upload.updateSubCategory(
              updatedSubCat.categoryId, updatedSubCat.id, updatedSubCat);
          Get.back();
          AppSnackBar.success("Updated SubCategory");
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
    _categoryIdcontroller.clear();
    _descriptioncontroller.clear();
    _idcontroller.clear();
    _namecontroller.clear();
  }

  void _deleteDialog(BuildContext context, String subcatId) {
    final theme = Theme.of(context);
    Get.bottomSheet(
      backgroundColor: theme.cardColor,
      CustomDialogForm(
        title: "Want to Delete it?",
        onCancel: () {
          Get.back();
        },
        onSave: () {
          _upload.deleteSubCategory(categoryId, subcatId);
          Get.back();
          AppSnackBar.error("Deleted");
        },
      ),
    );
  }
}
