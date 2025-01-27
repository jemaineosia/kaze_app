import 'package:kaze_app/common/enums/app_user_status.dart';

class AppUser {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String role;
  final AppUserStatus status;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.role = 'user',
    this.status = AppUserStatus.active,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'] ?? 'user',
      status: AppUserStatus.fromString(json['status'] ?? 'active'),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'role': role,
      'status': status.toValue(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
