import 'package:kaze_app/models/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser({
    required super.id,
    required super.username,
    required super.email,
    required this.bio,
    required this.profileImageUrl,
  });

  ProfileUser copyWith({String? newBio, String? newProfileImageUrl}) {
    return ProfileUser(
      id: id,
      username: username,
      email: email,
      bio: newBio ?? bio,
      profileImageUrl: newProfileImageUrl ?? profileImageUrl,
    );
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }
}
