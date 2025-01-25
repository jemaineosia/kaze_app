import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    if (_authService.isUserLoggedIn()) {
      _navigationService.replaceWithBottomnavView();
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}
