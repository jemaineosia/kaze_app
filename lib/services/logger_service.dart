import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoggerService {
  final Logger _logger;
  final _supabase = Supabase.instance.client;

  LoggerService()
    : _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 2, // Number of stack trace lines for non-error logs
          errorMethodCount: 8, // Number of stack trace lines for error logs
          lineLength: 100, // Max width of output
          colors: true, // Use colors for log messages
          printEmojis: true, // Add emojis to log messages
        ),
      );

  void debug(String message) => _logger.d(_addTimestamp(_addUserInfo(message)));
  void info(String message) => _logger.i(_addTimestamp(_addUserInfo(message)));
  void warning(String message) =>
      _logger.w(_addTimestamp(_addUserInfo(message)));

  void error(String message, {dynamic error, StackTrace? stackTrace}) {
    final logMessage = _addTimestamp(_addUserInfo(message));

    // Log the error locally
    _logger.e(logMessage, error: error, stackTrace: stackTrace);

    // Save the error log to Supabase
    _saveErrorLogToSupabase(
      logMessage,
      error: error?.toString(),
      stackTrace: stackTrace?.toString(),
    );
  }

  // Helper function to add timestamps
  String _addTimestamp(String message) {
    final now = DateTime.now().toIso8601String();
    return "[$now] $message";
  }

  // Helper function to add user info to the log message
  String _addUserInfo(String message) {
    final user = _supabase.auth.currentUser;
    final username = user?.userMetadata?['username'] ?? 'Unknown User';
    return "User: $username - $message";
  }

  Future<void> _saveErrorLogToSupabase(
    String message, {
    String? error,
    String? stackTrace,
  }) async {
    try {
      await _supabase.from('logs').insert({
        'log_level': 'error',
        'message': message,
        'error_details': error,
        'stack_trace': stackTrace,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e, stack) {
      // If saving to Supabase fails, log the error locally
      _logger.e(
        'Failed to save error log to Supabase',
        error: e,
        stackTrace: stack,
      );
    }
  }
}
