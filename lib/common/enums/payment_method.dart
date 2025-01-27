enum PaymentMethod {
  gcash,
  paymaya;

  /// Convert a string to a PaymentMethod enum
  static PaymentMethod fromString(String method) {
    switch (method.toLowerCase()) {
      case 'gcash':
        return PaymentMethod.gcash;
      case 'paymaya':
        return PaymentMethod.paymaya;
      default:
        throw ArgumentError('Invalid payment method: $method');
    }
  }

  /// Convert a PaymentMethod enum to a string
  String toValue() {
    switch (this) {
      case PaymentMethod.gcash:
        return 'gcash';
      case PaymentMethod.paymaya:
        return 'paymaya';
    }
  }
}
