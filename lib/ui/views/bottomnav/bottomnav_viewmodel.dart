import 'package:kaze_app/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomnavViewModel extends IndexTrackingViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  void onTabTapped(int index) {
    setIndex(index); // Update the index with the tapped tab
  }
}
