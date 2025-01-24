import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthService() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      await _populateCurrentUser(session?.user);
    });
  }

  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(password: password, email: email);
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
    return session != null;
  }

  Future _populateCurrentUser(User? user) async {
    if (user != null) {}
  }
}
