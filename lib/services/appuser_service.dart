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

      final response = await _appUserTable.select('username').eq('username', username).limit(1).maybeSingle();

      final isTaken = response != null;
      _loggerService.debug(isTaken ? 'Username is taken: $username' : 'Username is available: $username');
      return isTaken;
    } catch (e, stackTrace) {
      _loggerService.error('Error checking if username is taken: $username', error: e, stackTrace: stackTrace);
      return false; // Fail gracefully
    }
  }

  Future<AppUser?> getUserByUsername(String username) async {
    try {
      _loggerService.info('Fetching user by username: $username');

      final response = await _appUserTable.select().eq('username', username).maybeSingle();

      if (response == null) {
        _loggerService.warning('No user found with username: $username');
        return null;
      }

      if (!response.containsKey('id') || !response.containsKey('username')) {
        _loggerService.error('Unexpected response format for user: $username. Response: $response');
        return null;
      }

      _loggerService.debug('User fetched successfully: $username');
      return AppUser.fromJson(response);
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching user by username: $username', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<String?> getUsernameByUserId(String userId) async {
    try {
      _loggerService.info('Fetching username by userId: $userId');

      final response = await _appUserTable.select().eq('id', userId).maybeSingle();

      if (response == null) {
        _loggerService.warning('No user found with userId: $userId');
        return null;
      }

      _loggerService.debug('User fetched successfully: $userId');

      return AppUser.fromJson(response).username;
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching username by userId: $userId', error: e, stackTrace: stackTrace);
      return null; // Return null if an error occurs
    }
  }

  Future<double> getUserBalance(String userId) async {
    try {
      final response = await _appUserTable.select('balance').eq('id', userId).maybeSingle();

      if (response == null || response['balance'] == null) {
        _loggerService.warning('No balance data found for userId: $userId');
        return 0.0;
      }

      final balance = response['balance'];
      if (balance is num) {
        return balance.toDouble();
      } else {
        _loggerService.error('Unexpected balance type for userId: $userId. Received: ${balance.runtimeType}');
        return 0.0;
      }
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching user balance for userId: $userId', error: e, stackTrace: stackTrace);
      return 0.0;
    }
  }

  Future<double> getUserOnHoldBalance(String userId) async {
    final response = await _appUserTable.select('on_hold_balance').eq('id', userId).maybeSingle();

    return response?['on_hold_balance']?.toDouble() ?? 0.0;
  }

  Future<Map<String, double>> getUserBalances(String userId) async {
    final response = await _appUserTable.select('balance, on_hold_balance').eq('id', userId).maybeSingle();

    if (response == null) {
      return {'balance': 0.0, 'on_hold_balance': 0.0};
    }

    final totalBalance = (response['balance'] as num).toDouble();
    final onHoldBalance = (response['on_hold_balance'] as num).toDouble();
    final availableBalance = totalBalance - onHoldBalance;

    return {'balance': totalBalance, 'on_hold_balance': onHoldBalance, 'available_balance': availableBalance};
  }

  Future<String?> getUserIdByUsername(String username) async {
    try {
      final response =
          await Supabase.instance.client.from('appusers').select('id').eq('username', username).maybeSingle();

      if (response == null) return null;

      if (!response.containsKey('id')) {
        _loggerService.error('Unexpected response format when fetching user ID for $username: $response');
        return null;
      }

      return response['id'] as String;
    } catch (e, stackTrace) {
      locator<LoggerService>().error('Error fetching user ID by username: $username', error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
