import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MatchDetailsViewModel extends BaseViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  final String matchId;
  Match? match;

  MatchDetailsViewModel(this.matchId);

  String get currentUserId => _authService.getCurrentUser()?.id ?? '';

  bool get isCreator => match?.creatorId == currentUserId;
  bool get isOpponent => match?.opponentId == currentUserId;

  bool get canAccept => match?.status == MatchStatus.pending && isOpponent;
  bool get canDecline => match?.status == MatchStatus.pending && isOpponent;

  bool get canCancel {
    if (match?.status == MatchStatus.pending && isCreator) {
      return true; // Creator can cancel immediately if opponent not accepted
    }
    if (match?.status == MatchStatus.ongoing) {
      return isCreator || isOpponent; // Both need to cancel
    }
    return false;
  }

  bool get canDeclareWinner =>
      match?.status == MatchStatus.ongoing && (isCreator || isOpponent);

  Future<void> fetchMatch() async {
    setBusy(true);
    match = await _matchService.getMatchById(matchId);
    notifyListeners();
    setBusy(false);
  }

  Future<void> acceptMatch() async {
    // Logic to accept match
  }

  Future<void> declineMatch() async {}

  Future<void> cancelMatch() async {
    final confirmResponse = await _dialogService.showConfirmationDialog(
      title: 'Cancel Match',
      description: 'Are you sure you want to cancel this match?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (confirmResponse?.confirmed == true) {
      // If pending, creator can cancel immediately
      if (match?.status == MatchStatus.pending && isCreator) {
        await _matchService.cancelMatch(match!.id!);
        await fetchMatch();
        _navigationService.back();
      }

      // If ongoing, both creator and opponent need to cancel
      if (match?.status == MatchStatus.ongoing) {
        // Call a function to register user's intent to cancel
        await _matchService.requestMatchCancellation(
          matchId: match!.id!,
          userId: currentUserId,
        );
        await fetchMatch();
      }
    }
  }

  Future<void> declareWinner() async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Declare Winner',
      description: 'Who won the match?',
      barrierDismissible: true,
      confirmationTitle: 'I Won',
      cancelTitle: 'Opponent Won',
    );

    String? winnerId;
    if (response?.confirmed == true) {
      winnerId = currentUserId; // User declared himself as winner
    } else if (response?.confirmed == false) {
      winnerId = isCreator ? match?.opponentId : match?.creatorId;
    }

    if (winnerId != null) {
      await _matchService.declareMatchWinner(match!.id!, winnerId);
      await fetchMatch();
    }
  }
}
