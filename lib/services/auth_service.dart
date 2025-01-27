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
      // Step 1: Fetch the user from the database using the username
      final currentUser = await _databaseService.getUserByUsername(username);

      if (currentUser == null) {
        return "Username or Password is invalid";
      }

      if (currentUser is AppUser) {
        // Step 2: Authenticate the user with Supabase
        final authResponse = await _supabase.auth.signInWithPassword(
          password: password,
          email: currentUser.email,
        );

        if (authResponse.user == null) {
          return "Authentication failed. Please check your credentials.";
        }

        // Step 3: Successful login
        return authResponse;
      }

      return "Unexpected error. Please try again.";
    } on AuthException catch (e) {
      print('AUTHSERVICE - Signin: ${e.message}');
      return e.message; // Return Supabase error message
    } catch (e) {
      print('AUTHSERVICE - Unexpected Error: $e');
      return "An unexpected error occurred. Please try again later.";
    }
  }

  Future<String?> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      // Step 1: Create the user in authentication
      final response =
          await _supabase.auth.signUp(email: email, password: password);

      if (response.user == null) {
        return 'Unknown error occurred during signup.';
      }

      final userId = response.user!.id;

      // Step 2: Call the Postgres RPC function to handle user creation in appUsers
      final rpcResponse = await _supabase.rpc('handle_user_signup', params: {
        'auth_user_id': userId,
        'username': username,
        'email': email,
      });

      if (rpcResponse.error != null) {
        print('RPC Error: ${rpcResponse.error!.message}');
        // Roll back: Delete the user from auth.users
        await _supabase.auth.admin.deleteUser(userId);
        return 'Failed to create user record in the database. Please try again.';
      }

      // If everything succeeds, return null (success)
      return null;
    } on AuthException catch (e) {
      // Handle Supabase auth-specific errors
      if (e.message.contains('email')) {
        return 'The email "$email" is already registered. Please log in or use another email.';
      }
      return 'Authentication error: ${e.message}';
    } catch (e) {
      // Handle unexpected errors
      print('AUTHSERVICE - Unexpected Error: $e');
      return 'An unexpected error occurred. Please try again later.';
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
