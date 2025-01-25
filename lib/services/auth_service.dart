import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/app_user.dart';
import 'package:kaze_app/services/database_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  final _databaseService = locator<DatabaseService>();
  final _dialogService = locator<DialogService>();

  // AuthService() {
  //   _supabase.auth.onAuthStateChange.listen((data) async {
  //     final session = data.session;
  //     await _populateCurrentUser(session?.user);
  //   });
  // }

  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<dynamic> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      AppUser appUser = AppUser(
        username: username,
        email: email,
      );

      await _databaseService.createAppUser(appUser);

      return appUser;
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
