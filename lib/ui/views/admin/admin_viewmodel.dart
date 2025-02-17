import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/models/transaction_dto.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/notification_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AdminViewModel extends BaseViewModel {
  final _transactionService = locator<TransactionService>();
  final _loggerService = locator<LoggerService>();
  final _dialogService = locator<DialogService>();
  final _notificationService = locator<NotificationService>();

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
        _loggerService.info(
          '${pendingTransactions.length} pending transactions loaded.',
        );
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
      // Step 1: Approve the transaction
      final transaction = await _transactionService.approveTransaction(
        transactionId,
      );

      if (transaction != null) {
        _loggerService.info(
          'Transaction $transactionId approved successfully.',
        );

        // Step 3: Add a notification for the user
        final notificationSuccess = await _notificationService.addNotification(
          userId: transaction.userId,
          title: 'Payment Approved',
          message: 'Your payment of ${transaction.amount} has been approved.',
          type: 'payment',
        );

        if (notificationSuccess) {
          _loggerService.info(
            'Notification added for user: ${transaction.userId}',
          );
        } else {
          _loggerService.warning(
            'Failed to add notification for user: ${transaction.userId}',
          );
        }

        // Step 4: Show success dialog
        await _dialogService.showDialog(
          title: 'Success',
          description: 'The transaction has been approved successfully.',
        );

        // Step 5: Refresh the pending transactions list
        await fetchPendingTransactions();
      } else {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to approve the transaction. Please try again.',
        );
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error approving transaction with ID: $transactionId',
        error: e,
        stackTrace: stackTrace,
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
