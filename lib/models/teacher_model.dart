class TeacherModel {
  TeacherModel({
    required this.name,
    required this.email,
    required this.role,
    required this.id,
  });

  final String name;
  final String email;
  final String role;
  final String id;

  TeacherModel copyWith({
    String? name,
    String? email,
    String? role,
    String? id,
  }) {
    return TeacherModel(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      name: json["name"],
      email: json["email"],
      role: json["role"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "id": id,
      };
}
