enum TransactionType {
  cashIn,
  cashOut,
  betHold,
  betRelease;

  /// Convert a string to a TransactionType enum
  static TransactionType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'cash_in':
        return TransactionType.cashIn;
      case 'cash_out':
        return TransactionType.cashOut;
      case 'bet_hold':
        return TransactionType.betHold;
      case 'bet_release':
        return TransactionType.betRelease;
      default:
        throw ArgumentError('Invalid transaction type: $type');
    }
  }

  /// Convert a TransactionType enum to a string
  String toValue() {
    switch (this) {
      case TransactionType.cashIn:
        return 'cash_in';
      case TransactionType.cashOut:
        return 'cash_out';
      case TransactionType.betHold:
        return 'bet_hold';
      case TransactionType.betRelease:
        return 'bet_release';
    }
  }
}

// void main() {
//   // Create a new transaction instance
//   Transaction newTransaction = Transaction(
//     id: '123',
//     userId: 'user_1',
//     matchId: 'match_1',
//     amount: 100.0,
//     transactionType: TransactionType.cashIn, // Enum value
//     referenceNote: 'Top-up via GCash',
//   );

//   // Convert transaction to JSON
//   Map<String, dynamic> transactionJson = newTransaction.toJson();
//   print(transactionJson);

//   // Convert JSON back to Transaction
//   Transaction transactionFromJson = Transaction.fromJson(transactionJson);
//   print(transactionFromJson.transactionType); // Output: TransactionType.cashIn
// }
