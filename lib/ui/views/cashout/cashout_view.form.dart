// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String BankNameValueKey = 'bankName';
const String FullNameValueKey = 'fullName';
const String AccountNumberValueKey = 'accountNumber';
const String AmountValueKey = 'amount';

final Map<String, TextEditingController> _CashoutViewTextEditingControllers =
    {};

final Map<String, FocusNode> _CashoutViewFocusNodes = {};

final Map<String, String? Function(String?)?> _CashoutViewTextValidations = {
  BankNameValueKey: null,
  FullNameValueKey: null,
  AccountNumberValueKey: null,
  AmountValueKey: null,
};

mixin $CashoutView {
  TextEditingController get bankNameController =>
      _getFormTextEditingController(BankNameValueKey);
  TextEditingController get fullNameController =>
      _getFormTextEditingController(FullNameValueKey);
  TextEditingController get accountNumberController =>
      _getFormTextEditingController(AccountNumberValueKey);
  TextEditingController get amountController =>
      _getFormTextEditingController(AmountValueKey);

  FocusNode get bankNameFocusNode => _getFormFocusNode(BankNameValueKey);
  FocusNode get fullNameFocusNode => _getFormFocusNode(FullNameValueKey);
  FocusNode get accountNumberFocusNode =>
      _getFormFocusNode(AccountNumberValueKey);
  FocusNode get amountFocusNode => _getFormFocusNode(AmountValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CashoutViewTextEditingControllers.containsKey(key)) {
      return _CashoutViewTextEditingControllers[key]!;
    }

    _CashoutViewTextEditingControllers[key] = TextEditingController(
      text: initialValue,
    );
    return _CashoutViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CashoutViewFocusNodes.containsKey(key)) {
      return _CashoutViewFocusNodes[key]!;
    }
    _CashoutViewFocusNodes[key] = FocusNode();
    return _CashoutViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    bankNameController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    accountNumberController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    bankNameController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    accountNumberController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap..addAll({
        BankNameValueKey: bankNameController.text,
        FullNameValueKey: fullNameController.text,
        AccountNumberValueKey: accountNumberController.text,
        AmountValueKey: amountController.text,
      }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _CashoutViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CashoutViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CashoutViewTextEditingControllers.clear();
    _CashoutViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this.fieldsValidationMessages.values.any(
    (validation) => validation != null,
  );

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get bankNameValue => this.formValueMap[BankNameValueKey] as String?;
  String? get fullNameValue => this.formValueMap[FullNameValueKey] as String?;
  String? get accountNumberValue =>
      this.formValueMap[AccountNumberValueKey] as String?;
  String? get amountValue => this.formValueMap[AmountValueKey] as String?;

  set bankNameValue(String? value) {
    this.setData(this.formValueMap..addAll({BankNameValueKey: value}));

    if (_CashoutViewTextEditingControllers.containsKey(BankNameValueKey)) {
      _CashoutViewTextEditingControllers[BankNameValueKey]?.text = value ?? '';
    }
  }

  set fullNameValue(String? value) {
    this.setData(this.formValueMap..addAll({FullNameValueKey: value}));

    if (_CashoutViewTextEditingControllers.containsKey(FullNameValueKey)) {
      _CashoutViewTextEditingControllers[FullNameValueKey]?.text = value ?? '';
    }
  }

  set accountNumberValue(String? value) {
    this.setData(this.formValueMap..addAll({AccountNumberValueKey: value}));

    if (_CashoutViewTextEditingControllers.containsKey(AccountNumberValueKey)) {
      _CashoutViewTextEditingControllers[AccountNumberValueKey]?.text =
          value ?? '';
    }
  }

  set amountValue(String? value) {
    this.setData(this.formValueMap..addAll({AmountValueKey: value}));

    if (_CashoutViewTextEditingControllers.containsKey(AmountValueKey)) {
      _CashoutViewTextEditingControllers[AmountValueKey]?.text = value ?? '';
    }
  }

  bool get hasBankName =>
      this.formValueMap.containsKey(BankNameValueKey) &&
      (bankNameValue?.isNotEmpty ?? false);
  bool get hasFullName =>
      this.formValueMap.containsKey(FullNameValueKey) &&
      (fullNameValue?.isNotEmpty ?? false);
  bool get hasAccountNumber =>
      this.formValueMap.containsKey(AccountNumberValueKey) &&
      (accountNumberValue?.isNotEmpty ?? false);
  bool get hasAmount =>
      this.formValueMap.containsKey(AmountValueKey) &&
      (amountValue?.isNotEmpty ?? false);

  bool get hasBankNameValidationMessage =>
      this.fieldsValidationMessages[BankNameValueKey]?.isNotEmpty ?? false;
  bool get hasFullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey]?.isNotEmpty ?? false;
  bool get hasAccountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey]?.isNotEmpty ?? false;
  bool get hasAmountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey]?.isNotEmpty ?? false;

  String? get bankNameValidationMessage =>
      this.fieldsValidationMessages[BankNameValueKey];
  String? get fullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey];
  String? get accountNumberValidationMessage =>
      this.fieldsValidationMessages[AccountNumberValueKey];
  String? get amountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey];
}

extension Methods on FormStateHelper {
  setBankNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BankNameValueKey] = validationMessage;
  setFullNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullNameValueKey] = validationMessage;
  setAccountNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AccountNumberValueKey] = validationMessage;
  setAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AmountValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    bankNameValue = '';
    fullNameValue = '';
    accountNumberValue = '';
    amountValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      BankNameValueKey: getValidationMessage(BankNameValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      AmountValueKey: getValidationMessage(AmountValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CashoutViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CashoutViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      BankNameValueKey: getValidationMessage(BankNameValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      AccountNumberValueKey: getValidationMessage(AccountNumberValueKey),
      AmountValueKey: getValidationMessage(AmountValueKey),
    });
