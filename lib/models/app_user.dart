import 'package:kaze_app/common/enums/app_user_status.dart';

class AppUser {
  final String id;
  final String username;
  final String email;
  final String? fullName; // Nullable
  final String role;
  final AppUserStatus status;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.fullName, // Nullable
    this.role = 'user', // Default to 'user'
    this.status = AppUserStatus.active, // Default to 'active'
    DateTime? createdAt, // Optional, defaults to now
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'], // Handles null
      role: json['role'] ?? 'user', // Default to 'user'
      status: AppUserStatus.fromString(
          json['status'] ?? 'active'), // Default to 'active'
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(), // Default to now if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'role': role,
      'status': status.toValue(), // Convert enum to string
      'created_at': createdAt.toIso8601String(),
    };
  }
}
