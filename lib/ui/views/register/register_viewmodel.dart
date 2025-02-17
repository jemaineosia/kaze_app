import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends FormViewModel {
  final AuthService _authService = AuthService();
  final DialogService _dialogService = DialogService();
  final NavigationService _navigationService = NavigationService();

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    setBusy(true);
    var response = await _authService.signUpWithEmailPassword(
      username,
      email,
      password,
    );
    setBusy(false);

    if (response == null) {
      await _dialogService.showDialog(
        title: "Signup Error",
        description: "Failed to sign up. Please try again.",
      );
      return;
    }

    await _dialogService.showDialog(
      title: "Signup Success",
      description: "Welcome to Kaze! Your account has been created.",
    );
    _navigationService.replaceWithBottomnavView();
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
