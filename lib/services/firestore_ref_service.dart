import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcquizadmin/models/teacher_model.dart';
import 'package:mcquizadmin/models/test_config_model.dart';
import '../models/all_ques_model.dart';
import '../models/subject_model.dart';
import '../models/category_model.dart';
import '../models/counter_model.dart';
import '../models/test_paper_model.dart';

const String CATEGORY_COLLECT_REF = "categories";
const String SUBCATEGORY_COLLECT_REF = "subcategories";
const String QUESTION_PAPER_COLLECT_REF = "question_papers";
const String QUESTION_COLLECT_REF = "questions";
const String SUBJECT_COLLECT_REF = "subjects";
const String TOPIC_COLLECT_REF = "topics";
const String COUNTER_COLLECT_REF = "counters";
const String ALLQUESTION_COLLECT_REF = "allquestions";
const String TEACHERS_COLLET_REF = "teachers";
const String TESTCONFIF_COLLECT_REF = "test_configs";

class FirestoreRefService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<CategoryModel> categorycollectionref;
  late final CollectionReference<SubjectModel> subjectcollectionref;
  late final CollectionReference<CounterModel> countercollectionref;
  late final CollectionReference<AllQuestionModel> allquestioncollectionref;
  late final CollectionReference<TeacherModel> teacherscollectionref;
  late final CollectionReference<TestConfigModel> testconfigcolelctionref;

  FirestoreRefService() {
    categorycollectionref = _firestore
        .collection(CATEGORY_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                CategoryModel.fromJson(snapshots.data()!),
            toFirestore: (catdata, _) => catdata.toJson());
    subjectcollectionref = _firestore
        .collection(SUBJECT_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                SubjectModel.fromJson(snapshots.data()!),
            toFirestore: (subdata, _) => subdata.toJson());

    countercollectionref = _firestore
        .collection(COUNTER_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                CounterModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());

    teacherscollectionref = _firestore
        .collection(TEACHERS_COLLET_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                TeacherModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());

    testconfigcolelctionref = _firestore
        .collection(TESTCONFIF_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                TestConfigModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<SubCategoryModel> getSubCategoryRef(String categoryId) {
    return categorycollectionref
        .doc(categoryId)
        .collection(SUBCATEGORY_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                SubCategoryModel.fromJson(snapshots.data()!),
            toFirestore: (subcatdata, _) => subcatdata.toJson());
  }

  CollectionReference<TopicModel> getTopicRef(String subjectId) {
    return subjectcollectionref
        .doc(subjectId)
        .collection(TOPIC_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                TopicModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<AllQuestionModel> getAllQuesRef(
      String subjectId, String topicId) {
    return subjectcollectionref
        .doc(subjectId)
        .collection(TOPIC_COLLECT_REF)
        .doc(topicId)
        .collection(ALLQUESTION_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                AllQuestionModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<MockTestModel> getQuestionPaperRef(
      String categoryId, String subcatId) {
    return categorycollectionref
        .doc(categoryId)
        .collection(SUBCATEGORY_COLLECT_REF)
        .doc(subcatId)
        .collection(QUESTION_PAPER_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                MockTestModel.fromJson(snapshot.data()!),
            toFirestore: (paperdata, _) => paperdata.toJson());
  }

  CollectionReference<QuestionModel> getQuestionRef(
      String paperId, String categoryId, String subcatId) {
    return categorycollectionref
        .doc(categoryId)
        .collection(SUBCATEGORY_COLLECT_REF)
        .doc(subcatId)
        .collection(QUESTION_PAPER_COLLECT_REF)
        .doc(paperId)
        .collection(QUESTION_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                QuestionModel.fromJson(snapshot.data()!),
            toFirestore: (question, _) => question.toJson());
  }
}
