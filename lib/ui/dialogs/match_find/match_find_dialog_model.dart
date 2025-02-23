import 'package:flutter/material.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MatchFindDialogModel extends BaseViewModel {
  final TextEditingController inviteCodeController = TextEditingController();
  final MatchService _matchService = locator<MatchService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LoggerService _loggerService = locator<LoggerService>();
  final DialogService _dialogService = locator<DialogService>();

  String? errorMessage;

  Future<void> findMatch(Function(DialogResponse) completer) async {
    errorMessage = null;
    notifyListeners();

    final inviteCode = inviteCodeController.text.trim();

    if (inviteCode.isEmpty) {
      errorMessage = "Please enter an invite code.";
      notifyListeners();
      return;
    }

    // Check if the invite code exists
    final match = await _matchService.fetchMatchByInviteCode(inviteCode);

    if (match != null) {
      // If found, close the dialog and navigate to match details
      completer(DialogResponse(confirmed: true));
      _navigationService.navigateTo(Routes.matchDetailsView, arguments: MatchDetailsViewArguments(matchId: match.id!));
    } else {
      // Otherwise, set error message
      errorMessage = "No match found with invite code \"$inviteCode\".";
      notifyListeners();
      // Optionally, show an error dialog:
      // await _dialogService.showDialog(title: "Error", description: errorMessage);
    }
  }

  @override
  void dispose() {
    inviteCodeController.dispose();
    super.dispose();
  }
}
