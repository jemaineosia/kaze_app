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
  bool get isNonCreator => match != null && match!.creatorId != currentUserId;

  // For non-creators: Accept button is shown if the match is pending and no opponent has been set.
  bool get canAccept => match?.status == MatchStatus.pending && match?.opponentId == null && isNonCreator;

  // For cancellation, the flow is:
  // - For pending matches, only the creator can cancel.
  // - For ongoing matches, both the creator and the opponent can cancel.
  bool get canCancel {
    if (match == null) return false;
    if (match!.status == MatchStatus.pending && isCreator) {
      return true;
    }
    if (match!.status == MatchStatus.ongoing) {
      return isCreator || (match!.opponentId != null && currentUserId == match!.opponentId);
    }
    return false;
  }

  // For declaring the winner, allow only when the match is ongoing and the current user is either the creator or the opponent.
  bool get canDeclareWinner {
    if (match == null) return false;
    return match!.status == MatchStatus.ongoing &&
        (isCreator || (match!.opponentId != null && currentUserId == match!.opponentId));
  }

  Future<void> fetchMatch() async {
    setBusy(true);
    match = await _matchService.getMatchById(matchId);
    notifyListeners();
    setBusy(false);
  }

  Future<void> acceptMatch() async {
    setBusy(true);
    final success = await _matchService.acceptMatch(match!.id!, currentUserId);
    if (success) {
      await fetchMatch();
    } else {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to accept match. It may have already been accepted.',
      );
    }
    setBusy(false);
  }

  Future<void> declineMatch() async {}

  Future<void> cancelMatch() async {
    final confirmResponse = await _dialogService.showConfirmationDialog(
      title: 'Cancel Match',
      description: 'Do you want to request cancellation of this match? Both parties must agree to cancel the match.',
      confirmationTitle: 'Request Cancellation',
      cancelTitle: 'No',
    );

    if (confirmResponse?.confirmed == true) {
      bool requestSuccess = await _matchService.requestMatchCancellation(matchId: match!.id!, userId: currentUserId);

      if (requestSuccess) {
        // Refresh the match details to reflect updated cancellation status
        await fetchMatch();
        if (match!.creatorCancelRequested == true && match!.opponentCancelRequested == true) {
          // Both parties have agreed, match is canceled.
          await _dialogService.showDialog(
            title: 'Match Canceled',
            description: 'Both parties have agreed to cancel the match. Funds will be refunded shortly.',
          );
          _navigationService.back();
        } else {
          await _dialogService.showDialog(
            title: 'Cancellation Requested',
            description:
                'Your cancellation request has been recorded. Waiting for the other party to confirm cancellation.',
          );
        }
      } else {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to record your cancellation request. Please try again.',
        );
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
      winnerId = currentUserId;
    } else if (response?.confirmed == false) {
      winnerId = isCreator ? match?.opponentId : match?.creatorId;
    }

    if (winnerId != null) {
      await _matchService.declareMatchWinner(match!.id!, winnerId);
      await fetchMatch();
    }
  }
}
