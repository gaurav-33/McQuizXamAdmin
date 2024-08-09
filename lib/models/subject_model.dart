import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  SubjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  SubjectModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image_url": imageUrl,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

class TopicModel {
  final String id;
  final String subjectId;
  final String name;
  final String description;
  final String imageUrl;
  final String status;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  TopicModel({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json["id"],
      subjectId: json["subject_id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  TopicModel copyWith({
    String? id,
    String? name,
    String? subjectId,
    String? description,
    String? imageUrl,
    String? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return TopicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subjectId: subjectId ?? this.subjectId,
      description: description ?? this.description,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subject_id": subjectId,
      "name": name,
      "description": description,
      "image_url": imageUrl,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
