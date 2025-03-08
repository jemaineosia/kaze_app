import 'dart:async';

import 'package:kaze_app/app/app.dialogs.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@LazySingleton()
class HomeViewModel extends BaseViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _loggerService = locator<LoggerService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  List<Match> createdMatches = [];
  List<Match> invitedMatches = [];
  List<Match> matches = [];

  StreamSubscription<List<Match>>? _matchSubscription;

  void subscribeToMatches() {
    final user = _authService.getCurrentUser();
    if (user == null) return;

    // Subscribe to real-time updates
    _matchSubscription = _matchService.subscribeMatches().listen((matchList) {
      final user = _authService.getCurrentUser();
      if (user == null) return;

      createdMatches = matchList.where((m) => m.creatorId == user.id).toList();
      invitedMatches = matchList.where((m) => m.opponentId == user.id).toList();
      matches = [...createdMatches, ...invitedMatches];

      // Use the same sorting by schedule
      matches.sort((a, b) {
        if (a.schedule == null && b.schedule == null) return 0;
        if (a.schedule == null) return 1;
        if (b.schedule == null) return -1;
        return a.schedule!.compareTo(b.schedule!);
      });

      notifyListeners();
    });
  }

  void navigateToMatchDetails(Match match) {
    _loggerService.info('Navigating to Match Details: ${match.id}');
    _navigationService.navigateTo(
      Routes.matchDetailsView,
      arguments: MatchDetailsViewArguments(matchId: match.id!),
    );
  }

  Future<void> findMatch() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.matchFind,
      title: 'Enter Invite Code',
      description: 'Please enter the invite code for the match:',
      mainButtonTitle: 'OK',
      secondaryButtonTitle: 'Cancel',
      barrierDismissible: true,
    );
  }

  String getDisplayStatus(Match match) {
    if (match.status == MatchStatus.canceled) {
      return match.status.toDisplay();
    }
    if (match.creatorCancelRequested || match.opponentCancelRequested) {
      return 'Cancellation Requested';
    }
    return match.status.toDisplay();
  }

  @override
  void dispose() {
    _matchSubscription?.cancel();
    super.dispose();
  }
}
