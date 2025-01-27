import 'package:logger/logger.dart';

class LoggerService {
  final Logger _logger;

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

  void debug(String message) => _logger.d(_addTimestamp(message));
  void info(String message) => _logger.i(_addTimestamp(message));
  void warning(String message) => _logger.w(_addTimestamp(message));
  void error(String message, {dynamic error, StackTrace? stackTrace}) =>
      _logger.e(_addTimestamp(message), error: error, stackTrace: stackTrace);

  // Helper function to add timestamps
  String _addTimestamp(String message) {
    final now = DateTime.now().toIso8601String();
    return "[$now] $message";
  }
}
