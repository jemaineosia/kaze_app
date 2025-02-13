import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;
  final _appUserService = locator<AppuserService>();
  final LoggerService _loggerService = locator<LoggerService>();

  Future<dynamic> signInWithEmailPassword(
    String username,
    String password,
  ) async {
    try {
      _loggerService.info("Attempting to log in with username: $username");

      // Fetch the user from the database
      final currentUser = await _appUserService.getUserByUsername(username);

      if (currentUser == null) {
        _loggerService.warning("No user found for username: $username");
        return "Username or Password is invalid";
      }

      // Authenticate the user with Supabase
      final authResponse = await _supabase.auth.signInWithPassword(
        password: password,
        email: currentUser.email,
      );

      if (authResponse.user == null) {
        _loggerService.warning("Authentication failed for username: $username");
        return "Authentication failed. Please check your credentials.";
      }

      _loggerService.info("Login successful for username: $username");
      return authResponse;
    } on AuthException catch (e) {
      _loggerService.error("AuthException during sign-in", error: e);
      return e.message; // Return Supabase error message
    } catch (e, stackTrace) {
      _loggerService.error(
        "Unexpected error during sign-in",
        error: e,
        stackTrace: stackTrace,
      );
      return "An unexpected error occurred. Please try again later.";
    }
  }

  Future<String?> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      _loggerService.info("Attempting to sign up with email: $email");

      // Create the user in authentication
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        _loggerService.warning(
          "Unknown error occurred during signup for email: $email",
        );
        return 'Unknown error occurred during signup.';
      }

      final userId = response.user!.id;

      // Call the Postgres RPC function to handle user creation in appUsers
      final rpcResponse = await _supabase.rpc(
        'handle_user_signup',
        params: {'auth_user_id': userId, 'username': username, 'email': email},
      );

      if (rpcResponse.error != null) {
        _loggerService.error("RPC Error: ${rpcResponse.error!.message}");
        // Roll back: Delete the user from auth.users
        await _supabase.auth.admin.deleteUser(userId);
        return 'Failed to create user record in the database. Please try again.';
      }

      _loggerService.info("Sign up successful for email: $email");
      return null; // Success
    } on AuthException catch (e) {
      _loggerService.error("AuthException during sign-up", error: e);
      if (e.message.contains('email')) {
        return 'The email "$email" is already registered. Please log in or use another email.';
      }
      return 'Authentication error: ${e.message}';
    } catch (e, stackTrace) {
      _loggerService.error(
        "Unexpected error during sign-up",
        error: e,
        stackTrace: stackTrace,
      );
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  Future<void> signOut() async {
    try {
      _loggerService.info("Attempting to sign out user.");
      await _supabase.auth.signOut();
      _loggerService.info("User successfully signed out.");
    } catch (e, stackTrace) {
      _loggerService.error(
        "Error during sign-out",
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    _loggerService.debug("Fetching current user email: ${user?.email}");
    return user?.email;
  }

  User? getCurrentUser() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    _loggerService.debug("Fetching current user: ${user?.id}");
    return user;
  }

  bool isUserLoggedIn() {
    final session = _supabase.auth.currentSession;
    final isLoggedIn = session != null;
    _loggerService.info("Checking if user is logged in: $isLoggedIn");

    if (session != null) _populateCurrentUser(session.user);
    return isLoggedIn;
  }

  Future<void> _populateCurrentUser(User? user) async {
    if (user != null) {
      _loggerService.info("Populating user data for userId: ${user.id}");
      // TODO: Add logic to populate user data from database
    } else {
      _loggerService.warning("No user to populate data for.");
    }
  }
}
