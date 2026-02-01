import 'dart:convert';

import 'package:gia_pha_so/src/domain/entity/user_entity.dart';

class UserModel {
  final String name;
  final String password;
  final String email;

  UserModel({required this.name, required this.password, required this.email});

  // Factory constructor để tạo từ JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'password': password, 'email': email};
  }

  // Chuyển thành JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Factory từ JSON string
  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  // Tạo copy với các giá trị thay đổi
  UserModel copyWith({String? name, String? password, String? email}) {
    return UserModel(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  // Kiểm tra hợp lệ
  bool get isValid =>
      name.isNotEmpty && password.isNotEmpty && email.isNotEmpty;

  // Kiểm tra độ dài password
  bool get isPasswordStrong => password.length >= 6;

  // So sánh 2 UserModel
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => name.hashCode ^ password.hashCode ^ email.hashCode;

  // Hiển thị thông tin (ẩn password)
  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: ${'*' * password.length})';
  }

  // Tạo từ username (password mặc định)
  factory UserModel.fromName(String name) {
    return UserModel(name: name, password: '', email: "");
  }

  // Kiểm tra password match
  bool checkPassword(String inputPassword) {
    return password == inputPassword;
  }

  // Tạo user với password đã hash (ví dụ đơn giản)
  UserModel withHashedPassword() {
    // Trong thực tế, sử dụng thuật toán hash như bcrypt, Argon2
    final hashedPassword = _simpleHash(password);
    return copyWith(password: hashedPassword);
  }

  String _simpleHash(String input) {
    // Hàm hash đơn giản, trong thực tế dùng package chuyên dụng
    return input.codeUnits
        .fold(0, (prev, element) => prev + element)
        .toString();
  }

  // Validate name (không chứa ký tự đặc biệt)
  bool get isValidName => RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(name);

  // Validate email format (nếu name là email)
  bool get isEmailFormat => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(name);

  // Kiểm tra user rỗng
  bool get isEmpty => name.isEmpty && password.isEmpty;

  // Kiểm tra user không rỗng
  bool get isNotEmpty => !isEmpty;

  UserEntity get toEntity {
    return UserEntity(name: name, password: password, email: email);
  }
}
