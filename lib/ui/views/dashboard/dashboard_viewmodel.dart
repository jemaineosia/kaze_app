import 'package:kaze_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  void navigateToBet() {
    _navigationService.navigateToBetsView();
  }
}
