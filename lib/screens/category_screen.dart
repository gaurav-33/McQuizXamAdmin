import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Utils/tost_snackbar.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: AppTheme.allports800,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06,
            child: Text(
              "Categories",
              style: Theme.of(context).textTheme.displaySmall,
            ),
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
            color: AppTheme.allports800,
            strokeWidth: 2,
          )),
          emptyWidget: const Center(child: Text('Add Category')),
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
              Text("Add Category",
                  style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (cat_1)"),
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
                      _upload.uploadCategory(CategoryModel(
                          id: _idcontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          createdAt: Timestamp.now(),
                          updatedAt: Timestamp.now()));
                      Get.back();
                      AppSnackBar.success("Added Category");

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

  void _displayUpdateDialog(
      BuildContext context, CategoryModel cat, String catId) {
    _imageUrlcontroller.text = cat.imageUrl;
    _descriptioncontroller.text = cat.description;
    _namecontroller.text = cat.name;
    _idcontroller.text = cat.id;

    Get.bottomSheet(
        isDismissible: false,
        backgroundColor: AppTheme.allports100,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Update Category",
                  style: Theme.of(context).textTheme.titleMedium),
              TextField(
                controller: _idcontroller,
                decoration: const InputDecoration(hintText: "Id (cat_1)"),
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
                      CategoryModel updatedcat = cat.copyWith(
                          id: _idcontroller.text.toString(),
                          name: _namecontroller.text.toString(),
                          description: _descriptioncontroller.text.toString(),
                          imageUrl: _imageUrlcontroller.text.toString(),
                          updatedAt: Timestamp.now());
                      _upload.updateCategory(catId, updatedcat);
                      Get.back();
                      AppSnackBar.success("Updated Category");

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

  void _deleteDialog(BuildContext context, String catId) {
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
                      _upload.deleteCategory(catId);
                      Get.back();
                      AppSnackBar.error("Deleted Category");
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
