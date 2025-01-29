import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
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
  double onHoldBalance = 0.0;
  double totalBalance = 0.0;
  double availableBalance = 0.0;
  List<Transaction> transactions = [];

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
      currentBalance = await _appUserService.getUserBalance(user.id);
      onHoldBalance = await _appUserService.getUserOnHoldBalance(user.id);
      totalBalance = currentBalance + onHoldBalance;
      availableBalance = currentBalance;

      // Fetch transactions (cash-in & cash-out only)
      transactions = await _transactionService.getUserTransactions(user.id);

      _loggerService.info("Wallet data fetched successfully.");
      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error("Error fetching wallet data.",
          error: e, stackTrace: stackTrace);
    } finally {
      setBusy(false);
    }
  }

  /// Navigate to Top-Up page
  void navigateToTopUp() {
    _loggerService.info("Navigating to Top-Up screen.");
    _navigationService.navigateTo(Routes.topupView);
  }
}
