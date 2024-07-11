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
    try {
      setBusy(true);
      var result =
          await _authService.signUpWithEmailPassword(username, email, password);
      setBusy(false);

      if (result.user != null) {
        _navigationService.replaceWithHomeView();
      } else {
        await _dialogService.showDialog(
          title: 'Registration Failure',
          description: 'General registration failure. Please try again later.',
        );
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
