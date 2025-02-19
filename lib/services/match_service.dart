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

      _loggerService.debug(
        "Fetched Matches: ${matches.map((m) => m.toJson())}",
      );

      return matches;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching matches',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<Match?> createMatch(Match match) async {
    try {
      final response =
          await _matchesTable
              .insert(
                match.toJson()..remove('id'),
              ) // Remove ID because Supabase auto-generates
              .select()
              .single();

      final createdMatch = Match.fromJson(response);
      _loggerService.info('Match created: ${createdMatch.toJson()}');
      return createdMatch;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error creating match',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
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
      _loggerService.error(
        'Error updating match',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<bool> deleteMatch(String matchId) async {
    try {
      await _matchesTable.delete().eq('id', matchId);

      _loggerService.info('Match deleted successfully: $matchId');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error deleting match',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<List<Match>> fetchMatchesByCreator(String creatorId) async {
    try {
      final response = await _matchesTable
          .select()
          .eq('creator_id', creatorId)
          .order('created_at', ascending: false);

      return (response as List).map((data) => Match.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching matches by creator',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<List<Match>> fetchOpenMatches({required String currentUserId}) async {
    try {
      final response = await _matchesTable
          .select()
          .filter('opponent_id', 'is', null)
          .eq('invite_status', 'open')
          .neq('creator_id', currentUserId)
          .order('created_at', ascending: false);

      _loggerService.debug('Open Matches Response: $response');

      return (response as List).map((data) => Match.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching open matches',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<Match?> getMatchById(String matchId) async {
    try {
      final response =
          await _matchesTable.select().eq('id', matchId).maybeSingle();

      if (response != null) {
        return Match.fromJson(response);
      }
      return null;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching match by ID',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<bool> updateMatchInviteLink(String matchId, String inviteLink) async {
    try {
      await _matchesTable.update({'invite_link': inviteLink}).eq('id', matchId);

      _loggerService.info('Match invite link updated for match: $matchId');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error(
        'Failed to update match invite link',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
