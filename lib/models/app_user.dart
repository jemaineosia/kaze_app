import 'package:kaze_app/common/enums/app_user_status.dart';

class AppUser {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String role;
  final AppUserStatus status;
  final double balance; // Added balance field
  final double onHoldBalance; // Added on-hold balance field
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.role = 'user',
    this.status = AppUserStatus.active,
    this.balance = 0.0, // Default balance to 0
    this.onHoldBalance = 0.0, // Default on-hold balance to 0
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'], // Updated to snake_case
      role: json['role'] ?? 'user',
      status: AppUserStatus.fromString(json['status'] ?? 'active'),
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0, // Parse balance
      onHoldBalance:
          (json['on_hold_balance'] as num?)?.toDouble() ??
          0.0, // Parse on-hold balance
      createdAt:
          json['created_at'] !=
                  null // Updated to snake_case
              ? DateTime.parse(json['created_at'])
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName, // Updated to snake_case
      'role': role,
      'status': status.toValue(),
      'balance': balance, // Added balance field
      'on_hold_balance': onHoldBalance, // Added on-hold balance field
      'created_at': createdAt.toIso8601String(), // Updated to snake_case
    };
  }
}
