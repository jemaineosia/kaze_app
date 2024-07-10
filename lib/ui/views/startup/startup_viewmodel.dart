import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = AuthService();

  Future runStartupLogic() async {
    if (await _authService.isUserLoggedIn()) {
      await _navigationService.replaceWithHomeView();
    }

    _navigationService.replaceWithLoginView();
  }
}
