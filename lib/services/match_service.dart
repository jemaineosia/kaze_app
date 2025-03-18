import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/models/operation_result.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class MatchService {
  final _loggerService = locator<LoggerService>();
  final _transactionService = locator<TransactionService>();
  final _appUserService = locator<AppuserService>();
  final _matchesTable = Supabase.instance.client.from('matches');
  final _dialogService = locator<DialogService>();

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

  Future<Match?> createMatch(Match match) async {
    try {
      final response = await _matchesTable.insert(match.toJson()..remove('id')).select().single();

      final createdMatch = Match.fromJson(response);
      _loggerService.info('Match created: ${createdMatch.toJson()}');
      return createdMatch;
    } catch (e, stackTrace) {
      _loggerService.error('Error creating match', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<OperationResult> updateMatch(Match match) async {
    if (match.id == null) {
      _loggerService.error('Cannot update match: id is null.');
      return OperationResult(success: false, errorMessage: 'Match id is null.');
    }

    try {
      await _matchesTable.update(match.toJson()).eq('id', match.id!);
      _loggerService.info('Match updated successfully: ${match.toJson()}');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error updating match', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Error updating match.');
    }
  }

  Future<OperationResult> deleteMatch(String matchId) async {
    try {
      await _matchesTable.delete().eq('id', matchId);
      _loggerService.info('Match deleted successfully: $matchId');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error deleting match', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Error deleting match.');
    }
  }

  Future<List<Match>> fetchMatchesByCreator(String creatorId) async {
    try {
      final response = await _matchesTable.select().eq('creator_id', creatorId).order('created_at', ascending: false);

      return (response as List).map((data) => Match.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching matches by creator', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  Future<List<Match>> fetchInvitedMatches({required String currentUserId}) async {
    try {
      final response = await _matchesTable
          .select()
          .eq('opponent_id', currentUserId)
          .order('created_at', ascending: false);

      _loggerService.debug('Invited Matches Response: $response');

      return (response as List).map((data) => Match.fromJson(data)).toList();
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching invited matches', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  Future<Match?> getMatchById(String matchId) async {
    try {
      final response = await _matchesTable.select().eq('id', matchId).maybeSingle();

      if (response != null) {
        return Match.fromJson(response);
      }
      return null;
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching match by ID', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<OperationResult> updateMatchInviteLink(String matchId, String inviteLink) async {
    try {
      await _matchesTable.update({'invite_link': inviteLink}).eq('id', matchId);
      _loggerService.info('Match invite link updated for match: $matchId');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Failed to update match invite link', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Failed to update match invite link.');
    }
  }

  Future<OperationResult> cancelMatch(String matchId, String currentUserId) async {
    try {
      final match = await getMatchById(matchId);
      if (match == null) {
        _loggerService.warning('Match not found: $matchId');
        return OperationResult(success: false, errorMessage: 'Match not found. Please try again later.');
      }
      Map<String, dynamic> updateData = {'status': MatchStatus.canceled.toValue()};
      if (currentUserId == match.creatorId) {
        updateData['creator_updated_at'] = DateTime.now().toIso8601String();
      } else if (currentUserId == match.opponentId) {
        updateData['opponent_updated_at'] = DateTime.now().toIso8601String();
      }
      await _matchesTable.update(updateData).eq('id', matchId);
      _loggerService.info('Match $matchId canceled successfully.');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error canceling match $matchId', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Error canceling match.');
    }
  }

  Future<Match?> fetchMatchByInviteCode(String inviteCode) async {
    try {
      final response =
          await _matchesTable
              .select()
              .eq('invite_code', inviteCode)
              .eq('status', MatchStatus.pending.toValue())
              .maybeSingle();
      if (response != null) {
        return Match.fromJson(response);
      }
      return null;
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching match by invite code', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Stream<List<Match>> subscribeMatches() {
    // The primaryKey should match your table's primary key column(s)
    return _matchesTable.stream(primaryKey: ['id']).map<List<Match>>((data) {
      return (data as List).map((json) => Match.fromJson(json)).toList();
    });
  }

  Stream<Match?> subscribeMatchById(String matchId) {
    return _matchesTable.stream(primaryKey: ['id']).eq('id', matchId).map((data) {
      if (data.isNotEmpty) {
        return Match.fromJson(data.first);
      }
      return null;
    });
  }

  Future<void> declareMatchWinner(String matchId, String winnerId) async {
    await _matchesTable.update({'winner_id': winnerId, 'status': MatchStatus.completed.toValue()}).eq('id', matchId);
  }

  Future<OperationResult> acceptMatch(String matchId, String currentUserId) async {
    try {
      final match = await getMatchById(matchId);
      if (match == null) {
        _loggerService.warning('Match not found: $matchId');
        return OperationResult(success: false, errorMessage: 'Match not found. Please try again later.');
      }

      final requiredAmount =
          match.creatorBetAmount > match.opponentBetAmount ? match.creatorBetAmount : match.opponentBetAmount;

      final balances = await _appUserService.getUserBalances(currentUserId);
      final availableBalance = balances['available_balance'] ?? 0.0;
      if (availableBalance < requiredAmount) {
        _loggerService.warning(
          'Insufficient funds for user $currentUserId. Required: $requiredAmount, available: $availableBalance',
        );
        return OperationResult(
          success: false,
          errorMessage:
              'You do not have enough funds to accept this match. Required: P$requiredAmount, available: P$availableBalance',
        );
      }

      final transactionCreated = await _transactionService.createTransaction(
        Transaction(
          id: const Uuid().v4(),
          userId: currentUserId,
          matchId: matchId,
          amount: requiredAmount,
          transactionType: TransactionType.betHold,
        ),
      );

      if (!transactionCreated) {
        _loggerService.error('Failed to create bet hold transaction for user $currentUserId.');
        return OperationResult(success: false, errorMessage: 'Failed to create bet hold transaction.');
      }

      final response =
          await _matchesTable
              .update({
                'opponent_id': currentUserId,
                'status': MatchStatus.ongoing.toValue(),
                'opponent_updated_at': DateTime.now().toIso8601String(),
              })
              .eq('id', matchId)
              .isFilter('opponent_id', null)
              .eq('status', MatchStatus.pending.toValue())
              .select()
              .maybeSingle();

      if (response == null) {
        _loggerService.warning('Match $matchId could not be accepted (possibly already taken).');
        return OperationResult(
          success: false,
          errorMessage: 'Match could not be accepted. It may have already been taken.',
        );
      }

      _loggerService.info('Match $matchId accepted by user $currentUserId.');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error accepting match $matchId', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'An unexpected error occurred while accepting the match.');
    }
  }

  Future<OperationResult> requestMatchCancellation({required String matchId, required String userId}) async {
    try {
      final match = await getMatchById(matchId);
      if (match == null) {
        _loggerService.warning('Match not found: $matchId');
        return OperationResult(success: false, errorMessage: 'Match not found.');
      }
      Map<String, dynamic> updateData = {};
      if (match.creatorId == userId) {
        updateData['creator_cancel_requested'] = true;
        updateData['creator_updated_at'] = DateTime.now().toIso8601String();
      } else if (match.opponentId == userId) {
        updateData['opponent_cancel_requested'] = true;
        updateData['opponent_updated_at'] = DateTime.now().toIso8601String();
      }
      final response = await _matchesTable.update(updateData).eq('id', matchId).select().maybeSingle();
      if (response == null) {
        return OperationResult(success: false, errorMessage: 'Failed to record cancellation request.');
      }
      final updatedMatch = Match.fromJson(response);
      if (updatedMatch.creatorCancelRequested && updatedMatch.opponentCancelRequested) {
        // Both parties have agreed, so update the match status to canceled.
        Map<String, dynamic> finalUpdate = {'status': MatchStatus.canceled.toValue()};
        if (userId == match.creatorId) {
          finalUpdate['creator_updated_at'] = DateTime.now().toIso8601String();
        } else if (userId == match.opponentId) {
          finalUpdate['opponent_updated_at'] = DateTime.now().toIso8601String();
        }
        final cancelRes = await _matchesTable.update(finalUpdate).eq('id', matchId).select().maybeSingle();
        if (cancelRes == null) {
          final finalMatch = await getMatchById(matchId);
          if (finalMatch == null || finalMatch.status != MatchStatus.canceled) {
            return OperationResult(success: false, errorMessage: 'Error finalizing cancellation.');
          }
        }
        // Process refund transactions:
        final refundCreator = await _transactionService.updateBetHoldToBetRelease(
          matchId,
          updatedMatch.creatorId,
          updatedMatch.creatorBetAmount,
        );
        if (updatedMatch.opponentId != null) {
          final refundOpponent = await _transactionService.updateBetHoldToBetRelease(
            matchId,
            updatedMatch.opponentId!,
            updatedMatch.opponentBetAmount,
          );
          if (!refundCreator || !refundOpponent) {
            return OperationResult(success: false, errorMessage: 'Error processing refund transactions.');
          }
        } else if (!refundCreator) {
          return OperationResult(success: false, errorMessage: 'Error processing refund for creator.');
        }
      }
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error requesting match cancellation for $matchId', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Error requesting match cancellation.');
    }
  }

  Future<OperationResult> resetCancellationRequest(String matchId) async {
    try {
      await _matchesTable
          .update({
            'creator_cancel_requested': false,
            'opponent_cancel_requested': false,
            'creator_updated_at': DateTime.now().toIso8601String(),
            'opponent_updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', matchId);
      _loggerService.info('Cancellation request reset for match: $matchId');
      return OperationResult(success: true);
    } catch (e, stackTrace) {
      _loggerService.error('Error resetting cancellation request for $matchId', error: e, stackTrace: stackTrace);
      return OperationResult(success: false, errorMessage: 'Error resetting cancellation request.');
    }
  }
}
