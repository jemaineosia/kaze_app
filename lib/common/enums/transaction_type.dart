enum TransactionType {
  cashIn,
  cashInPending,
  cashOut,
  cashOutPending,
  cashOutFailed,
  betHold,
  betRelease;

  /// Convert a string to a TransactionType enum
  static TransactionType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'cash_in':
        return TransactionType.cashIn;
      case 'cash_in_pending':
        return TransactionType.cashInPending;
      case 'cash_out':
        return TransactionType.cashOut;
      case 'cash_out_pending':
        return TransactionType.cashOutPending;
      case 'cash_out_failed':
        return TransactionType.cashOutFailed;
      case 'bet_hold':
        return TransactionType.betHold;
      case 'bet_release':
        return TransactionType.betRelease;
      default:
        throw ArgumentError('Invalid transaction type: $type');
    }
  }

  /// Convert a TransactionType enum to a database-friendly string
  String toValue() {
    switch (this) {
      case TransactionType.cashIn:
        return 'cash_in';
      case TransactionType.cashInPending:
        return 'cash_in_pending';
      case TransactionType.cashOut:
        return 'cash_out';
      case TransactionType.cashOutPending:
        return 'cash_out_pending';
      case TransactionType.cashOutFailed:
        return 'cash_out_failed';
      case TransactionType.betHold:
        return 'bet_hold';
      case TransactionType.betRelease:
        return 'bet_release';
    }
  }

  /// Override default toString() for better readability
  @override
  String toString() {
    switch (this) {
      case TransactionType.cashIn:
        return 'Cash In';
      case TransactionType.cashInPending:
        return 'Cash In Pending';
      case TransactionType.cashOut:
        return 'Cash Out';
      case TransactionType.cashOutPending:
        return 'Cash Out Pending';
      case TransactionType.cashOutFailed:
        return 'Cash Out Failed';
      case TransactionType.betHold:
        return 'Bet On Hold';
      case TransactionType.betRelease:
        return 'Bet Released';
    }
  }
}
