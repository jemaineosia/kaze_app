import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class MatchViewModel extends FormViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _loggerService = locator<LoggerService>();

  List<Match> matches = [];

  Future<void> fetchMatches() async {
    setBusy(true);
    try {
      matches = await _matchService.fetchMatches();

      _loggerService.info('Fetched ${matches.length} matches');
      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error fetching matches',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> createMatch(
    String matchTitle,
    String matchDescription,
    double creatorBetAmount,
    double opponentBetAmount,
  ) async {
    final user = _authService.getCurrentUser();
    if (user == null) {
      _loggerService.warning('User not logged in');
      return;
    }

    setBusy(true);
    try {
      final newMatch = Match(
        id: const Uuid().v4(),
        creatorId: user.id,
        opponentId: null, // Fill later
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
      _loggerService.error(
        'Error creating match',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }
}
