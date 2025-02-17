enum CashInMethod {
  gcash,
  paymaya;

  /// Convert a string to a PaymentMethod enum
  static CashInMethod fromString(String method) {
    switch (method.toLowerCase()) {
      case 'gcash':
        return CashInMethod.gcash;
      case 'paymaya':
        return CashInMethod.paymaya;
      default:
        throw ArgumentError('Invalid payment method: $method');
    }
  }

  /// Convert a PaymentMethod enum to a string
  String toValue() {
    switch (this) {
      case CashInMethod.gcash:
        return 'GCash';
      case CashInMethod.paymaya:
        return 'Paymaya';
    }
  }
}
