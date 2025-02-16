import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends FormViewModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LoggerService _loggerService = locator<LoggerService>();

  Future<void> login(String username, String password) async {
    setBusy(true);

    _loggerService.info("Attempting login for username: $username");

    final result = await _authService.signInWithEmailPassword(
      username,
      password,
    );

    setBusy(false);

    if (result is String) {
      _loggerService.warning("Login failed: $result");
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
      return;
    }

    if (result is AuthResponse) {
      _loggerService.info("Login successful for username: $username");
      _navigationService.replaceWithBottomnavView();
    }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  @override
  void setFormStatus() {}
}
