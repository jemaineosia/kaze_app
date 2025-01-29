import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KazeAppbarModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void showTopupView() => _navigationService.navigateToCashinView();
}
