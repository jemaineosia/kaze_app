import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _loggerService = locator<LoggerService>();
  final _navigationService = locator<NavigationService>();

  List<Match> createdMatches = [];
  List<Match> openMatches = [];
  List<Match> matches = [];

  Future<void> fetchHomeMatches() async {
    setBusy(true);
    try {
      final user = _authService.getCurrentUser();
      if (user == null) {
        _loggerService.warning('No logged-in user.');
        return;
      }

      createdMatches = await _matchService.fetchMatchesByCreator(user.id);
      openMatches = await _matchService.fetchOpenMatches(currentUserId: user.id);

      // Combine both lists
      matches = [...createdMatches, ...openMatches];

      // Sort by schedule date
      matches.sort((a, b) {
        if (a.schedule == null && b.schedule == null) return 0;
        if (a.schedule == null) return 1; // a is null, so sort after b
        if (b.schedule == null) return -1; // b is null, so sort after a
        return a.schedule!.compareTo(b.schedule!);
      });

      _loggerService.debug('Fetched Matches - Total: ${matches.length}');

      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error('Error fetching home matches', error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }

  void navigateToMatchDetails(Match match) {
    _loggerService.info('Navigating to Match Details: ${match.id}');
    _navigationService.navigateTo(Routes.matchDetailsView, arguments: MatchDetailsViewArguments(matchId: match.id!));
  }
}
