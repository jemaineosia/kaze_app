import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends FormViewModel {
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> login(String username, String password) async {
    setBusy(true);
    var result = await _authService.signInWithEmailPassword(username, password);
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }

    if (result is AuthResponse) {
      _navigationService.replaceWithHomeView();
    }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  @override
  void setFormStatus() {}
}
