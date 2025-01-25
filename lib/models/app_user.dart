class AppUser {
  String username;
  String email;
  String? fullname;
  String userRole;
  DateTime createdAt;

  AppUser({
    required this.username,
    required this.email,
    this.fullname = "",
    this.userRole = "user",
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      username: map['username'] as String,
      email: map['email'] as String,
      fullname: map['fullname'] as String? ?? '',
      userRole: map['user_role'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'fullname': fullname,
      'user_role': userRole,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
