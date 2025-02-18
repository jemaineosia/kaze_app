import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _loggerService = locator<LoggerService>();

  List<Match> createdMatches = [];
  List<Match> openMatches = [];

  Future<void> fetchHomeMatches() async {
    setBusy(true);
    try {
      final user = _authService.getCurrentUser();
      if (user == null) {
        _loggerService.warning('User not logged in');
        return;
      }

      final createdMatchesResult = await _matchService.fetchMatchesByCreator(user.id);
      final openMatchesResult = await _matchService.fetchOpenMatches();

      createdMatches = createdMatchesResult;
      openMatches = openMatchesResult.where((match) => match.creatorId != user.id).toList();

      _loggerService.info('Fetched ${createdMatches.length} created matches, ${openMatches.length} open matches');

      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching home matches', error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }
}
