import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/app_user.dart';
import 'package:kaze_app/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  final _databaseService = locator<DatabaseService>();

  Future<dynamic> signInWithEmailPassword(
      String username, String password) async {
    try {
      final currentUser = await _databaseService.getUserByUsername(username);

      if (currentUser == null) return "Username or Password is invalid";

      if (currentUser is AppUser) {
        return await _supabase.auth.signInWithPassword(
          password: password,
          email: currentUser.email,
        );
      }
    } on AuthException catch (e) {
      print('AUTHSERVICE - Signin: ${e.message}');
      return e.message;
    }
  }

  Future<dynamic> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      AppUser appUser = AppUser(
        username: username,
        email: email,
      );

      await _databaseService.createAppUser(appUser);

      return response;
    } on AuthException catch (e) {
      print('AUTHSERVICE - Signup: ${e.message}');
      return 'Registration Error. Contact admin.';
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  User? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    return session?.user;
  }

  bool isUserLoggedIn() {
    final session = _supabase.auth.currentSession;
    if (session != null) _populateCurrentUser(session.user);
    return session != null;
  }

  Future _populateCurrentUser(User? user) async {
    //TODO: populate the user database
    if (user != null) {}
  }
}
