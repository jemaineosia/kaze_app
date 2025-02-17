import 'package:kaze_app/app/app.bottomsheets.dart';
import 'package:kaze_app/app/app.dialogs.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  String get counterLabel => 'Logout';

  String? _userEmail;
  String? get getUserEmail => _userEmail;

  Future<void> fetchUserEmail() async {
    _userEmail = _authService.getCurrentUserEmail();
    notifyListeners();
  }

  final int _counter = 0;

  void incrementCounter() {
    _authService.signOut();
    _navigationService.replaceWithLoginView();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
