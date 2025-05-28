import 'dart:convert';

class AuthModel {
  final String userId;
  final String email;
  final String name;
  final String password;

  AuthModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.password,
  });

  factory AuthModel.fromMap(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      password: json['password'] ?? "",
    );
  }

  // String tojson() => json.encode(toMap());
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory AuthModel.fromjson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
