import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/common/enums/match_type.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/match.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class MatchViewModel extends FormViewModel {
  final _matchService = locator<MatchService>();
  final _authService = locator<AuthService>();
  final _appUserService = locator<AppuserService>();
  final _transactionService = locator<TransactionService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _loggerService = locator<LoggerService>();

  double currentBalance = 0.0;
  MatchType matchType = MatchType.openMatch;

  Future<void> initialize() async {
    final user = _authService.getCurrentUser();
    if (user != null) {
      final totalBalance = await _appUserService.getUserBalance(user.id);
      final onHoldBalance = await _appUserService.getUserOnHoldBalance(user.id);
      currentBalance = totalBalance - onHoldBalance;
      notifyListeners();
    }
  }

  void setMatchType(MatchType? type) {
    if (type != null) {
      matchType = type;
      notifyListeners();
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

    final requiredAmount = creatorBetAmount > opponentBetAmount ? creatorBetAmount : opponentBetAmount;

    if (currentBalance < requiredAmount) {
      await _dialogService.showDialog(title: 'Error', description: 'Insufficient balance to create match.');
      return;
    }

    setBusy(true);

    try {
      final match = Match(
        creatorId: user.id,
        opponentId: null,
        matchTitle: matchTitle,
        matchDescription: matchDescription,
        creatorBetAmount: creatorBetAmount,
        opponentBetAmount: opponentBetAmount,
        totalCreatorBetAmount: creatorBetAmount,
        totalOpponentBetAmount: opponentBetAmount,
        status: MatchStatus.pending,
      );

      final createdMatch = await _matchService.createMatch(match);

      if (createdMatch != null) {
        await _transactionService.createTransaction(
          Transaction(
            id: const Uuid().v4(),
            userId: user.id,
            matchId: createdMatch.id,
            amount: requiredAmount,
            transactionType: TransactionType.betHold,
          ),
        );

        await _dialogService.showDialog(title: 'Success', description: 'Match created successfully!');
        _navigationService.back(result: true);
      } else {
        await _dialogService.showDialog(title: 'Error', description: 'Failed to create match.');
      }
    } catch (e) {
      await _dialogService.showDialog(title: 'Error', description: 'Unexpected error occurred.');
    } finally {
      setBusy(false);
    }
  }
}
