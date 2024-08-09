import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return CategoryModel(
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

class SubCategoryModel {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String imageUrl;
  final String status;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json["id"],
      categoryId: json["category_id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  SubCategoryModel copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? description,
    String? imageUrl,
    String? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
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
      "category_id": categoryId,
      "name": name,
      "description": description,
      "image_url": imageUrl,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

// {
//   "id": "category_1",
//   "name": "SSC",
//   "description": "Staff Selection Commission examinations for various positions.",
//   "image_url": "https://example.com/images/ssc.jpg",
//   "created_at": "2023-08-01T10:00:00Z",
//   "updated_at": "2023-08-01T12:00:00Z"
// }

// {
//   "id": "subcat_1",
//   "category_id": "category_1",
//   "name": "Upper Division Clerk (UDC)",
//   "description": "Examination for Upper Division Clerk posts.",
//   "image_url": "https://example.com/images/udc.jpg",
//   "status": "active",
//   "created_at": "2023-08-01T10:00:00Z",
//   "updated_at": "2023-08-01T12:00:00Z"
// }
