import 'dart:async';
import 'dart:convert';

import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/app_user.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppuserService {
  final _appUserTable = Supabase.instance.client.from('appusers');
  final LoggerService _loggerService = locator<LoggerService>();

  // In-memory cache can be added too, but here we focus on SharedPreferences
  // SharedPreferences caching methods

  Future<void> cacheUser(AppUser user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString('cached_user_${user.id}', userJson);
      _loggerService.info('User cached: ${user.id}');
    } catch (e) {
      _loggerService.error('Error caching user: ${user.id}', error: e);
    }
  }

  Future<AppUser?> getCachedUser(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('cached_user_$userId');
      if (userJson != null) {
        final Map<String, dynamic> data = jsonDecode(userJson);
        _loggerService.info('Returning cached user: $userId');
        return AppUser.fromJson(data);
      }
    } catch (e) {
      _loggerService.error('Error reading cached user: $userId', error: e);
      await clearCachedUser(userId);
    }
    return null;
  }

  Future<void> clearCachedUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_user_$userId');
    _loggerService.info('Cleared cache for user: $userId');
  }

  Future<AppUser?> refreshUser(String userId) async {
    // Clear the cached user first
    await clearCachedUser(userId);

    try {
      _loggerService.info('Refreshing user data for userId: $userId');
      final response = await _appUserTable.select().eq('id', userId).maybeSingle();

      if (response == null) {
        _loggerService.warning('No user found when refreshing user data for userId: $userId');
        return null;
      }

      if (!response.containsKey('id')) {
        _loggerService.error(
          'Unexpected response format when refreshing user data for userId: $userId. Response: $response',
        );
        return null;
      }

      final user = AppUser.fromJson(response);
      // Cache the updated user data
      await cacheUser(user);
      _loggerService.info('User data refreshed and cached for userId: $userId');
      return user;
    } catch (e, stackTrace) {
      _loggerService.error('Error refreshing user data for userId: $userId', error: e, stackTrace: stackTrace);
      return null;
    }
  }

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

      final user = AppUser.fromJson(response);
      // Cache the user for future use.
      await cacheUser(user);
      _loggerService.debug('User fetched successfully: $username');
      return user;
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching user by username: $username', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<String?> getUsernameByUserId(String userId) async {
    // Try getting the user from the cache first.
    final cachedUser = await getCachedUser(userId);
    if (cachedUser != null) {
      return cachedUser.username;
    }

    try {
      _loggerService.info('Fetching username by userId: $userId');

      final response = await _appUserTable.select().eq('id', userId).maybeSingle();

      if (response == null) {
        _loggerService.warning('No user found with userId: $userId');
        return null;
      }

      _loggerService.debug('User fetched successfully: $userId');

      final user = AppUser.fromJson(response);
      await cacheUser(user);
      return user.username;
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
    try {
      final response = await _appUserTable.select('on_hold_balance').eq('id', userId).maybeSingle();

      if (response == null || response['on_hold_balance'] == null) {
        _loggerService.warning('No on_hold_balance data found for userId: $userId');
        return 0.0;
      }

      final onHoldBalance = response['on_hold_balance'];
      if (onHoldBalance is num) {
        return onHoldBalance.toDouble();
      } else {
        _loggerService.error(
          'Unexpected on_hold_balance type for userId: $userId. Received: ${onHoldBalance.runtimeType}',
        );
        return 0.0;
      }
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching user on_hold_balance for userId: $userId', error: e, stackTrace: stackTrace);
      return 0.0;
    }
  }

  Future<Map<String, double>> getUserBalances(String userId) async {
    try {
      final response = await _appUserTable.select('balance, on_hold_balance').eq('id', userId).maybeSingle();

      if (response == null) {
        return {'balance': 0.0, 'on_hold_balance': 0.0};
      }

      final totalBalance = (response['balance'] as num).toDouble();
      final onHoldBalance = (response['on_hold_balance'] as num).toDouble();
      final availableBalance = totalBalance - onHoldBalance;

      return {'balance': totalBalance, 'on_hold_balance': onHoldBalance, 'available_balance': availableBalance};
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching user balances for userId: $userId', error: e, stackTrace: stackTrace);
      return {'balance': 0.0, 'on_hold_balance': 0.0, 'available_balance': 0.0};
    }
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
      _loggerService.error('Error fetching user ID by username: $username', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  StreamSubscription subscribeToUser(String userId, Function callback) {
    return _appUserTable.stream(primaryKey: ['id']).eq('id', userId).listen((data) {
      _loggerService.info("Realtime update on appusers: $data");
      callback();
    });
  }
}
