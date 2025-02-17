import 'package:kaze_app/common/enums/cashout_method.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';

class Transaction {
  final String id;
  final String userId;
  final String? matchId;
  final double amount;
  final TransactionType transactionType;
  final String? referenceNote;
  final String? receiptImageUrl;
  final CashOutMethod? cashOutMethod;
  final String? fullName;
  final String? bankName;
  final String? accountNumber;
  final DateTime? processedAt;
  final String? processedByAdminId;
  final DateTime createdAt;
  final DateTime? deletedAt;

  Transaction({
    required this.id,
    required this.userId,
    this.matchId,
    required this.amount,
    required this.transactionType,
    this.referenceNote,
    this.receiptImageUrl,
    this.cashOutMethod,
    this.fullName,
    this.bankName,
    this.accountNumber,
    this.processedAt,
    this.processedByAdminId,
    DateTime? createdAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      matchId: json['match_id'],
      amount: (json['amount'] as num).toDouble(),
      transactionType: TransactionType.fromString(json['transaction_type']),
      referenceNote:
          json.containsKey('reference_note') ? json['reference_note'] : null,
      receiptImageUrl:
          json.containsKey('receipt_image_url')
              ? json['receipt_image_url']
              : null,
      cashOutMethod:
          json.containsKey('cash_out_method') && json['cash_out_method'] != null
              ? CashOutMethod.fromString(json['cash_out_method'])
              : null,
      fullName: json.containsKey('full_name') ? json['full_name'] : null,
      bankName: json.containsKey('bank_name') ? json['bank_name'] : null,
      accountNumber:
          json.containsKey('account_number') ? json['account_number'] : null,
      processedAt:
          json['processed_at'] != null
              ? DateTime.parse(json['processed_at'])
              : null,
      processedByAdminId: json['processed_by_admin_id'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : DateTime.now(),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'match_id': matchId,
      'amount': amount,
      'transaction_type': transactionType.toValue(),
      'reference_note': referenceNote,
      'receipt_image_url': receiptImageUrl,
      'cash_out_method': cashOutMethod?.toValue(),
      'full_name': fullName,
      'bank_name': bankName,
      'account_number': accountNumber,
      'processed_at': processedAt?.toIso8601String(),
      'processed_by_admin_id': processedByAdminId,
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }
}
