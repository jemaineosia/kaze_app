import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/models/profile_user.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/profile_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _profileService = locator<ProfileService>();

  SettingsViewModel() {
    runStartupLogic();
  }

  ProfileUser? _user;
  ProfileUser? get user => _user;

  void signOut() {
    _authService.signOut();
    _navigationService.replaceWithLoginView();
  }

  Future runStartupLogic() async {
    try {
      var currentUser = _authService.currentUser;
      if (currentUser != null) {
        _user = await _profileService.fetchUserProfile(currentUser.id);
        notifyListeners();
      } else {
        _navigationService.replaceWithLoginView();
      }
    } catch (e) {
      print('Error loading profile: $e');
    }
  }
}
