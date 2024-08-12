class TestConfigModel {
  TestConfigModel(
      {required this.testTypes,
      required this.questionCounts,
      required this.marksPerQuestion,
      required this.negativeMarks,
      required this.durations,
      required this.status});

  final List<String> testTypes;
  final List<int> questionCounts;
  final List<double> marksPerQuestion;
  final List<double> negativeMarks;
  final List<int> durations;
  final List<String> status;

  TestConfigModel copyWith({
    List<String>? testTypes,
    List<int>? questionCounts,
    List<double>? marksPerQuestion,
    List<double>? negativeMarks,
    List<int>? durations,
  }) {
    return TestConfigModel(
      testTypes: testTypes ?? this.testTypes,
      questionCounts: questionCounts ?? this.questionCounts,
      marksPerQuestion: marksPerQuestion ?? this.marksPerQuestion,
      negativeMarks: negativeMarks ?? this.negativeMarks,
      durations: durations ?? this.durations,
      status: testTypes ?? this.status,
    );
  }

  factory TestConfigModel.fromJson(Map<String, dynamic> json) {
    return TestConfigModel(
      testTypes: json["test_types"] == null
          ? []
          : List<String>.from(json["test_types"]!.map((x) => x)),
      questionCounts: json["question_counts"] == null
          ? []
          : List<int>.from(json["question_counts"]!.map((x) => x)),
      marksPerQuestion: json["marks_per_question"] == null
          ? []
          : List<double>.from(
              json["marks_per_question"]!.map((x) => (x as num).toDouble())),
      negativeMarks: json["negative_marks"] == null
          ? []
          : List<double>.from(
              json["negative_marks"]!.map((x) => (x as num).toDouble())),
      durations: json["durations"] == null
          ? []
          : List<int>.from(json["durations"]!.map((x) => x)),
      status: json["status"] == null
          ? []
          : List<String>.from(json["status"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "test_types": testTypes.map((x) => x).toList(),
        "question_counts": questionCounts.map((x) => x).toList(),
        "marks_per_question": marksPerQuestion.map((x) => x).toList(),
        "negative_marks": negativeMarks.map((x) => x).toList(),
        "durations": durations.map((x) => x).toList(),
        "status": testTypes.map((x) => x).toList(),
      };
}
