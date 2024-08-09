import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/subject_model.dart';

import 'firestore_ref_service.dart';

class UploadSubjectServices {
  late final FirestoreRefService _firestoreRefService;
  UploadSubjectServices() {
    _firestoreRefService = FirestoreRefService();
  }

  Future<void> uploadSubject(SubjectModel subject) async {
    try {
      // Upload the category data
      CollectionReference<SubjectModel> subjectRef =
          _firestoreRefService.subjectcollectionref;
      await subjectRef.doc(subject.id).set(subject);
      if (kDebugMode) {
        print('${subject.name} uploaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to upload Subject: $e');
      }
    }
  }

  Future<void> uploadTopic(TopicModel topic) async {
    try {
      // Upload the category data
      CollectionReference<TopicModel> topicRef =
          _firestoreRefService.getTopicRef(topic.subjectId);
      await topicRef.doc(topic.id).set(topic);
      if (kDebugMode) {
        print('${topic.name} uploaded successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to upload : $e');
      }
    }
  }

  Stream<QuerySnapshot> fetchSubject() {
    return _firestoreRefService.subjectcollectionref.snapshots();
  }

  void updateSubject(String subjectId, SubjectModel subject) async {
    await _firestoreRefService.subjectcollectionref
        .doc(subjectId)
        .update(subject.toJson());
  }

  void deleteSubject(String subjectId) async {
    await _firestoreRefService.subjectcollectionref.doc(subjectId).delete();
  }

  Stream<QuerySnapshot> fetchTopic(String subjectId) {
    return _firestoreRefService.getTopicRef(subjectId).snapshots();
  }

  void updateTopic(String subjectId, String topicId, TopicModel topic) async {
    await _firestoreRefService
        .getTopicRef(subjectId)
        .doc(topicId)
        .update(topic.toJson());
  }

  void deleteTopic(String subjectId, String topicId) async {
    await _firestoreRefService.getTopicRef(subjectId).doc(topicId).delete();
  }

  Future<void> uploadSub() async {
    final mData = await rootBundle.loadString("assets/subject.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(mData);
    List<List<dynamic>> data = [];
    data = csvTable;
    for (var i = 1; i < data[0].length; i++) {
      // print(data[0][i]);
      if (data[0][i] != "" && data[0][i] != null) {
        // print(data[0][i]);

        final SubjectModel subjectModel = SubjectModel(
            id: i < 10 ? "subject_0$i" : "subject_$i",
            name: "${data[0][i]}",
            description: "${data[0][i]} Subject and its Topics",
            imageUrl: "",
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now());
        await uploadSubject(subjectModel);
      }
    }
    var j = 1;
    while (j < data[0].length) {
      for (var i = 1; i < data.length; i++) {
        // print(data[i][j]);
        if (data[i][j] != "" && data[i][j] != null) {
          // print(data[i][j]);
          final TopicModel topicModel = TopicModel(
              id: i < 10 ? "topic_0$i" : "topic_$i",
              subjectId: j < 10 ? "subject_0$j" : "subject_$j",
              name: "${data[i][j]}",
              description: "${data[i][j]} Topics and many more.",
              imageUrl: "",
              status: "active",
              createdAt: Timestamp.now(),
              updatedAt: Timestamp.now());
          await uploadTopic(topicModel);
        }
      }
      ++j;
    }
  }
}
