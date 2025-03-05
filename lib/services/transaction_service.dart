import 'dart:async';
import 'dart:convert';

import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/models/transaction_dto.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  final _transactionTable = Supabase.instance.client.from('transactions');
  final LoggerService _loggerService = locator<LoggerService>();

  Future<bool> createTransaction(Transaction transaction) async {
    try {
      _loggerService.info(const JsonEncoder.withIndent('  ').convert(transaction.toJson()));

      final response = await _transactionTable.insert(transaction.toJson()).select().maybeSingle();

      // If response is null, assume success.
      if (response == null) {
        _loggerService.info('Transaction created successfully: ${transaction.id}');
        return true;
      }

      // Check if the response has an error property.
      // Note: The response is expected to be of type PostgrestResponse,
      // which contains an 'error' property.
      if (response.containsKey('error') && response['error'] != null) {
        _loggerService.error('Error occurred: ${response['error']}');
        return false;
      }

      _loggerService.info('Transaction created successfully: ${transaction.id}');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error('Unexpected error occurred while creating transaction', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<List<TransactionDTO>> getPendingTransactions() async {
    try {
      final response = await _transactionTable
          .select('*, appusers!fk_transactions_user_id(username)')
          .eq('transaction_type', TransactionType.cashInPending.toValue());

      final List<dynamic> data = response as List<dynamic>;

      _loggerService.info('DATA:$data');

      return data.map((json) => TransactionDTO.fromJson(json)).toList();
    } catch (e, stackTrace) {
      locator<LoggerService>().error(
        'Unexpected error while loading cash_in_pending transactions.',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<bool> updateTransaction({
    required String transactionId,
    required TransactionType transactionType,
    DateTime? processedAt,
    String? processedByAdminId,
  }) async {
    try {
      final response =
          await _transactionTable
              .update({
                'transaction_type': transactionType.toValue(),
                'processed_at': processedAt?.toIso8601String(),
                'processed_by_admin_id': processedByAdminId,
              })
              .eq('id', transactionId)
              .select();

      if (response.isEmpty) {
        _loggerService.error('Transaction update failed. ID: $transactionId');
        return false;
      }

      _loggerService.info('Transaction $transactionId updated successfully.');
      return true;
    } catch (e, stackTrace) {
      _loggerService.error('Error updating transaction $transactionId', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<Transaction?> approveTransaction(String transactionId) async {
    locator<LoggerService>().info('Approving transaction with ID: $transactionId');
    try {
      final response =
          await _transactionTable
              .update({
                'transaction_type': TransactionType.cashIn.toValue(), // Update the status to 'cash_in'
              })
              .eq('id', transactionId)
              .select()
              .maybeSingle();

      if (response == null) {
        locator<LoggerService>().error(
          'Transaction approval failed: No rows were updated for transaction ID: $transactionId',
        );
        throw Exception('Failed to update transaction.');
      }

      final transaction = Transaction.fromJson(response);
      locator<LoggerService>().info(
        'Transaction approved successfully: ${transaction.id}, amount: ${transaction.amount}',
      );

      return transaction; // Return the updated transaction object
    } catch (e, stackTrace) {
      locator<LoggerService>().error(
        'Error approving transaction with ID: $transactionId',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<Transaction?> getTransactionById(String transactionId) async {
    try {
      final response =
          await Supabase.instance.client.from('transactions').select().eq('id', transactionId).maybeSingle();

      if (response == null) return null;

      return Transaction.fromJson(response);
    } catch (e, stackTrace) {
      locator<LoggerService>().error(
        'Error fetching transaction with ID: $transactionId',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<List<Transaction>> getUserTransactions(String userId) async {
    final response = await _transactionTable
        .select()
        .eq('user_id', userId)
        .or("transaction_type.eq.cash_in, transaction_type.eq.cash_out, transaction_type.eq.cash_out_pending")
        .order('created_at', ascending: false);

    return (response as List).map((json) => Transaction.fromJson(json)).toList();
  }

  StreamSubscription subscribeToTransactions(String userId, Function callback) {
    return _transactionTable.stream(primaryKey: ['id']).eq('user_id', userId).listen((data) {
      _loggerService.info("Realtime update on transactions: $data");
      callback();
    });
  }
}
