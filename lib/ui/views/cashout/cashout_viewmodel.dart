import 'package:kaze_app/common/enums/cashout_method.dart';
import 'package:stacked/stacked.dart';

class CashoutViewModel extends FormViewModel {
  List<String> paymentModes = [];
  String? selectedPaymentMode;
  final double currentBalance = 1000.0; // Example balance

  CashoutViewModel() {
    // Load payment modes from the enum
    paymentModes = CashOutMethod.values.map((e) => e.toValue()).toList();
  }

  void setSelectedPaymentMode(String? mode) {
    selectedPaymentMode = mode;
    notifyListeners();
  }

  void submit() {}
}
