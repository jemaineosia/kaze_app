import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MatchService {
  final LoggerService _loggerService = locator<LoggerService>();
  final _matchesTable = Supabase.instance.client.from('matches');

  Future<List<Match>> fetchMatches() async {
    try {
      final response = await _matchesTable.select();

      final matches = response.map((json) => Match.fromJson(json)).toList();

      _loggerService.debug("Fetched Matches: ${matches.map((m) => m.toJson())}");

      return matches;
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching matches', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  Future<bool> createMatch(Match match) async {
    try {
      await _matchesTable.insert(match.toJson());

      _loggerService.info('Match created successfully: ${match.toJson()}');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error('Error creating match', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> updateMatch(Match match) async {
    if (match.id == null) {
      _loggerService.error('Cannot update match: id is null.');
      return false;
    }

    try {
      await _matchesTable.update(match.toJson()).eq('id', match.id!);

      _loggerService.info('Match updated successfully: ${match.toJson()}');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error('Error updating match', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> deleteMatch(String matchId) async {
    try {
      await _matchesTable.delete().eq('id', matchId);

      _loggerService.info('Match deleted successfully: $matchId');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error('Error deleting match', error: e, stackTrace: stackTrace);
      return false;
    }
  }
}
