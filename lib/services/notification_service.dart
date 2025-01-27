import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/notification.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  final _notificationTable = Supabase.instance.client.from('notifications');
  final logger = locator<LoggerService>();

  Future<List<Notification>> fetchUserNotifications(String userId) async {
    final response = await _notificationTable
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Notification.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  void subscribeToNotifications(String userId) {
    final subscription = _notificationTable
        .stream(primaryKey: [
          'id'
        ]) // Specify the primary key for real-time streaming
        .eq('user_id', userId)
        .listen((List<Map<String, dynamic>> event) {
          try {
            for (var notification in event) {
              // Log and process each new notification
              logger.info('New Notification: ${notification['title']}');
            }
          } catch (e, stackTrace) {
            logger.error(
              'Error processing real-time notifications.',
              error: e,
              stackTrace: stackTrace,
            );
          }
        });

    logger.info('Subscribed to real-time notifications for user: $userId');

    // Optionally store the subscription to manage it later
  }
}
