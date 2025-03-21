import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/category_model.dart';
import '../services/firestore_ref_service.dart';

class ManageCategoryServices {
  late final FirestoreRefService _firestoreRefService;

  ManageCategoryServices() {
    _firestoreRefService = FirestoreRefService();
  }

  Future<void> uploadCategory(CategoryModel cat) async {
    try {
      // Upload the category data
      CollectionReference<CategoryModel> categoryRef =
          _firestoreRefService.categorycollectionref;
      await categoryRef.doc(cat.id).set(cat);
      if (kDebugMode) {
        print('${cat.name} Category uploaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to upload category: $e');
      }
    }
  }

  Future<void> uploadSubCategory(SubCategoryModel subcat) async {
    try {
      // Upload the category data
      CollectionReference<SubCategoryModel> subcategoryRef =
          _firestoreRefService.getSubCategoryRef(subcat.categoryId);
      await subcategoryRef.doc(subcat.id).set(subcat);
      if (kDebugMode) {
        print('${subcat.name} SUb-Category uploaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to upload category: $e');
      }
    }
  }

  Stream<QuerySnapshot> fetchCategory() {
    return _firestoreRefService.categorycollectionref.snapshots();
  }

  void updateCategory(String catId, CategoryModel category) async {
    await _firestoreRefService.categorycollectionref
        .doc(catId)
        .update(category.toJson());
  }

  void deleteCategory(String catId) async {
    await _firestoreRefService.categorycollectionref.doc(catId).delete();
  }

  Stream<QuerySnapshot> fetchSubCategory(String categoryId) {
    return _firestoreRefService.getSubCategoryRef(categoryId).snapshots();
  }

  void updateSubCategory(
      String categoryId, String subcatId, SubCategoryModel category) async {
    await _firestoreRefService
        .getSubCategoryRef(categoryId)
        .doc(subcatId)
        .update(category.toJson());
  }

  void deleteSubCategory(String categoryId, String subcatId) async {
    await _firestoreRefService
        .getSubCategoryRef(categoryId)
        .doc(subcatId)
        .delete();
  }

  Future<void> uploadCat() async {
    final mData = await rootBundle.loadString("assets/new.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(mData);
    List<List<dynamic>> data = [];
    data = csvTable;
    for (var i = 1; i < data[0].length; i++) {
      // print(data[0][i]);
      if (data[0][i] != "" && data[0][i] != null) {
        // print(data[0][i]);

        final CategoryModel cat = CategoryModel(
            id: i < 10 ? "cat_0$i" : "cat_$i",
            name: "${data[0][i]}",
            description: "${data[0][i]} examinations for various positions.",
            imageUrl: "",
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now());
        await uploadCategory(cat);
      }
    }
    var j = 1;
    while (j < data[0].length) {
      for (var i = 1; i < data.length; i++) {
        // print(data[i][j]);
        if (data[i][j] != "" && data[i][j] != null) {
          // print(data[i][j]);
          final SubCategoryModel subcat = SubCategoryModel(
              id: i < 10 ? "subcat_0$i" : "subcat_$i",
              categoryId: j < 10 ? "cat_0$j" : "cat_$j",
              name: "${data[i][j]}",
              description: "Examination for ${data[i][j]} posts.",
              imageUrl: "",
              status: "active",
              createdAt: Timestamp.now(),
              updatedAt: Timestamp.now());
          await uploadSubCategory(subcat);
        }
      }
      ++j;
    }
  }
}
