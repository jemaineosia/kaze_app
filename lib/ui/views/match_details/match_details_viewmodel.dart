import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';

class MatchDetailsViewModel extends BaseViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();

  final String matchId;
  Match? match;

  MatchDetailsViewModel(this.matchId);

  String get currentUserId => _authService.getCurrentUser()?.id ?? '';

  bool get isCreator => match?.creatorId == currentUserId;

  bool get canEdit => match?.status == MatchStatus.pending && isCreator;

  bool get canCancel => match?.status == MatchStatus.accepted;

  bool get canDeclareWinner => match?.status == MatchStatus.accepted;

  Future<void> fetchMatch() async {
    setBusy(true);
    match = await _matchService.getMatchById(matchId);
    notifyListeners();
    setBusy(false);
  }

  Future<void> editMatch() async {
    // Navigate to edit match view
  }

  Future<void> cancelMatch() async {
    // Call service to cancel match
  }

  Future<void> declareWinner() async {
    // Show dialog to select winner (self/opponent)
  }
}
