// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  int id;
  int userId;
  num amount;
  TransactionType transactionType;
  String? receipImage;
  DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.receipImage,
    required this.transactionType,
    required this.createdAt,
  });

  Transaction copyWith({
    int? id,
    int? userId,
    int? matchId,
    num? amount,
    String? receipImage,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      receipImage: receipImage ?? this.receipImage,
      transactionType: transactionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'amount': amount,
      'receipImage': receipImage,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      userId: map['userId'] as int,
      amount: map['amount'] as num,
      receipImage: map['receipImage'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      transactionType:
          transactionTypeFromString(map['transactionType'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, amount: $amount, receipImage: $receipImage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.amount == amount &&
        other.receipImage == receipImage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        amount.hashCode ^
        receipImage.hashCode ^
        createdAt.hashCode;
  }
}

TransactionType transactionTypeFromString(String value) {
  switch (value) {
    case 'deposit':
      return TransactionType.cashin;
    case 'bet':
      return TransactionType.cashout;
    default:
      throw Exception('Unknown transaction type: $value');
  }
}

enum TransactionType {
  cashin,
  cashout,
}
