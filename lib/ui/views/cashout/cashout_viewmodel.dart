import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/common/enums/cashout_method.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class CashoutViewModel extends FormViewModel {
  final _appUserService = locator<AppuserService>();
  final _authService = locator<AuthService>();
  final _loggerService = locator<LoggerService>();
  final _navigationService = locator<NavigationService>();
  final _transactionService = locator<TransactionService>();

  List<CashOutMethod> paymentModes = CashOutMethod.values; // Use enum directly
  CashOutMethod? selectedPaymentMode;
  double currentBalance = 0.0;

  CashoutViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    setBusy(true);
    try {
      // Get the logged-in user's ID
      final user = _authService.getCurrentUser();
      if (user != null) {
        currentBalance = await _appUserService.getUserBalance(user.id);
      } else {
        _loggerService.warning("No logged-in user found.");
        _navigationService.navigateTo(Routes.loginView);
        return;
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        "Error initializing CashoutViewModel",
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  void setSelectedPaymentMode(CashOutMethod? mode) {
    selectedPaymentMode = mode;
    notifyListeners();
  }

  void submit(
    String? bankName,
    String fullName,
    String accountNumber,
    double amount,
    CashOutMethod cashOutMethod,
  ) async {
    final user = _authService.getCurrentUser();
    if (user == null) {
      _loggerService.warning("No logged-in user found.");
      _navigationService.navigateTo(Routes.loginView);
      return;
    }

    if (amount <= 0) {
      setValidationMessage('Please enter a valid amount.');
      notifyListeners();
      return;
    }

    if (amount > currentBalance) {
      setValidationMessage('Requested amount exceeds current balance.');
      notifyListeners();
      return;
    }

    try {
      setBusy(true);
      Transaction newTransaction = Transaction(
        id: const Uuid().v4(),
        userId: user.id,
        transactionType: TransactionType.cashOutPending,
        amount: amount,
        fullName: fullName,
        bankName: bankName,
        accountNumber: accountNumber,
        cashOutMethod: cashOutMethod,
        referenceNote: "Cash-out via ${cashOutMethod.toValue()}",
      );

      await _transactionService.createTransaction(newTransaction);
      _loggerService.info(
        "Cashout request submitted for $selectedPaymentMode.",
      );
      _navigationService.back();
    } catch (e, stackTrace) {
      _loggerService.error(
        "Error submitting cashout request",
        error: e,
        stackTrace: stackTrace,
      );
      setValidationMessage(
        'Failed to submit cashout request. Please try again.',
      );
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}
