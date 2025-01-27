import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/common/enums/payment_method.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TopupViewModel extends FormViewModel {
  final ImagePicker _imagePicker = ImagePicker();
  final _databaseService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  File? _receiptImage;
  File? get receiptImage => _receiptImage;

  PaymentMethod _selectedMethod = PaymentMethod.gcash;

  PaymentMethod get selectedMethod => _selectedMethod;

  void setSelectedMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  // User picks an image for the receipt
  Future<void> pickReceiptImage() async {
    // Could also use `ImageSource.camera` if you want camera
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _receiptImage = File(pickedFile.path);
      notifyListeners(); // Update the UI if needed
    }
  }

  // Submit the data (amount + photo)
  Future<void> submitTopup(String amount) async {
    // Validate amount, check if receiptImage is not null, etc.
    if (amount.isEmpty) {
      // handle error or show a message
      return;
    }
    if (_receiptImage == null) {
      // handle error or show a message
      return;
    }

    // Perform your logic here, e.g.:
    // 1) Upload the _receiptImage to Supabase Storage or your server
    // 2) Save the 'amount' and 'imageURL' in your DB
    // 3) Or pass to an Admin for manual verification

    // For demonstration, we just print them
    print('Submitting top-up with amount: $amount');
    print('Receipt path: ${_receiptImage!.path}');
  }

  Future<void> submitTopupToSupabase(String amount) async {
    if (_authService.getCurrentUser() == null) {
      _authService.signOut();
      _navigationService.replaceWithLoginView();
    }

    if (amount.isEmpty) {
      // handle error
      return;
    }
    if (_receiptImage == null) {
      // handle error
      return;
    }

    setBusy(true); // Indicate loading in UI

    try {
      // Step A: Upload the image to Supabase Storage
      final imageUrl = await _databaseService.uploadImage(_receiptImage!);

      // Transaction newTrans = Transaction(
      //   userId: _authService.getCurrentUser().id,
      //   amount: amount,
      //   receipImage: receipImage,
      //   transactionType: transactionType,
      //   createdAt: createdAt,
      // );

      // // Step B: Insert into 'transactions' table
      // await _insertTransaction(amount, imageUrl);

      // Possibly show success message or navigate away
      // ...
    } catch (e) {
      // handle error, e.g. show dialog
      print('submitTopupToSupabase Error: $e');
    } finally {
      setBusy(false);
    }
  }
}
