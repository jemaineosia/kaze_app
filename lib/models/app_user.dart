class AppUser {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String userRole;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.fullName = "",
    this.userRole = "user",
  });

  AppUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        email = data['email'],
        fullName = data['fullName'],
        userRole = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'userRole': userRole,
    };
  }
}
