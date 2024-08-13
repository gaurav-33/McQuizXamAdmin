import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../Utils/toast_snack_bar.dart';
import '../models/teacher_model.dart';
import '../services/firestore_ref_service.dart';

class TeacherService {
  late final FirestoreRefService _firestoreRefService;
  TeacherService() {
    _firestoreRefService = FirestoreRefService();
  }

  Future<void> uploadTeacher(TeacherModel teacher) async {
    try {
      // Upload the category data
      CollectionReference<TeacherModel> teacherRef =
          _firestoreRefService.teacherscollectionref;
      await teacherRef.doc(teacher.id).set(teacher);
      AppSnackBar.success("${teacher.name} Uploaded");
      if (kDebugMode) {
        print('${teacher.name} uploaded successfully');
      }
    } catch (e) {
      AppSnackBar.error("Failed to upload: $e");
      if (kDebugMode) {
        print('Failed to upload: $e');
      }
    }
  }

  Stream<QuerySnapshot> fetchTeacher() {
    return _firestoreRefService.teacherscollectionref.snapshots();
  }

  void updateTeacher(String teacherId, TeacherModel teacher) async {
    await _firestoreRefService.teacherscollectionref
        .doc(teacherId)
        .update(teacher.toJson());
  }

  void deleteCategory(String teacherId) async {
    await _firestoreRefService.teacherscollectionref.doc(teacherId).delete();
  }
}
