import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/notification.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  final _notificationTable = Supabase.instance.client.from('notifications');
  final logger = locator<LoggerService>();

  Future<List<Notification>> fetchUserNotifications(String userId) async {
    try {
      final response = await Supabase.instance.client
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .eq('is_read', false)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Notification.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      locator<LoggerService>().error('Error fetching notifications for user $userId', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  void subscribeToNotifications(String userId) {
    final subscription = _notificationTable
        .stream(primaryKey: ['id']) // Specify the primary key for real-time streaming
        .eq('user_id', userId)
        .listen((List<Map<String, dynamic>> event) {
          try {
            for (var notification in event) {
              // Log and process each new notification
              logger.info('New Notification: ${notification['title']}');
            }
          } catch (e, stackTrace) {
            logger.error('Error processing real-time notifications.', error: e, stackTrace: stackTrace);
          }
        });

    logger.info('Subscribed to real-time notifications for user: $userId');

    // Optionally store the subscription to manage it later
  }

  Future<bool> addNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
  }) async {
    try {
      final response = await _notificationTable.insert({
        'user_id': userId,
        'title': title,
        'message': message,
        'type': type,
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (response.isEmpty) {
        throw Exception('Failed to add notification.');
      }

      return true;
    } catch (e, stackTrace) {
      locator<LoggerService>().error('Error adding notification for user $userId', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> markNotificationAsRead(String notificationId) async {
    try {
      final response =
          await _notificationTable
              .update({'is_read': true}) // Update `is_read` to true
              .eq('id', notificationId)
              .select();

      if (response.isEmpty) {
        throw Exception('Failed to update notification status.');
      }

      locator<LoggerService>().info('Notification $notificationId marked as read.');
      return true;
    } catch (e, stackTrace) {
      locator<LoggerService>().error(
        'Error marking notification as read: $notificationId',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
