import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Utils/tost_snackbar.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/list_card_box.dart';
import '../routes/app_routes.dart';
import '../models/category_model.dart';
import '../res/app_theme.dart';
import '../services/upload_category_service.dart';
import '../widgets/query_stream_builder.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final UploadCategoryServices _upload = UploadCategoryServices();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _imageUrlcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
          Text("Category",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
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
          stream: _upload.fetchCategory(),
          builder: (context, documents) {
            return ListView.builder(
              itemCount: documents?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = documents![index];
                final CategoryModel cat = doc.data() as CategoryModel;
                String catId = cat.id;
                return ListCardBox(
                  title: cat.name,
                  subtitle: cat.id,
                  detail: DateFormat("dd-MM-yyyy h:mm a")
                      .format(cat.updatedAt.toDate()),
                  deleteFunc: () => _deleteDialog(context, catId),
                  onCardTap: () => Get.toNamed(AppRoutes.getSubCategoryRoute(),
                      arguments: {"category_id": catId}),
                  editFunc: () => _displayUpdateDialog(context, cat, catId),
                );
              },
            );
          },
          loadingWidget: const Center(
              child: CircularProgressIndicator(
            color: AppTheme.darkColor,
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add Category')),
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
        title: "Add Category",
        idController: _idcontroller,
        nameController: _namecontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        idHint: "Id(cat_01)",
        onSave: () {
          // Create a new TopicModel with the data from the controllers
          CategoryModel newCat = CategoryModel(
            id: _idcontroller.text.toString(),
            name: _namecontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          );
          _upload.uploadCategory(newCat); // Upload the new topic
          Get.back(); // Close the bottom sheet
          AppSnackBar.success("Added Category"); // Show success message
          _clearControllers(); // Clear all the controllers
        },
        onCancel: () {
          Get.back(); // Close the bottom sheet
          _clearControllers(); // Clear all the controllers
        },
      ),
    );
  }

  void _displayUpdateDialog(
      BuildContext context, CategoryModel cat, String catId) {
    _imageUrlcontroller.text = cat.imageUrl;
    _descriptioncontroller.text = cat.description;
    _namecontroller.text = cat.name;
    _idcontroller.text = cat.id;

    Get.bottomSheet(
      isDismissible: false,
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Update Category",
        idController: _idcontroller,
        nameController: _namecontroller,
        descriptionController: _descriptioncontroller,
        imageUrlController: _imageUrlcontroller,
        onSave: () {
          CategoryModel updatedCat = cat.copyWith(
            id: _idcontroller.text.toString(),
            name: _namecontroller.text.toString(),
            description: _descriptioncontroller.text.toString(),
            imageUrl: _imageUrlcontroller.text.toString(),
            updatedAt: Timestamp.now(),
          );
          _upload.updateCategory(catId, updatedCat);
          Get.back();
          AppSnackBar.success("Updated Category");
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

  void _deleteDialog(BuildContext context, String catId) {
    Get.bottomSheet(
      backgroundColor: Theme.of(context).cardColor,
      CustomDialogForm(
        title: "Want to Delete it?",
        onCancel: () {
          Get.back();
        },
        onSave: () {
          _upload.deleteCategory(catId);
          Get.back();
          AppSnackBar.error("Deleted");
        },
      ),
    );
  }
}
