enum CashOutMethod {
  gcash,
  paymaya,
  bank;

  /// Convert a string to a PaymentMethod enum
  static CashOutMethod fromString(String method) {
    switch (method.toLowerCase()) {
      case 'gcash':
        return CashOutMethod.gcash;
      case 'paymaya':
        return CashOutMethod.paymaya;
      case 'bank':
        return CashOutMethod.bank;
      default:
        throw ArgumentError('Invalid cashout method: $method');
    }
  }

  /// Convert a PaymentMethod enum to a string
  String toValue() {
    switch (this) {
      case CashOutMethod.gcash:
        return 'GCash';
      case CashOutMethod.paymaya:
        return 'Paymaya';
      case CashOutMethod.bank:
        return 'Bank';
    }
  }
}
