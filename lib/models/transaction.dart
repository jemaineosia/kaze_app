import 'package:kaze_app/common/enums/transaction_type.dart';

class Transaction {
  final String id;
  final String userId;
  final String? matchId;
  final double amount;
  final TransactionType transactionType; // Using TransactionType enum
  final String? referenceNote;
  final String? receiptImageUrl; // New field for the receipt image URL
  final DateTime createdAt;
  final DateTime? deletedAt;

  Transaction({
    required this.id,
    required this.userId,
    this.matchId,
    required this.amount,
    required this.transactionType,
    this.referenceNote,
    this.receiptImageUrl, // New field
    DateTime? createdAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'], // Updated to snake_case
      matchId: json['match_id'], // Updated to snake_case
      amount: (json['amount'] as num).toDouble(),
      transactionType: TransactionType.fromString(
          json['transaction_type']), // Updated to snake_case
      referenceNote: json['reference_note'], // Updated to snake_case
      receiptImageUrl: json['receipt_image_url'], // Updated to snake_case
      createdAt: json['created_at'] != null // Updated to snake_case
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      deletedAt: json['deleted_at'] != null // Updated to snake_case
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId, // Updated to snake_case
      'match_id': matchId, // Updated to snake_case
      'amount': amount,
      'transaction_type': transactionType.toValue(), // Updated to snake_case
      'reference_note': referenceNote, // Updated to snake_case
      'receipt_image_url': receiptImageUrl, // Updated to snake_case
      'created_at': createdAt.toIso8601String(), // Updated to snake_case
      'deleted_at': deletedAt?.toIso8601String(), // Updated to snake_case
    };
  }
}
