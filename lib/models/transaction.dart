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
    required this.transactionType,
    this.referenceNote,
    DateTime? createdAt,
    this.deletedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['userId'],
      matchId: json['matchId'],
      amount: (json['amount'] as num).toDouble(),
      transactionType: TransactionType.fromString(json['transactionType']),
      referenceNote: json['referenceNote'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'matchId': matchId,
      'amount': amount,
      'transactionType': transactionType.toValue(),
      'referenceNote': referenceNote,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
