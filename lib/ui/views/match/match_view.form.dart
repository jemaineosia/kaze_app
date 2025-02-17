// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String MatchTitleValueKey = 'matchTitle';
const String MatchDescriptionValueKey = 'matchDescription';
const String CreatorBetAmountValueKey = 'creatorBetAmount';
const String OpponentBetAmountValueKey = 'opponentBetAmount';
const String OpponentUsernameValueKey = 'opponentUsername';

final Map<String, TextEditingController> _MatchViewTextEditingControllers = {};

final Map<String, FocusNode> _MatchViewFocusNodes = {};

final Map<String, String? Function(String?)?> _MatchViewTextValidations = {
  MatchTitleValueKey: null,
  MatchDescriptionValueKey: null,
  CreatorBetAmountValueKey: null,
  OpponentBetAmountValueKey: null,
  OpponentUsernameValueKey: null,
};

mixin $MatchView {
  TextEditingController get matchTitleController =>
      _getFormTextEditingController(MatchTitleValueKey);
  TextEditingController get matchDescriptionController =>
      _getFormTextEditingController(MatchDescriptionValueKey);
  TextEditingController get creatorBetAmountController =>
      _getFormTextEditingController(CreatorBetAmountValueKey);
  TextEditingController get opponentBetAmountController =>
      _getFormTextEditingController(OpponentBetAmountValueKey);
  TextEditingController get opponentUsernameController =>
      _getFormTextEditingController(OpponentUsernameValueKey);

  FocusNode get matchTitleFocusNode => _getFormFocusNode(MatchTitleValueKey);
  FocusNode get matchDescriptionFocusNode =>
      _getFormFocusNode(MatchDescriptionValueKey);
  FocusNode get creatorBetAmountFocusNode =>
      _getFormFocusNode(CreatorBetAmountValueKey);
  FocusNode get opponentBetAmountFocusNode =>
      _getFormFocusNode(OpponentBetAmountValueKey);
  FocusNode get opponentUsernameFocusNode =>
      _getFormFocusNode(OpponentUsernameValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_MatchViewTextEditingControllers.containsKey(key)) {
      return _MatchViewTextEditingControllers[key]!;
    }

    _MatchViewTextEditingControllers[key] = TextEditingController(
      text: initialValue,
    );
    return _MatchViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_MatchViewFocusNodes.containsKey(key)) {
      return _MatchViewFocusNodes[key]!;
    }
    _MatchViewFocusNodes[key] = FocusNode();
    return _MatchViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    matchTitleController.addListener(() => _updateFormData(model));
    matchDescriptionController.addListener(() => _updateFormData(model));
    creatorBetAmountController.addListener(() => _updateFormData(model));
    opponentBetAmountController.addListener(() => _updateFormData(model));
    opponentUsernameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    matchTitleController.addListener(() => _updateFormData(model));
    matchDescriptionController.addListener(() => _updateFormData(model));
    creatorBetAmountController.addListener(() => _updateFormData(model));
    opponentBetAmountController.addListener(() => _updateFormData(model));
    opponentUsernameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap..addAll({
        MatchTitleValueKey: matchTitleController.text,
        MatchDescriptionValueKey: matchDescriptionController.text,
        CreatorBetAmountValueKey: creatorBetAmountController.text,
        OpponentBetAmountValueKey: opponentBetAmountController.text,
        OpponentUsernameValueKey: opponentUsernameController.text,
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

    for (var controller in _MatchViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _MatchViewFocusNodes.values) {
      focusNode.dispose();
    }

    _MatchViewTextEditingControllers.clear();
    _MatchViewFocusNodes.clear();
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

  String? get matchTitleValue =>
      this.formValueMap[MatchTitleValueKey] as String?;
  String? get matchDescriptionValue =>
      this.formValueMap[MatchDescriptionValueKey] as String?;
  String? get creatorBetAmountValue =>
      this.formValueMap[CreatorBetAmountValueKey] as String?;
  String? get opponentBetAmountValue =>
      this.formValueMap[OpponentBetAmountValueKey] as String?;
  String? get opponentUsernameValue =>
      this.formValueMap[OpponentUsernameValueKey] as String?;

  set matchTitleValue(String? value) {
    this.setData(this.formValueMap..addAll({MatchTitleValueKey: value}));

    if (_MatchViewTextEditingControllers.containsKey(MatchTitleValueKey)) {
      _MatchViewTextEditingControllers[MatchTitleValueKey]?.text = value ?? '';
    }
  }

  set matchDescriptionValue(String? value) {
    this.setData(this.formValueMap..addAll({MatchDescriptionValueKey: value}));

    if (_MatchViewTextEditingControllers.containsKey(
      MatchDescriptionValueKey,
    )) {
      _MatchViewTextEditingControllers[MatchDescriptionValueKey]?.text =
          value ?? '';
    }
  }

  set creatorBetAmountValue(String? value) {
    this.setData(this.formValueMap..addAll({CreatorBetAmountValueKey: value}));

    if (_MatchViewTextEditingControllers.containsKey(
      CreatorBetAmountValueKey,
    )) {
      _MatchViewTextEditingControllers[CreatorBetAmountValueKey]?.text =
          value ?? '';
    }
  }

  set opponentBetAmountValue(String? value) {
    this.setData(this.formValueMap..addAll({OpponentBetAmountValueKey: value}));

    if (_MatchViewTextEditingControllers.containsKey(
      OpponentBetAmountValueKey,
    )) {
      _MatchViewTextEditingControllers[OpponentBetAmountValueKey]?.text =
          value ?? '';
    }
  }

  set opponentUsernameValue(String? value) {
    this.setData(this.formValueMap..addAll({OpponentUsernameValueKey: value}));

    if (_MatchViewTextEditingControllers.containsKey(
      OpponentUsernameValueKey,
    )) {
      _MatchViewTextEditingControllers[OpponentUsernameValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasMatchTitle =>
      this.formValueMap.containsKey(MatchTitleValueKey) &&
      (matchTitleValue?.isNotEmpty ?? false);
  bool get hasMatchDescription =>
      this.formValueMap.containsKey(MatchDescriptionValueKey) &&
      (matchDescriptionValue?.isNotEmpty ?? false);
  bool get hasCreatorBetAmount =>
      this.formValueMap.containsKey(CreatorBetAmountValueKey) &&
      (creatorBetAmountValue?.isNotEmpty ?? false);
  bool get hasOpponentBetAmount =>
      this.formValueMap.containsKey(OpponentBetAmountValueKey) &&
      (opponentBetAmountValue?.isNotEmpty ?? false);
  bool get hasOpponentUsername =>
      this.formValueMap.containsKey(OpponentUsernameValueKey) &&
      (opponentUsernameValue?.isNotEmpty ?? false);

  bool get hasMatchTitleValidationMessage =>
      this.fieldsValidationMessages[MatchTitleValueKey]?.isNotEmpty ?? false;
  bool get hasMatchDescriptionValidationMessage =>
      this.fieldsValidationMessages[MatchDescriptionValueKey]?.isNotEmpty ??
      false;
  bool get hasCreatorBetAmountValidationMessage =>
      this.fieldsValidationMessages[CreatorBetAmountValueKey]?.isNotEmpty ??
      false;
  bool get hasOpponentBetAmountValidationMessage =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey]?.isNotEmpty ??
      false;
  bool get hasOpponentUsernameValidationMessage =>
      this.fieldsValidationMessages[OpponentUsernameValueKey]?.isNotEmpty ??
      false;

  String? get matchTitleValidationMessage =>
      this.fieldsValidationMessages[MatchTitleValueKey];
  String? get matchDescriptionValidationMessage =>
      this.fieldsValidationMessages[MatchDescriptionValueKey];
  String? get creatorBetAmountValidationMessage =>
      this.fieldsValidationMessages[CreatorBetAmountValueKey];
  String? get opponentBetAmountValidationMessage =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey];
  String? get opponentUsernameValidationMessage =>
      this.fieldsValidationMessages[OpponentUsernameValueKey];
}

extension Methods on FormStateHelper {
  setMatchTitleValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MatchTitleValueKey] = validationMessage;
  setMatchDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MatchDescriptionValueKey] =
          validationMessage;
  setCreatorBetAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CreatorBetAmountValueKey] =
          validationMessage;
  setOpponentBetAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OpponentBetAmountValueKey] =
          validationMessage;
  setOpponentUsernameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OpponentUsernameValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    matchTitleValue = '';
    matchDescriptionValue = '';
    creatorBetAmountValue = '';
    opponentBetAmountValue = '';
    opponentUsernameValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      MatchTitleValueKey: getValidationMessage(MatchTitleValueKey),
      MatchDescriptionValueKey: getValidationMessage(MatchDescriptionValueKey),
      CreatorBetAmountValueKey: getValidationMessage(CreatorBetAmountValueKey),
      OpponentBetAmountValueKey: getValidationMessage(
        OpponentBetAmountValueKey,
      ),
      OpponentUsernameValueKey: getValidationMessage(OpponentUsernameValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _MatchViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _MatchViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      MatchTitleValueKey: getValidationMessage(MatchTitleValueKey),
      MatchDescriptionValueKey: getValidationMessage(MatchDescriptionValueKey),
      CreatorBetAmountValueKey: getValidationMessage(CreatorBetAmountValueKey),
      OpponentBetAmountValueKey: getValidationMessage(
        OpponentBetAmountValueKey,
      ),
      OpponentUsernameValueKey: getValidationMessage(OpponentUsernameValueKey),
    });
