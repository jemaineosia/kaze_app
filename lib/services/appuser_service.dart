import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/app_user.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppuserService {
  final _appUserTable = Supabase.instance.client.from('appusers');

  // LoggerService instance
  final LoggerService _loggerService = locator<LoggerService>();

  Future<bool> isUsernameTaken(String username) async {
    try {
      _loggerService.info('Checking if username is taken: $username');

      final response = await _appUserTable
          .select('username')
          .eq('username', username)
          .limit(1)
          .maybeSingle();

      final isTaken = response != null;
      _loggerService.debug(isTaken
          ? 'Username is taken: $username'
          : 'Username is available: $username');
      return isTaken;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error checking if username is taken: $username',
        error: e,
        stackTrace: stackTrace,
      );
      return false; // Fail gracefully
    }
  }

  Future<AppUser?> getUserByUsername(String username) async {
    try {
      _loggerService.info('Fetching user by username: $username');

      final response =
          await _appUserTable.select().eq('username', username).maybeSingle();

      if (response == null) {
        _loggerService.warning('No user found with username: $username');
        return null;
      }

      _loggerService.debug('User fetched successfully: $username');
      return AppUser.fromJson(response);
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching user by username: $username',
        error: e,
        stackTrace: stackTrace,
      );
      return null; // Return null if an error occurs
    }
  }
}
