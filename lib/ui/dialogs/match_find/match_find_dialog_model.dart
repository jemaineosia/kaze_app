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

  String? errorMessage;

  Future<void> findMatch(Function(DialogResponse) completer) async {
    errorMessage = null;
    notifyListeners();

    final inviteCode = inviteCodeController.text.trim();
    _loggerService.info("findMatch: Invite code entered: '$inviteCode'");

    if (inviteCode.isEmpty) {
      errorMessage = "Please enter an invite code.";
      _loggerService.warning("findMatch: No invite code provided.");
      notifyListeners();
      return;
    }

    final match = await _matchService.fetchMatchByInviteCode(inviteCode);
    _loggerService.info(
      "findMatch: Result for invite code '$inviteCode': ${match != null ? match.toJson() : 'No match found'}",
    );

    if (match != null) {
      _loggerService.info(
        "findMatch: Match found. Navigating to match details for match id ${match.id}",
      );
      completer(DialogResponse(confirmed: true));
      _navigationService.navigateTo(
        Routes.matchDetailsView,
        arguments: MatchDetailsViewArguments(matchId: match.id!),
      );
    } else {
      errorMessage = "No open match found with invite code \"$inviteCode\".";
      _loggerService.error(
        "findMatch: No match found with invite code '$inviteCode'.",
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    inviteCodeController.dispose();
    super.dispose();
  }
}
