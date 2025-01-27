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
      _loggerService.info(
          const JsonEncoder.withIndent('  ').convert(transaction.toJson()));

      final response = await _transactionTable.insert(transaction.toJson());

      if (response == null) {
        _loggerService
            .info('Transaction created successfully: ${transaction.id}');
        return true;
      }

      if (response.error != null) {
        _loggerService.error('Error occurred: ${response.error!.message}');
      }

      if (response.error == null) {
        _loggerService
            .info('Transaction created successfully: ${transaction.id}');
        return true;
      } else {
        _loggerService.error(
          'Failed to create transaction: ${response.error?.message}',
        );
        return false;
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        'Unexpected error occurred while creating transaction',
        error: e,
        stackTrace: stackTrace,
      );
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

  Future<bool> approveTransaction(String transactionId) async {
    locator<LoggerService>()
        .info('Approving transaction with ID: $transactionId');
    try {
      final response = await _transactionTable
          .update({
            'transaction_type': TransactionType.cashIn
                .toValue(), // Update the status to 'cash_in'
          })
          .eq('id', transactionId)
          .select();

      if (response.isEmpty) {
        locator<LoggerService>().error(
          'Transaction approval failed: No rows were updated for transaction ID: $transactionId',
        );
        throw Exception('Failed to update transaction.');
      }

      locator<LoggerService>()
          .info('Transaction approved successfully for ID: $transactionId');
      return true; // Successful update
    } catch (e, stackTrace) {
      locator<LoggerService>().error(
        'Error approving transaction with ID: $transactionId',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
