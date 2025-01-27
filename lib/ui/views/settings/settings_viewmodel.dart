import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  void signOut() async {
    await _authService.signOut();
    _navigationService.navigateTo(Routes.loginView);
  }

  void navigateToAdmin() async {
    await _navigationService.navigateTo(Routes.adminView);
  }
}
