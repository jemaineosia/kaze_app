import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/common/enums/match_type.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';

class MatchViewModel extends FormViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _appUserService = locator<AppuserService>();
  final _loggerService = locator<LoggerService>();

  List<Match> matches = [];
  MatchType matchType = MatchType.openMatch;

  void setMatchType(MatchType? type) {
    if (type != null) {
      matchType = type;
      notifyListeners();
    }
  }

  Future<void> fetchMatches() async {
    setBusy(true);
    try {
      matches = await _matchService.fetchMatches();
      _loggerService.info('Fetched ${matches.length} matches');
      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching matches', error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }

  Future<void> createMatch(
    String matchTitle,
    String matchDescription,
    double creatorBetAmount,
    double opponentBetAmount,
    String? opponentUsername,
  ) async {
    final user = _authService.getCurrentUser();
    if (user == null) {
      _loggerService.warning('User not logged in');
      return;
    }

    String? opponentUserId;

    if (matchType == MatchType.inviteOpponent) {
      if (opponentUsername == null || opponentUsername.isEmpty) {
        setValidationMessage('Opponent username is required.');
        notifyListeners();
        return;
      }

      opponentUserId = await validateOpponentUsername(opponentUsername);

      if (opponentUserId == null) {
        setValidationMessage('Opponent username not found.');
        notifyListeners();
        return;
      }
    }

    setBusy(true);
    try {
      final newMatch = Match(
        creatorId: user.id,
        opponentId: matchType == MatchType.inviteOpponent ? opponentUserId : null,
        matchTitle: matchTitle,
        matchDescription: matchDescription,
        creatorBetAmount: creatorBetAmount,
        opponentBetAmount: opponentBetAmount,
        totalCreatorBetAmount: creatorBetAmount,
        totalOpponentBetAmount: opponentBetAmount,
        status: MatchStatus.pending,
      );

      final success = await _matchService.createMatch(newMatch);

      if (success) {
        _loggerService.info('Match created successfully!');
        await fetchMatches();
      }
    } catch (e, stackTrace) {
      _loggerService.error('Error creating match', error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }

  Future<String?> validateOpponentUsername(String username) async {
    final userId = await _appUserService.getUserIdByUsername(username);
    return userId;
  }
}
