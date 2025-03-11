import 'dart:async';

import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WalletViewModel extends BaseViewModel {
  final _appUserService = locator<AppuserService>();
  final _transactionService = locator<TransactionService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _loggerService = locator<LoggerService>();

  double currentBalance = 0.0;
  double pendingCashout = 0.0;
  double onHoldBalance = 0.0;
  double totalBalance = 0.0;
  List<Transaction> transactions = [];

  StreamSubscription? _userSubscription;
  StreamSubscription? _transactionSubscription;

  /// Fetch wallet data (balance & transactions)
  Future<void> fetchWalletData() async {
    setBusy(true);
    try {
      final user = _authService.getCurrentUser();
      if (user == null) {
        _loggerService.warning("No logged-in user found.");
        return;
      }

      _loggerService.info("Fetching wallet data for user: \${user.id}");

      // Fetch balances
      totalBalance = await _appUserService.getUserBalance(user.id);
      onHoldBalance = await _appUserService.getUserOnHoldBalance(user.id);

      // Fetch transactions (cash-in & cash-out only)
      transactions = await _transactionService.getUserTransactions(user.id);

      _loggerService.debug("Fetched Transactions: ${transactions.map((t) => t.toJson()).toList()}");

      // Filter cash_out_pending transactions
      pendingCashout = transactions
          .where((t) => t.transactionType == TransactionType.cashOutPending)
          .fold(0.0, (sum, t) => sum + t.amount);

      // Available balance should exclude pending cashout
      currentBalance = totalBalance - onHoldBalance - pendingCashout;

      _loggerService.debug("Wallet Data:");
      _loggerService.debug("Total Balance: $totalBalance");
      _loggerService.debug("Pending Cashout: $pendingCashout");
      _loggerService.debug("Cash On Hold: $onHoldBalance");
      _loggerService.debug("Current Balance: $currentBalance");

      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error("Error fetching wallet data.", error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }

  void subscribeToWalletData() {
    final user = _authService.getCurrentUser();
    if (user == null) return;

    // Subscribe to realtime updates on the user's record
    _userSubscription = _appUserService.subscribeToUser(user.id, fetchWalletData);

    // Subscribe to realtime updates on the user's transactions
    _transactionSubscription = _transactionService.subscribeToTransactions(user.id, fetchWalletData);
  }

  void navigateToCashIn() {
    _loggerService.info("Navigating to Cash In screen.");
    _navigationService.navigateTo(Routes.cashinView);
  }

  void navigateToCashOut() {
    _loggerService.info("Navigating to Cash Out screen.");
    _navigationService.navigateTo(Routes.cashoutView);
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _transactionSubscription?.cancel();
    super.dispose();
  }
}
