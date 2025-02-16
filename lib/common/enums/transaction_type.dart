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
    return name.toLowerCase().replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)?.toLowerCase()}',
    );
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
