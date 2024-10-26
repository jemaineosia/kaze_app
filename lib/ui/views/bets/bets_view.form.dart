// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String GameValueKey = 'game';
const String EventDateValueKey = 'eventDate';
const String OpponentUsernameValueKey = 'opponentUsername';
const String BetAmountValueKey = 'betAmount';
const String OpponentBetAmountValueKey = 'opponentBetAmount';

final Map<String, TextEditingController> _BetsViewTextEditingControllers = {};

final Map<String, FocusNode> _BetsViewFocusNodes = {};

final Map<String, String? Function(String?)?> _BetsViewTextValidations = {
  GameValueKey: null,
  EventDateValueKey: null,
  OpponentUsernameValueKey: null,
  BetAmountValueKey: null,
  OpponentBetAmountValueKey: null,
};

mixin $BetsView {
  TextEditingController get gameController =>
      _getFormTextEditingController(GameValueKey);
  TextEditingController get eventDateController =>
      _getFormTextEditingController(EventDateValueKey);
  TextEditingController get opponentUsernameController =>
      _getFormTextEditingController(OpponentUsernameValueKey);
  TextEditingController get betAmountController =>
      _getFormTextEditingController(BetAmountValueKey);
  TextEditingController get opponentBetAmountController =>
      _getFormTextEditingController(OpponentBetAmountValueKey);

  FocusNode get gameFocusNode => _getFormFocusNode(GameValueKey);
  FocusNode get eventDateFocusNode => _getFormFocusNode(EventDateValueKey);
  FocusNode get opponentUsernameFocusNode =>
      _getFormFocusNode(OpponentUsernameValueKey);
  FocusNode get betAmountFocusNode => _getFormFocusNode(BetAmountValueKey);
  FocusNode get opponentBetAmountFocusNode =>
      _getFormFocusNode(OpponentBetAmountValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_BetsViewTextEditingControllers.containsKey(key)) {
      return _BetsViewTextEditingControllers[key]!;
    }

    _BetsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BetsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BetsViewFocusNodes.containsKey(key)) {
      return _BetsViewFocusNodes[key]!;
    }
    _BetsViewFocusNodes[key] = FocusNode();
    return _BetsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    gameController.addListener(() => _updateFormData(model));
    eventDateController.addListener(() => _updateFormData(model));
    opponentUsernameController.addListener(() => _updateFormData(model));
    betAmountController.addListener(() => _updateFormData(model));
    opponentBetAmountController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    gameController.addListener(() => _updateFormData(model));
    eventDateController.addListener(() => _updateFormData(model));
    opponentUsernameController.addListener(() => _updateFormData(model));
    betAmountController.addListener(() => _updateFormData(model));
    opponentBetAmountController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          GameValueKey: gameController.text,
          EventDateValueKey: eventDateController.text,
          OpponentUsernameValueKey: opponentUsernameController.text,
          BetAmountValueKey: betAmountController.text,
          OpponentBetAmountValueKey: opponentBetAmountController.text,
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

    for (var controller in _BetsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BetsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _BetsViewTextEditingControllers.clear();
    _BetsViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get gameValue => this.formValueMap[GameValueKey] as String?;
  String? get eventDateValue => this.formValueMap[EventDateValueKey] as String?;
  String? get opponentUsernameValue =>
      this.formValueMap[OpponentUsernameValueKey] as String?;
  String? get betAmountValue => this.formValueMap[BetAmountValueKey] as String?;
  String? get opponentBetAmountValue =>
      this.formValueMap[OpponentBetAmountValueKey] as String?;

  set gameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({GameValueKey: value}),
    );

    if (_BetsViewTextEditingControllers.containsKey(GameValueKey)) {
      _BetsViewTextEditingControllers[GameValueKey]?.text = value ?? '';
    }
  }

  set eventDateValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EventDateValueKey: value}),
    );

    if (_BetsViewTextEditingControllers.containsKey(EventDateValueKey)) {
      _BetsViewTextEditingControllers[EventDateValueKey]?.text = value ?? '';
    }
  }

  set opponentUsernameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({OpponentUsernameValueKey: value}),
    );

    if (_BetsViewTextEditingControllers.containsKey(OpponentUsernameValueKey)) {
      _BetsViewTextEditingControllers[OpponentUsernameValueKey]?.text =
          value ?? '';
    }
  }

  set betAmountValue(String? value) {
    this.setData(
      this.formValueMap..addAll({BetAmountValueKey: value}),
    );

    if (_BetsViewTextEditingControllers.containsKey(BetAmountValueKey)) {
      _BetsViewTextEditingControllers[BetAmountValueKey]?.text = value ?? '';
    }
  }

  set opponentBetAmountValue(String? value) {
    this.setData(
      this.formValueMap..addAll({OpponentBetAmountValueKey: value}),
    );

    if (_BetsViewTextEditingControllers.containsKey(
        OpponentBetAmountValueKey)) {
      _BetsViewTextEditingControllers[OpponentBetAmountValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasGame =>
      this.formValueMap.containsKey(GameValueKey) &&
      (gameValue?.isNotEmpty ?? false);
  bool get hasEventDate =>
      this.formValueMap.containsKey(EventDateValueKey) &&
      (eventDateValue?.isNotEmpty ?? false);
  bool get hasOpponentUsername =>
      this.formValueMap.containsKey(OpponentUsernameValueKey) &&
      (opponentUsernameValue?.isNotEmpty ?? false);
  bool get hasBetAmount =>
      this.formValueMap.containsKey(BetAmountValueKey) &&
      (betAmountValue?.isNotEmpty ?? false);
  bool get hasOpponentBetAmount =>
      this.formValueMap.containsKey(OpponentBetAmountValueKey) &&
      (opponentBetAmountValue?.isNotEmpty ?? false);

  bool get hasGameValidationMessage =>
      this.fieldsValidationMessages[GameValueKey]?.isNotEmpty ?? false;
  bool get hasEventDateValidationMessage =>
      this.fieldsValidationMessages[EventDateValueKey]?.isNotEmpty ?? false;
  bool get hasOpponentUsernameValidationMessage =>
      this.fieldsValidationMessages[OpponentUsernameValueKey]?.isNotEmpty ??
      false;
  bool get hasBetAmountValidationMessage =>
      this.fieldsValidationMessages[BetAmountValueKey]?.isNotEmpty ?? false;
  bool get hasOpponentBetAmountValidationMessage =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey]?.isNotEmpty ??
      false;

  String? get gameValidationMessage =>
      this.fieldsValidationMessages[GameValueKey];
  String? get eventDateValidationMessage =>
      this.fieldsValidationMessages[EventDateValueKey];
  String? get opponentUsernameValidationMessage =>
      this.fieldsValidationMessages[OpponentUsernameValueKey];
  String? get betAmountValidationMessage =>
      this.fieldsValidationMessages[BetAmountValueKey];
  String? get opponentBetAmountValidationMessage =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey];
}

