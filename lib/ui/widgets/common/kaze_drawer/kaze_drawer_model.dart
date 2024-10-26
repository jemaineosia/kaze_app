import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KazeDrawerModel extends BaseViewModel {
  final NavigationService _navigationService = NavigationService();
  final AuthService _authService = AuthService();

  void navigateToHome() {
    _navigationService.navigateTo(Routes.homeView);
  }

  void navigateToSettings() {
    _navigationService.navigateTo(Routes.settingsView);
  }

  void logout() {
    _authService.signOut();
    _navigationService.replaceWithLoginView();
  }
}
