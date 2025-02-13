import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/models/notification.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/notification_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _notificationService = locator<NotificationService>();
  final _loggerService = locator<LoggerService>();

  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;

  Future<void> fetchNotifications() async {
    setBusy(true);

    try {
      final user = _authService.getCurrentUser();
      if (user == null) {
        _loggerService.warning('No user logged in.');
        return;
      }

      _notifications = await _notificationService.fetchUserNotifications(
        user.id,
      );
      notifyListeners();
      _loggerService.info(
        'Fetched ${_notifications.length} notifications for user ${user.id}.',
      );
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching notifications.',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> handleNotificationTap(String notificationId) async {
    final success = await _notificationService.markNotificationAsRead(
      notificationId,
    );

    if (success) {
      _loggerService.info('Notification $notificationId handled successfully.');
      // Refresh the notifications list
      await fetchNotifications();
      notifyListeners();
    } else {
      _loggerService.warning('Failed to handle notification $notificationId.');
    }
  }

  void signOut() async {
    await _authService.signOut();
    _navigationService.navigateTo(Routes.loginView);
  }

  void navigateToAdmin() async {
    await _navigationService.navigateTo(Routes.adminView);
  }
}
