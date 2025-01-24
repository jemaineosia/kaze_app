import 'package:kaze_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  // final AuthService _authService = AuthService();
  final DialogService _dialogService = DialogService();
  final NavigationService _navigationService = NavigationService();

  Future<void> login(String username, String password) async {
    // try {
    //   setBusy(true);
    //   var result =
    //       await _authService.signInWithUsernamePassword(username, password);
    //   setBusy(false);

    //   if (result.user != null) {
    //     _navigationService.replaceWithHomeView();
    //   } else {
    //     await _dialogService.showDialog(
    //       title: 'Login Failure',
    //       description: 'General login failure. Please try again later.',
    //     );
    //   }
    // } on Exception catch (e) {
    //   await _dialogService.showDialog(
    //     title: 'Login Failure',
    //     description: e.toString(),
    //   );
    //   setBusy(false);
    // }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  @override
  void setFormStatus() {}
}
