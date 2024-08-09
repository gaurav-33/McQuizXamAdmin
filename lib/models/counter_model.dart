class CounterModel {
  final String counterId;

  CounterModel({required this.counterId});

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(counterId: json['counter_id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "counter_id": counterId,
    };
  }
}
