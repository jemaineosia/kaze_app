import 'package:kaze_app/common/enums/transaction_type.dart';

class TransactionDTO {
  final String id;
  final String userId;
  final String? matchId;
  final double amount;
  final TransactionType transactionType;
  final String? referenceNote;
  final String? receiptImageUrl;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final String? username; // From the `appusers` field

  TransactionDTO({
    required this.id,
    required this.userId,
    this.matchId,
    required this.amount,
    required this.transactionType,
    this.referenceNote,
    this.receiptImageUrl,
    required this.createdAt,
    this.deletedAt,
    this.username, // Optional
  });

  factory TransactionDTO.fromJson(Map<String, dynamic> json) {
    return TransactionDTO(
      id: json['id'],
      userId: json['user_id'],
      matchId: json['match_id'],
      amount: (json['amount'] as num).toDouble(),
      transactionType: TransactionType.fromString(json['transaction_type']),
      referenceNote: json['reference_note'],
      receiptImageUrl: json['receipt_image_url'],
      createdAt: DateTime.parse(json['created_at']),
      deletedAt:
          json['deleted_at'] != null
              ? DateTime.parse(json['deleted_at'])
              : null,
      username: json['appusers']?['username'], // Extract nested username
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
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'appusers': {'username': username}, // Nested username
    };
  }
}
