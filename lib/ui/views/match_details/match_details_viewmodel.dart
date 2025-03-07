import 'dart:async';

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

  StreamSubscription<Match?>? _matchSubscription;
  String get currentUserId => _authService.getCurrentUser()?.id ?? '';

  bool get isCreator => match?.creatorId == currentUserId;
  bool get isNonCreator => match != null && match!.creatorId != currentUserId;

  /// Returns true if either cancellation flag is set.
  bool get cancellationRequested {
    if (match == null) return false;
    return match!.creatorCancelRequested || match!.opponentCancelRequested;
  }

  void subscribeToMatchUpdates() {
    _matchSubscription = _matchService.subscribeMatchById(matchId).listen((matchData) {
      if (matchData != null) {
        match = matchData;
        notifyListeners();
      }
    });
  }

  /// Returns true if the current user did not initiate the cancellation.
  bool get canRespondToCancellation {
    if (match == null) return false;
    // If creator requested cancellation and current user is not the creator.
    if (match!.creatorCancelRequested && !isCreator) return true;
    // If opponent requested cancellation and current user is not the opponent.
    if (match!.opponentCancelRequested && currentUserId != match!.opponentId) {
      return true;
    }
    return false;
  }

  // For non-creators: Accept button is shown if the match is pending and no opponent has been set.
  // If the match is pending and no opponent has joined, any non-creator can accept.
  bool get canAccept =>
      match?.status == MatchStatus.pending && match?.opponentId == null && isNonCreator && !cancellationRequested;

  // For cancellation:
  // - If pending: Only allow cancellation if no cancellation request is active, and only the creator can cancel.
  // - If ongoing: Allow cancellation only if no cancellation request is active.
  bool get canCancel {
    if (match == null) return false;
    if (cancellationRequested) {
      return false; // If a cancellation is pending, hide cancel actions.
    }

    if (match!.status == MatchStatus.pending) {
      // For pending matches, only the creator can cancel.
      return currentUserId == match!.creatorId;
    }
    if (match!.status == MatchStatus.ongoing) {
      // For ongoing matches, allow cancellation if the current user is either the creator or the opponent.
      return currentUserId == match!.creatorId || currentUserId == match!.opponentId;
    }
    return false;
  }

  // For declaring winner, only allow if match is ongoing and no cancellation request is pending.
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
    subscribeToMatchUpdates();
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

  Future<void> cancelMatch() async {
    // This method is used by the party initiating the cancellation.
    final confirmResponse = await _dialogService.showConfirmationDialog(
      title: 'Cancel Match',
      description: 'Do you want to request cancellation of this match? Both parties must agree to cancel.',
      confirmationTitle: 'Request Cancellation',
      cancelTitle: 'No',
    );

    if (confirmResponse?.confirmed == true) {
      final requestSuccess = await _matchService.requestMatchCancellation(matchId: match!.id!, userId: currentUserId);

      if (requestSuccess) {
        await fetchMatch();
        if (match!.creatorCancelRequested && match!.opponentCancelRequested) {
          // Both parties agreed—finalize cancellation.
          await _dialogService.showDialog(
            title: 'Match Canceled',
            description: 'Both parties have agreed to cancel the match. Funds will be released.',
          );
          _navigationService.back();
        } else {
          await _dialogService.showDialog(
            title: 'Cancellation Requested',
            description: 'Your cancellation request has been recorded. Waiting for the other party to respond.',
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

  /// This method is for the party that did not initiate the cancellation.
  /// [accept] is true if the user accepts the cancellation request; false if they reject it.
  Future<void> respondToCancellation({required bool accept}) async {
    final confirmResponse = await _dialogService.showConfirmationDialog(
      title: 'Respond to Cancellation',
      description: accept ? 'Do you accept cancellation of this match?' : 'Do you reject the cancellation request?',
      confirmationTitle: accept ? 'Accept Cancellation' : 'Reject Cancellation',
      cancelTitle: 'Cancel',
    );

    if (confirmResponse?.confirmed == true) {
      if (accept) {
        // Record the responding party's cancellation acceptance by calling requestMatchCancellation again.
        final requestSuccess = await _matchService.requestMatchCancellation(matchId: match!.id!, userId: currentUserId);

        if (requestSuccess) {
          // Refresh match data to update the cancellation flags.
          await fetchMatch();
          if (match!.creatorCancelRequested && match!.opponentCancelRequested) {
            // Both parties have now requested cancellation – finalize it.
            final cancelSuccess = await _matchService.cancelMatch(match!.id!);
            if (cancelSuccess) {
              await _dialogService.showDialog(
                title: 'Match Canceled',
                description:
                    'You have accepted the cancellation request. The match is canceled and funds will be refunded.',
              );
              await fetchMatch();
              _navigationService.back();
            } else {
              await _dialogService.showDialog(
                title: 'Error',
                description: 'Failed to cancel the match. Please try again.',
              );
            }
          } else {
            await _dialogService.showDialog(
              title: 'Cancellation Accepted',
              description: 'Your response has been recorded. Waiting for the other party to confirm cancellation.',
            );
          }
        } else {
          await _dialogService.showDialog(
            title: 'Error',
            description: 'Failed to record your cancellation acceptance. Please try again.',
          );
        }
      } else {
        // Reject cancellation: reset cancellation flags.
        final success = await _matchService.resetCancellationRequest(match!.id!);
        if (success) {
          await _dialogService.showDialog(
            title: 'Cancellation Rejected',
            description: 'You have rejected the cancellation request. The match will continue.',
          );
          await fetchMatch();
        } else {
          await _dialogService.showDialog(
            title: 'Error',
            description: 'Failed to reject the cancellation request. Please try again.',
          );
        }
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

  String getDisplayStatus(Match match, String currentUserId) {
    // If the match is canceled, display its canceled status.
    if (match.status == MatchStatus.canceled) {
      return match.status.toDisplay();
    }

    // For the creator, show "Cancellation Requested" only if the opponent requested cancellation.
    if (currentUserId == match.creatorId) {
      if (match.opponentCancelRequested == true) {
        return "Cancellation Requested";
      }
    } else {
      // For a non-creator, show it if the creator requested cancellation.
      if (match.creatorCancelRequested == true) {
        return "Cancellation Requested";
      }
    }

    // Otherwise, display the normal status.
    return match.status.toDisplay();
  }

  @override
  void dispose() {
    _matchSubscription?.cancel();
    super.dispose();
  }
}