extension Methods on FormStateHelper {
  setGameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[GameValueKey] = validationMessage;
  setEventDateValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EventDateValueKey] = validationMessage;
  setOpponentUsernameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OpponentUsernameValueKey] =
          validationMessage;
  setBetAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BetAmountValueKey] = validationMessage;
  setOpponentBetAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    gameValue = '';
    eventDateValue = '';
    opponentUsernameValue = '';
    betAmountValue = '';
    opponentBetAmountValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      GameValueKey: getValidationMessage(GameValueKey),
      EventDateValueKey: getValidationMessage(EventDateValueKey),
      OpponentUsernameValueKey: getValidationMessage(OpponentUsernameValueKey),
      BetAmountValueKey: getValidationMessage(BetAmountValueKey),
      OpponentBetAmountValueKey:
          getValidationMessage(OpponentBetAmountValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _BetsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _BetsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      GameValueKey: getValidationMessage(GameValueKey),
      EventDateValueKey: getValidationMessage(EventDateValueKey),
      OpponentUsernameValueKey: getValidationMessage(OpponentUsernameValueKey),
      BetAmountValueKey: getValidationMessage(BetAmountValueKey),
      OpponentBetAmountValueKey:
          getValidationMessage(OpponentBetAmountValueKey),
    });
