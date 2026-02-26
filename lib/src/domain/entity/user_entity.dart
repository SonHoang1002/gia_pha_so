import 'dart:convert';

class UserEntity {
  final String name;
  final String email;
  final String password;
  
  UserEntity({
    required this.name,
    required this.email,
    required this.password,
  });
  
  // Factory constructor để tạo từ JSON
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
    );
  }
  
  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'email': email,
    };
  }
  
  // Chuyển thành JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }
  
  // Factory từ JSON string
  factory UserEntity.fromJsonString(String jsonString) {
    return UserEntity.fromJson(jsonDecode(jsonString));
  }
  
  // Tạo copy với các giá trị thay đổi
  UserEntity copyWith({
    String? name,
    String? password,
    String? email,
  }) {
    return UserEntity(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }
  
  // Kiểm tra hợp lệ
  bool get isValid => name.isNotEmpty && password.isNotEmpty && email.isNotEmpty;
  
  // Kiểm tra độ dài password
  bool get isPasswordStrong => password.length >= 6;
  
  // So sánh 2 UserEntity
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }
  
  @override
  int get hashCode => name.hashCode ^ password.hashCode ^ email.hashCode;
  
  // Hiển thị thông tin (ẩn password)
  @override
  String toString() {
    return 'UserEntity(name: $name, email: $email, password: ${'*' * password.length})';
  }
  
  // Tạo từ username (password mặc định)
  factory UserEntity.fromName(String name) {
    return UserEntity(
      name: name,
      password: '',
      email: '',
    );
  }
  
  // Kiểm tra password match
  bool checkPassword(String inputPassword) {
    return password == inputPassword;
  }
  
  // Tạo user với password đã hash (ví dụ đơn giản)
  UserEntity withHashedPassword() {
    // Trong thực tế, sử dụng thuật toán hash như bcrypt, Argon2
    final hashedPassword = _simpleHash(password);
    return copyWith(password: hashedPassword);
  }
  
  String _simpleHash(String input) {
    // Hàm hash đơn giản, trong thực tế dùng package chuyên dụng
    return input.codeUnits.fold(0, (prev, element) => prev + element).toString();
  }
  
  // Validate name (không chứa ký tự đặc biệt)
  bool get isValidName => RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(name);
  
  // Validate email format (nếu name là email)
  bool get isEmailFormat => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(name);
  
  // Chuyển đổi sang Map với key là name
  Map<String, UserEntity> toMapByUsername() {
    return {name: this};
  }
  
  // Kiểm tra user rỗng
  bool get isEmpty => name.isEmpty && password.isEmpty;
  
  // Kiểm tra user không rỗng
  bool get isNotEmpty => !isEmpty;
}

// Extension cho List<UserEntity>
extension UserEntityListExtension on List<UserEntity> {
  // Tìm user theo name
  UserEntity? findByName(String name) {
    try {
      return firstWhere((user) => user.name == name);
    } catch (e) {
      return null;
    }
  }
  
  // Kiểm tra user có tồn tại không
  bool containsName(String name) {
    return any((user) => user.name == name);
  }
  
  // Lấy list names
  List<String> get names => map((user) => user.name).toList();
  
  // Chuyển thành Map với key là name
  Map<String, UserEntity> toMapByUsername() {
    return {for (var user in this) user.name: user};
  }
  
  // Filter users hợp lệ
  List<UserEntity> get validUsers => where((user) => user.isValid).toList();
  
  // Filter users có password mạnh
  List<UserEntity> get strongPasswordUsers => 
      where((user) => user.isPasswordStrong).toList();
  
  // Lưu dưới dạng JSON string
  String toJsonString() {
    return jsonEncode(map((user) => user.toJson()).toList());
  }
  
  // Tạo từ JSON string
  static List<UserEntity> fromJsonString(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => UserEntity.fromJson(json)).toList();
  }
}

// Extension cho Map<String, UserEntity>
extension UserEntityMapExtension on Map<String, UserEntity> {
  // Lấy list users
  List<UserEntity> toList() => values.toList();
  
  // Kiểm tra username có tồn tại
  bool hasUser(String username) => containsKey(username);
  
  // Thêm user vào map
  void addUser(UserEntity user) {
    this[user.name] = user;
  }
  
  // Xóa user khỏi map
  void removeUser(String username) {
    remove(username);
  }
  
  // Validate password
  bool validatePassword(String username, String password) {
    final user = this[username];
    return user != null && user.checkPassword(password);
  }
}