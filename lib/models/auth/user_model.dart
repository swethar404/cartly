class UserModel {
  final int? userId;
  final String? employeeId;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String createdAt;

  const UserModel({
    this.userId,
    this.employeeId,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'],
      employeeId: map['employee_id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      role: map['role'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'employee_id': employeeId,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'created_at': createdAt,
    };
  }

  UserModel copyWith({
    int? userId,
    String? employeeId,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? role,
    String? createdAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      employeeId: employeeId ?? this.employeeId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}