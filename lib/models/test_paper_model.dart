import 'package:cloud_firestore/cloud_firestore.dart';

// class OptionModel {
//   final String optionId;
//   final String text;
//   final bool isCorrect;
//
//   OptionModel({
//     required this.optionId,
//     required this.text,
//     required this.isCorrect,
//   });
//
//   factory OptionModel.fromJson(Map<String, dynamic> json) {
//     return OptionModel(
//       optionId: json['option_id'],
//       text: json['text'],
//       isCorrect: json['is_correct'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'option_id': optionId,
//       'text': text,
//       'is_correct': isCorrect,
//     };
//   }
// }
//
// class QuestionModel {
//   final String questionId;
//   final String questionText;
//   final String questionType;
//   final List<OptionModel> options;
//   final int marks;
//
//   QuestionModel({
//     required this.questionId,
//     required this.questionText,
//     required this.questionType,
//     required this.options,
//     required this.marks,
//   });
//
//   factory QuestionModel.fromJson(Map<String, dynamic> json) {
//     var optionsList = json['options'] as List;
//     List<OptionModel> options =
//         optionsList.map((i) => OptionModel.fromJson(i)).toList();
//
//     return QuestionModel(
//       questionId: json['question_id'],
//       questionText: json['question_text'],
//       questionType: json['question_type'],
//       options: options,
//       marks: json['marks'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'question_id': questionId,
//       'question_text': questionText,
//       'question_type': questionType,
//       'options': options.map((option) => option.toJson()).toList(),
//       'marks': marks,
//     };
//   }
// }

class MockTestModel {
  final String owner;
  final String id;
  final String categoryId;
  final String subcategoryId;
  final String title;
  final String description;
  final int duration;
  final double totalMarks;
  final double negativeMarking;
  final String status;
  final String examType;
  final int numberOfQuestions;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  MockTestModel({
    required this.owner,
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.title,
    required this.description,
    required this.duration,
    required this.totalMarks,
    required this.negativeMarking,
    required this.status,
    required this.examType,
    required this.numberOfQuestions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MockTestModel.fromJson(Map<String, dynamic> json) {
    return MockTestModel(
      owner: json['owner'],
      id: json['id'],
      categoryId: json['category_id'],
      subcategoryId: json['subcategory_id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      totalMarks: json['total_marks'],
      negativeMarking: json['negative_marking'],
      status: json['status'],
      examType: json['exam_type'],
      numberOfQuestions: json['number_of_questions'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'id': id,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'title': title,
      'description': description,
      'duration': duration,
      'total_marks': totalMarks,
      'negative_marking': negativeMarking,
      'status': status,
      'exam_type': examType,
      'number_of_questions': numberOfQuestions,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
