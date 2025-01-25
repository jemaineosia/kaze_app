import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/models/app_user.dart';
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
    try {
      setBusy(true);
      var result =
          await _authService.signUpWithEmailPassword(username, email, password);
      setBusy(false);

      if (result is String) {
        await _dialogService.showDialog(
          title: "Signup Error",
          description: "Username or Email already exists.",
        );
      }

      if (result is AppUser) {
        _navigationService.replaceWithHomeView();
      }
    } on Exception catch (e) {
      await _dialogService.showDialog(
        title: 'Registration Failure',
        description: e.toString(),
      );
      setBusy(false);
    }
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
