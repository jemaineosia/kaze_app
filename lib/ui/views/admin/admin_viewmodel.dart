import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/transaction_dto.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminViewModel extends BaseViewModel {
  final _transactionService = locator<TransactionService>();
  final _loggerService = locator<LoggerService>();
  final _dialogService = locator<DialogService>();

  List<TransactionDTO>? _pendingTransactions;
  List<TransactionDTO>? get getPendingTransactions => _pendingTransactions;

  // String getUsernameByUserId(String userId) {}

  /// Fetch pending transactions and update the state
  Future<void> fetchPendingTransactions() async {
    setBusy(true);

    try {
      final pendingTransactions =
          await _transactionService.getPendingTransactions();

      if (pendingTransactions.isEmpty) {
        _loggerService.info('No pending transactions found.');
      } else {
        _loggerService
            .info('${pendingTransactions.length} pending transactions loaded.');
      }

      // Update the list and notify listeners
      _pendingTransactions = pendingTransactions;
      notifyListeners();
    } catch (e, stackTrace) {
      _loggerService.error(
        'Failed to fetch pending transactions.',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> approveTransaction(String transactionId) async {
    setBusy(true);

    try {
      final success =
          await _transactionService.approveTransaction(transactionId);

      if (success) {
        _loggerService
            .info('Transaction $transactionId approved successfully.');

        await _dialogService.showDialog(
          title: 'Success',
          description: 'The transaction has been approved successfully.',
        );

        // Optionally refresh the pending transactions list
        await fetchPendingTransactions();
      } else {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to approve the transaction. Please try again.',
        );
      }
    } catch (e) {
      _loggerService.error(
        'Error approving transaction with ID: $transactionId',
        error: e,
      );

      await _dialogService.showDialog(
        title: 'Error',
        description: 'An unexpected error occurred. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }
}
