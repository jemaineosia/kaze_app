import 'package:kaze_app/common/enums/transaction_type.dart';

class Transaction {
  final String id;
  final String userId;
  final String? matchId;
  final double amount;
  final TransactionType transactionType; // Using TransactionType enum
  final String? referenceNote;
  final DateTime createdAt;
  final DateTime? deletedAt;

  Transaction({
    required this.id,
    required this.userId,
    this.matchId,
    required this.amount,
    required this.transactionType, // Enum type
    this.referenceNote,
    DateTime? createdAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now(); // Default to now

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      matchId: json['match_id'],
      amount: (json['amount'] as num).toDouble(),
      transactionType:
          TransactionType.fromString(json['transaction_type']), // Parse type
      referenceNote: json['reference_note'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      deletedAt: json['deleted_at'] != null
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
      'transaction_type': transactionType.toValue(), // Convert enum to string
      'reference_note': referenceNote,
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
