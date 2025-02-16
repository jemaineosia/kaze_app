import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/app/app.router.dart';
import 'package:kaze_app/common/enums/cashin_method.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/models/transaction.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/image_service.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class CashinViewModel extends FormViewModel {
  final ImagePicker _imagePicker = ImagePicker();
  final _transactionService = locator<TransactionService>();
  final _imageService = locator<ImageService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _loggerService = locator<LoggerService>();

  File? _receiptImage;
  File? get receiptImage => _receiptImage;

  CashInMethod _selectedMethod = CashInMethod.gcash;
  CashInMethod get selectedMethod => _selectedMethod;

  void setSelectedMethod(CashInMethod method) {
    _selectedMethod = method;
    notifyListeners();
    _loggerService.info('Payment method selected: ${method.toString()}');
  }

  // Pick receipt image
  Future<void> pickReceiptImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        _receiptImage = File(pickedFile.path);
        notifyListeners();
        _loggerService.info('Receipt image selected: ${_receiptImage!.path}');
      } else {
        _loggerService.warning('User cancelled image selection.');
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error while picking receipt image.',
        error: e,
        stackTrace: stackTrace,
      );
      await _dialogService.showDialog(
        title: 'Image Selection Error',
        description: 'An error occurred while selecting the receipt image.',
      );
    }
  }

  // Submit the top-up request
  Future<void> submitTopup(String amount) async {
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        double.parse(amount) <= 0) {
      await _dialogService.showDialog(
        title: 'Invalid Amount',
        description: 'Please enter a valid amount greater than 0.',
      );
      _loggerService.warning('Invalid amount entered: $amount');
      return;
    }

    if (_receiptImage == null) {
      await _dialogService.showDialog(
        title: 'Receipt Required',
        description: 'Please upload a receipt image before submitting.',
      );
      _loggerService.warning('Receipt image not uploaded before submission.');
      return;
    }

    setBusy(true);
    try {
      final user = _authService.getCurrentUser();
      if (user == null) {
        _authService.signOut();
        _navigationService.replaceWithLoginView();
        _loggerService.warning('No user logged in. Redirecting to login view.');
        return;
      }

      _loggerService.info('User ${user.id} is submitting a top-up of $amount.');

      // Upload the receipt image to Supabase storage
      final receiptUrl = await _imageService.uploadImage(_receiptImage!);
      _loggerService.info('Receipt image uploaded to Supabase: $receiptUrl');

      // Save the top-up transaction to the database
      final transaction = Transaction(
        id: const Uuid().v4(), // Generate a unique ID for the transaction
        userId: user.id,
        amount: double.parse(amount),
        transactionType: TransactionType.cashInPending, // Use the enum
        referenceNote: 'Cash-In via ${selectedMethod.toValue()}',
        receiptImageUrl: receiptUrl, // Attach the uploaded receipt URL
        createdAt: DateTime.now(),
        deletedAt: null, // Not deleted yet
      );

      // Call the method to save the transaction
      final success = await _transactionService.createTransaction(transaction);

      if (success) {
        _loggerService.info(
          'Top-up request submitted successfully for user: ${user.id}',
        );
        await _dialogService.showDialog(
          title: 'Top-Up Submitted',
          description:
              'Your top-up request has been submitted successfully. Please wait for admin approval.',
        );
        _navigationService.back();
      } else {
        throw Exception('Failed to create a transaction record in Supabase.');
      }
    } catch (e, stackTrace) {
      _loggerService.error(
        'Error while submitting top-up request.',
        error: e,
        stackTrace: stackTrace,
      );
      await _dialogService.showDialog(
        title: 'Submission Failed',
        description: 'An error occurred while submitting your top-up request.',
      );
    } finally {
      setBusy(false);
    }
  }
}
