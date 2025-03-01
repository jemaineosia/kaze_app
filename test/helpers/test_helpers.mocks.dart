// Mocks generated by Mockito 5.4.5 from annotations
// in kaze_app/test/helpers/test_helpers.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:io' as _i14;
import 'dart:ui' as _i7;

import 'package:flutter/material.dart' as _i5;
import 'package:kaze_app/common/enums/transaction_type.dart' as _i12;
import 'package:kaze_app/models/app_user.dart' as _i16;
import 'package:kaze_app/models/match.dart' as _i20;
import 'package:kaze_app/models/notification.dart' as _i18;
import 'package:kaze_app/models/transaction.dart' as _i10;
import 'package:kaze_app/models/transaction_dto.dart' as _i11;
import 'package:kaze_app/services/appuser_service.dart' as _i15;
import 'package:kaze_app/services/auth_service.dart' as _i8;
import 'package:kaze_app/services/image_service.dart' as _i13;
import 'package:kaze_app/services/logger_service.dart' as _i2;
import 'package:kaze_app/services/match_service.dart' as _i19;
import 'package:kaze_app/services/notification_service.dart' as _i17;
import 'package:kaze_app/services/transaction_service.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:stacked_services/stacked_services.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLoggerService_0 extends _i1.SmartFake implements _i2.LoggerService {
  _FakeLoggerService_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i3.NavigationService {
  @override
  String get previousRoute =>
      (super.noSuchMethod(
            Invocation.getter(#previousRoute),
            returnValue: _i4.dummyValue<String>(
              this,
              Invocation.getter(#previousRoute),
            ),
            returnValueForMissingStub: _i4.dummyValue<String>(
              this,
              Invocation.getter(#previousRoute),
            ),
          )
          as String);

  @override
  String get currentRoute =>
      (super.noSuchMethod(
            Invocation.getter(#currentRoute),
            returnValue: _i4.dummyValue<String>(
              this,
              Invocation.getter(#currentRoute),
            ),
            returnValueForMissingStub: _i4.dummyValue<String>(
              this,
              Invocation.getter(#currentRoute),
            ),
          )
          as String);

  @override
  _i5.GlobalKey<_i5.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(
            Invocation.method(#nestedNavigationKey, [index]),
            returnValueForMissingStub: null,
          )
          as _i5.GlobalKey<_i5.NavigatorState>?);

  @override
  void config({
    bool? enableLog,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    _i3.Transition? defaultTransitionStyle,
    String? defaultTransition,
  }) => super.noSuchMethod(
    Invocation.method(#config, [], {
      #enableLog: enableLog,
      #defaultPopGesture: defaultPopGesture,
      #defaultOpaqueRoute: defaultOpaqueRoute,
      #defaultDurationTransition: defaultDurationTransition,
      #defaultGlobalState: defaultGlobalState,
      #defaultTransitionStyle: defaultTransitionStyle,
      #defaultTransition: defaultTransition,
    }),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Future<T?>? navigateWithTransition<T>(
    _i5.Widget? page, {
    bool? opaque,
    String? transition = '',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i5.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i3.Transition? transitionClass,
    _i3.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #navigateWithTransition,
              [page],
              {
                #opaque: opaque,
                #transition: transition,
                #duration: duration,
                #popGesture: popGesture,
                #id: id,
                #curve: curve,
                #fullscreenDialog: fullscreenDialog,
                #preventDuplicates: preventDuplicates,
                #transitionClass: transitionClass,
                #transitionStyle: transitionStyle,
                #routeName: routeName,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? replaceWithTransition<T>(
    _i5.Widget? page, {
    bool? opaque,
    String? transition = '',
    Duration? duration,
    bool? popGesture,
    int? id,
    _i5.Curve? curve,
    bool? fullscreenDialog = false,
    bool? preventDuplicates = true,
    _i3.Transition? transitionClass,
    _i3.Transition? transitionStyle,
    String? routeName,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #replaceWithTransition,
              [page],
              {
                #opaque: opaque,
                #transition: transition,
                #duration: duration,
                #popGesture: popGesture,
                #id: id,
                #curve: curve,
                #fullscreenDialog: fullscreenDialog,
                #preventDuplicates: preventDuplicates,
                #transitionClass: transitionClass,
                #transitionStyle: transitionStyle,
                #routeName: routeName,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  bool back<T>({dynamic result, int? id}) =>
      (super.noSuchMethod(
            Invocation.method(#back, [], {#result: result, #id: id}),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);

  @override
  void popUntil(_i5.RoutePredicate? predicate, {int? id}) => super.noSuchMethod(
    Invocation.method(#popUntil, [predicate], {#id: id}),
    returnValueForMissingStub: null,
  );

  @override
  void popRepeated(int? popTimes) => super.noSuchMethod(
    Invocation.method(#popRepeated, [popTimes]),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Future<T?>? navigateTo<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i5.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #navigateTo,
              [routeName],
              {
                #arguments: arguments,
                #id: id,
                #preventDuplicates: preventDuplicates,
                #parameters: parameters,
                #transition: transition,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? navigateToView<T>(
    _i5.Widget? view, {
    dynamic arguments,
    int? id,
    bool? opaque,
    _i5.Curve? curve,
    Duration? duration,
    bool? fullscreenDialog = false,
    bool? popGesture,
    bool? preventDuplicates = true,
    _i3.Transition? transition,
    _i3.Transition? transitionStyle,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #navigateToView,
              [view],
              {
                #arguments: arguments,
                #id: id,
                #opaque: opaque,
                #curve: curve,
                #duration: duration,
                #fullscreenDialog: fullscreenDialog,
                #popGesture: popGesture,
                #preventDuplicates: preventDuplicates,
                #transition: transition,
                #transitionStyle: transitionStyle,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? replaceWith<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
    _i5.RouteTransitionsBuilder? transition,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #replaceWith,
              [routeName],
              {
                #arguments: arguments,
                #id: id,
                #preventDuplicates: preventDuplicates,
                #parameters: parameters,
                #transition: transition,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? clearStackAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #clearStackAndShow,
              [routeName],
              {#arguments: arguments, #id: id, #parameters: parameters},
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? clearStackAndShowView<T>(
    _i5.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #clearStackAndShowView,
              [view],
              {#arguments: arguments, #id: id},
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? clearTillFirstAndShow<T>(
    String? routeName, {
    dynamic arguments,
    int? id,
    bool? preventDuplicates = true,
    Map<String, String>? parameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #clearTillFirstAndShow,
              [routeName],
              {
                #arguments: arguments,
                #id: id,
                #preventDuplicates: preventDuplicates,
                #parameters: parameters,
              },
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? clearTillFirstAndShowView<T>(
    _i5.Widget? view, {
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #clearTillFirstAndShowView,
              [view],
              {#arguments: arguments, #id: id},
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);

  @override
  _i6.Future<T?>? pushNamedAndRemoveUntil<T>(
    String? routeName, {
    _i5.RoutePredicate? predicate,
    dynamic arguments,
    int? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #pushNamedAndRemoveUntil,
              [routeName],
              {#predicate: predicate, #arguments: arguments, #id: id},
            ),
            returnValueForMissingStub: null,
          )
          as _i6.Future<T?>?);
}

/// A class which mocks [BottomSheetService].
///
/// See the documentation for Mockito's code generation for more information.
class MockBottomSheetService extends _i1.Mock
    implements _i3.BottomSheetService {
  @override
  void setCustomSheetBuilders(Map<dynamic, _i3.SheetBuilder>? builders) =>
      super.noSuchMethod(
        Invocation.method(#setCustomSheetBuilders, [builders]),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i3.SheetResponse<dynamic>?> showBottomSheet({
    required String? title,
    String? description,
    String? confirmButtonTitle = 'Ok',
    String? cancelButtonTitle,
    bool? enableDrag = true,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
    double? elevation = 1.0,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#showBottomSheet, [], {
              #title: title,
              #description: description,
              #confirmButtonTitle: confirmButtonTitle,
              #cancelButtonTitle: cancelButtonTitle,
              #enableDrag: enableDrag,
              #barrierDismissible: barrierDismissible,
              #isScrollControlled: isScrollControlled,
              #exitBottomSheetDuration: exitBottomSheetDuration,
              #enterBottomSheetDuration: enterBottomSheetDuration,
              #ignoreSafeArea: ignoreSafeArea,
              #useRootNavigator: useRootNavigator,
              #elevation: elevation,
            }),
            returnValue: _i6.Future<_i3.SheetResponse<dynamic>?>.value(),
            returnValueForMissingStub:
                _i6.Future<_i3.SheetResponse<dynamic>?>.value(),
          )
          as _i6.Future<_i3.SheetResponse<dynamic>?>);

  @override
  _i6.Future<_i3.SheetResponse<T>?> showCustomSheet<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i7.Color? barrierColor = const _i7.Color(2315255808),
    double? elevation = 1.0,
    bool? barrierDismissible = true,
    bool? isScrollControlled = false,
    String? barrierLabel = '',
    dynamic customData,
    R? data,
    bool? enableDrag = true,
    Duration? exitBottomSheetDuration,
    Duration? enterBottomSheetDuration,
    bool? ignoreSafeArea,
    bool? useRootNavigator = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#showCustomSheet, [], {
              #variant: variant,
              #title: title,
              #description: description,
              #hasImage: hasImage,
              #imageUrl: imageUrl,
              #showIconInMainButton: showIconInMainButton,
              #mainButtonTitle: mainButtonTitle,
              #showIconInSecondaryButton: showIconInSecondaryButton,
              #secondaryButtonTitle: secondaryButtonTitle,
              #showIconInAdditionalButton: showIconInAdditionalButton,
              #additionalButtonTitle: additionalButtonTitle,
              #takesInput: takesInput,
              #barrierColor: barrierColor,
              #elevation: elevation,
              #barrierDismissible: barrierDismissible,
              #isScrollControlled: isScrollControlled,
              #barrierLabel: barrierLabel,
              #customData: customData,
              #data: data,
              #enableDrag: enableDrag,
              #exitBottomSheetDuration: exitBottomSheetDuration,
              #enterBottomSheetDuration: enterBottomSheetDuration,
              #ignoreSafeArea: ignoreSafeArea,
              #useRootNavigator: useRootNavigator,
            }),
            returnValue: _i6.Future<_i3.SheetResponse<T>?>.value(),
            returnValueForMissingStub:
                _i6.Future<_i3.SheetResponse<T>?>.value(),
          )
          as _i6.Future<_i3.SheetResponse<T>?>);

  @override
  void completeSheet(_i3.SheetResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(#completeSheet, [response]),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DialogService].
///
/// See the documentation for Mockito's code generation for more information.
class MockDialogService extends _i1.Mock implements _i3.DialogService {
  @override
  void registerCustomDialogBuilders(
    Map<dynamic, _i3.DialogBuilder>? builders,
  ) => super.noSuchMethod(
    Invocation.method(#registerCustomDialogBuilders, [builders]),
    returnValueForMissingStub: null,
  );

  @override
  void registerCustomDialogBuilder({
    required dynamic variant,
    required _i5.Widget Function(
      _i5.BuildContext,
      _i3.DialogRequest<dynamic>,
      dynamic Function(_i3.DialogResponse<dynamic>),
    )?
    builder,
  }) => super.noSuchMethod(
    Invocation.method(#registerCustomDialogBuilder, [], {
      #variant: variant,
      #builder: builder,
    }),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Future<_i3.DialogResponse<dynamic>?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    _i7.Color? cancelTitleColor,
    String? buttonTitle = 'Ok',
    _i7.Color? buttonTitleColor,
    bool? barrierDismissible = false,
    _i5.RouteSettings? routeSettings,
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    _i3.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#showDialog, [], {
              #title: title,
              #description: description,
              #cancelTitle: cancelTitle,
              #cancelTitleColor: cancelTitleColor,
              #buttonTitle: buttonTitle,
              #buttonTitleColor: buttonTitleColor,
              #barrierDismissible: barrierDismissible,
              #routeSettings: routeSettings,
              #navigatorKey: navigatorKey,
              #dialogPlatform: dialogPlatform,
            }),
            returnValue: _i6.Future<_i3.DialogResponse<dynamic>?>.value(),
            returnValueForMissingStub:
                _i6.Future<_i3.DialogResponse<dynamic>?>.value(),
          )
          as _i6.Future<_i3.DialogResponse<dynamic>?>);

  @override
  _i6.Future<_i3.DialogResponse<T>?> showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    bool? hasImage = false,
    String? imageUrl,
    bool? showIconInMainButton = false,
    String? mainButtonTitle,
    bool? showIconInSecondaryButton = false,
    String? secondaryButtonTitle,
    bool? showIconInAdditionalButton = false,
    String? additionalButtonTitle,
    bool? takesInput = false,
    _i7.Color? barrierColor = const _i7.Color(2315255808),
    bool? barrierDismissible = false,
    String? barrierLabel = '',
    bool? useSafeArea = true,
    _i5.RouteSettings? routeSettings,
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    _i5.RouteTransitionsBuilder? transitionBuilder,
    dynamic customData,
    R? data,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#showCustomDialog, [], {
              #variant: variant,
              #title: title,
              #description: description,
              #hasImage: hasImage,
              #imageUrl: imageUrl,
              #showIconInMainButton: showIconInMainButton,
              #mainButtonTitle: mainButtonTitle,
              #showIconInSecondaryButton: showIconInSecondaryButton,
              #secondaryButtonTitle: secondaryButtonTitle,
              #showIconInAdditionalButton: showIconInAdditionalButton,
              #additionalButtonTitle: additionalButtonTitle,
              #takesInput: takesInput,
              #barrierColor: barrierColor,
              #barrierDismissible: barrierDismissible,
              #barrierLabel: barrierLabel,
              #useSafeArea: useSafeArea,
              #routeSettings: routeSettings,
              #navigatorKey: navigatorKey,
              #transitionBuilder: transitionBuilder,
              #customData: customData,
              #data: data,
            }),
            returnValue: _i6.Future<_i3.DialogResponse<T>?>.value(),
            returnValueForMissingStub:
                _i6.Future<_i3.DialogResponse<T>?>.value(),
          )
          as _i6.Future<_i3.DialogResponse<T>?>);

  @override
  _i6.Future<_i3.DialogResponse<dynamic>?> showConfirmationDialog({
    String? title,
    String? description,
    String? cancelTitle = 'Cancel',
    _i7.Color? cancelTitleColor,
    String? confirmationTitle = 'Ok',
    _i7.Color? confirmationTitleColor,
    bool? barrierDismissible = false,
    _i5.RouteSettings? routeSettings,
    _i3.DialogPlatform? dialogPlatform,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#showConfirmationDialog, [], {
              #title: title,
              #description: description,
              #cancelTitle: cancelTitle,
              #cancelTitleColor: cancelTitleColor,
              #confirmationTitle: confirmationTitle,
              #confirmationTitleColor: confirmationTitleColor,
              #barrierDismissible: barrierDismissible,
              #routeSettings: routeSettings,
              #dialogPlatform: dialogPlatform,
            }),
            returnValue: _i6.Future<_i3.DialogResponse<dynamic>?>.value(),
            returnValueForMissingStub:
                _i6.Future<_i3.DialogResponse<dynamic>?>.value(),
          )
          as _i6.Future<_i3.DialogResponse<dynamic>?>);

  @override
  void completeDialog(_i3.DialogResponse<dynamic>? response) =>
      super.noSuchMethod(
        Invocation.method(#completeDialog, [response]),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i8.AuthService {
  @override
  _i6.Future<dynamic> signInWithEmailPassword(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#signInWithEmailPassword, [username, password]),
            returnValue: _i6.Future<dynamic>.value(),
            returnValueForMissingStub: _i6.Future<dynamic>.value(),
          )
          as _i6.Future<dynamic>);

  @override
  _i6.Future<String?> signUpWithEmailPassword(
    String? username,
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#signUpWithEmailPassword, [
              username,
              email,
              password,
            ]),
            returnValue: _i6.Future<String?>.value(),
            returnValueForMissingStub: _i6.Future<String?>.value(),
          )
          as _i6.Future<String?>);

  @override
  _i6.Future<void> signOut() =>
      (super.noSuchMethod(
            Invocation.method(#signOut, []),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  bool isUserLoggedIn() =>
      (super.noSuchMethod(
            Invocation.method(#isUserLoggedIn, []),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);
}

/// A class which mocks [LoggerService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoggerService extends _i1.Mock implements _i2.LoggerService {
  @override
  void debug(String? message) => super.noSuchMethod(
    Invocation.method(#debug, [message]),
    returnValueForMissingStub: null,
  );

  @override
  void info(String? message) => super.noSuchMethod(
    Invocation.method(#info, [message]),
    returnValueForMissingStub: null,
  );

  @override
  void warning(String? message) => super.noSuchMethod(
    Invocation.method(#warning, [message]),
    returnValueForMissingStub: null,
  );

  @override
  void error(String? message, {dynamic error, StackTrace? stackTrace}) =>
      super.noSuchMethod(
        Invocation.method(
          #error,
          [message],
          {#error: error, #stackTrace: stackTrace},
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TransactionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionService extends _i1.Mock
    implements _i9.TransactionService {
  @override
  _i6.Future<bool> createTransaction(_i10.Transaction? transaction) =>
      (super.noSuchMethod(
            Invocation.method(#createTransaction, [transaction]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<List<_i11.TransactionDTO>> getPendingTransactions() =>
      (super.noSuchMethod(
            Invocation.method(#getPendingTransactions, []),
            returnValue: _i6.Future<List<_i11.TransactionDTO>>.value(
              <_i11.TransactionDTO>[],
            ),
            returnValueForMissingStub:
                _i6.Future<List<_i11.TransactionDTO>>.value(
                  <_i11.TransactionDTO>[],
                ),
          )
          as _i6.Future<List<_i11.TransactionDTO>>);

  @override
  _i6.Future<bool> updateTransaction({
    required String? transactionId,
    required _i12.TransactionType? transactionType,
    DateTime? processedAt,
    String? processedByAdminId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#updateTransaction, [], {
              #transactionId: transactionId,
              #transactionType: transactionType,
              #processedAt: processedAt,
              #processedByAdminId: processedByAdminId,
            }),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<_i10.Transaction?> approveTransaction(String? transactionId) =>
      (super.noSuchMethod(
            Invocation.method(#approveTransaction, [transactionId]),
            returnValue: _i6.Future<_i10.Transaction?>.value(),
            returnValueForMissingStub: _i6.Future<_i10.Transaction?>.value(),
          )
          as _i6.Future<_i10.Transaction?>);

  @override
  _i6.Future<_i10.Transaction?> getTransactionById(String? transactionId) =>
      (super.noSuchMethod(
            Invocation.method(#getTransactionById, [transactionId]),
            returnValue: _i6.Future<_i10.Transaction?>.value(),
            returnValueForMissingStub: _i6.Future<_i10.Transaction?>.value(),
          )
          as _i6.Future<_i10.Transaction?>);

  @override
  _i6.Future<List<_i10.Transaction>> getUserTransactions(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUserTransactions, [userId]),
            returnValue: _i6.Future<List<_i10.Transaction>>.value(
              <_i10.Transaction>[],
            ),
            returnValueForMissingStub: _i6.Future<List<_i10.Transaction>>.value(
              <_i10.Transaction>[],
            ),
          )
          as _i6.Future<List<_i10.Transaction>>);
}

/// A class which mocks [ImageService].
///
/// See the documentation for Mockito's code generation for more information.
class MockImageService extends _i1.Mock implements _i13.ImageService {
  @override
  _i6.Future<String> uploadImage(_i14.File? imageFile) =>
      (super.noSuchMethod(
            Invocation.method(#uploadImage, [imageFile]),
            returnValue: _i6.Future<String>.value(
              _i4.dummyValue<String>(
                this,
                Invocation.method(#uploadImage, [imageFile]),
              ),
            ),
            returnValueForMissingStub: _i6.Future<String>.value(
              _i4.dummyValue<String>(
                this,
                Invocation.method(#uploadImage, [imageFile]),
              ),
            ),
          )
          as _i6.Future<String>);
}

/// A class which mocks [AppuserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppuserService extends _i1.Mock implements _i15.AppuserService {
  @override
  _i6.Future<void> cacheUser(_i16.AppUser? user) =>
      (super.noSuchMethod(
            Invocation.method(#cacheUser, [user]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<_i16.AppUser?> getCachedUser(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getCachedUser, [userId]),
            returnValue: _i6.Future<_i16.AppUser?>.value(),
            returnValueForMissingStub: _i6.Future<_i16.AppUser?>.value(),
          )
          as _i6.Future<_i16.AppUser?>);

  @override
  _i6.Future<void> clearCachedUser(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#clearCachedUser, [userId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<_i16.AppUser?> refreshUser(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#refreshUser, [userId]),
            returnValue: _i6.Future<_i16.AppUser?>.value(),
            returnValueForMissingStub: _i6.Future<_i16.AppUser?>.value(),
          )
          as _i6.Future<_i16.AppUser?>);

  @override
  _i6.Future<bool> isUsernameTaken(String? username) =>
      (super.noSuchMethod(
            Invocation.method(#isUsernameTaken, [username]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<_i16.AppUser?> getUserByUsername(String? username) =>
      (super.noSuchMethod(
            Invocation.method(#getUserByUsername, [username]),
            returnValue: _i6.Future<_i16.AppUser?>.value(),
            returnValueForMissingStub: _i6.Future<_i16.AppUser?>.value(),
          )
          as _i6.Future<_i16.AppUser?>);

  @override
  _i6.Future<String?> getUsernameByUserId(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUsernameByUserId, [userId]),
            returnValue: _i6.Future<String?>.value(),
            returnValueForMissingStub: _i6.Future<String?>.value(),
          )
          as _i6.Future<String?>);

  @override
  _i6.Future<double> getUserBalance(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUserBalance, [userId]),
            returnValue: _i6.Future<double>.value(0.0),
            returnValueForMissingStub: _i6.Future<double>.value(0.0),
          )
          as _i6.Future<double>);

  @override
  _i6.Future<double> getUserOnHoldBalance(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUserOnHoldBalance, [userId]),
            returnValue: _i6.Future<double>.value(0.0),
            returnValueForMissingStub: _i6.Future<double>.value(0.0),
          )
          as _i6.Future<double>);

  @override
  _i6.Future<Map<String, double>> getUserBalances(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#getUserBalances, [userId]),
            returnValue: _i6.Future<Map<String, double>>.value(
              <String, double>{},
            ),
            returnValueForMissingStub: _i6.Future<Map<String, double>>.value(
              <String, double>{},
            ),
          )
          as _i6.Future<Map<String, double>>);

  @override
  _i6.Future<String?> getUserIdByUsername(String? username) =>
      (super.noSuchMethod(
            Invocation.method(#getUserIdByUsername, [username]),
            returnValue: _i6.Future<String?>.value(),
            returnValueForMissingStub: _i6.Future<String?>.value(),
          )
          as _i6.Future<String?>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i17.NotificationService {
  @override
  _i2.LoggerService get logger =>
      (super.noSuchMethod(
            Invocation.getter(#logger),
            returnValue: _FakeLoggerService_0(this, Invocation.getter(#logger)),
            returnValueForMissingStub: _FakeLoggerService_0(
              this,
              Invocation.getter(#logger),
            ),
          )
          as _i2.LoggerService);

  @override
  _i6.Future<List<_i18.Notification>> fetchUserNotifications(String? userId) =>
      (super.noSuchMethod(
            Invocation.method(#fetchUserNotifications, [userId]),
            returnValue: _i6.Future<List<_i18.Notification>>.value(
              <_i18.Notification>[],
            ),
            returnValueForMissingStub:
                _i6.Future<List<_i18.Notification>>.value(
                  <_i18.Notification>[],
                ),
          )
          as _i6.Future<List<_i18.Notification>>);

  @override
  void subscribeToNotifications(String? userId) => super.noSuchMethod(
    Invocation.method(#subscribeToNotifications, [userId]),
    returnValueForMissingStub: null,
  );

  @override
  _i6.Future<bool> addNotification({
    required String? userId,
    required String? title,
    required String? message,
    required String? type,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#addNotification, [], {
              #userId: userId,
              #title: title,
              #message: message,
              #type: type,
            }),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> markNotificationAsRead(String? notificationId) =>
      (super.noSuchMethod(
            Invocation.method(#markNotificationAsRead, [notificationId]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);
}

/// A class which mocks [MatchService].
///
/// See the documentation for Mockito's code generation for more information.
class MockMatchService extends _i1.Mock implements _i19.MatchService {
  @override
  _i6.Future<List<_i20.Match>> fetchMatches() =>
      (super.noSuchMethod(
            Invocation.method(#fetchMatches, []),
            returnValue: _i6.Future<List<_i20.Match>>.value(<_i20.Match>[]),
            returnValueForMissingStub: _i6.Future<List<_i20.Match>>.value(
              <_i20.Match>[],
            ),
          )
          as _i6.Future<List<_i20.Match>>);

  @override
  _i6.Future<_i20.Match?> createMatch(_i20.Match? match) =>
      (super.noSuchMethod(
            Invocation.method(#createMatch, [match]),
            returnValue: _i6.Future<_i20.Match?>.value(),
            returnValueForMissingStub: _i6.Future<_i20.Match?>.value(),
          )
          as _i6.Future<_i20.Match?>);

  @override
  _i6.Future<bool> updateMatch(_i20.Match? match) =>
      (super.noSuchMethod(
            Invocation.method(#updateMatch, [match]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> deleteMatch(String? matchId) =>
      (super.noSuchMethod(
            Invocation.method(#deleteMatch, [matchId]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<List<_i20.Match>> fetchMatchesByCreator(String? creatorId) =>
      (super.noSuchMethod(
            Invocation.method(#fetchMatchesByCreator, [creatorId]),
            returnValue: _i6.Future<List<_i20.Match>>.value(<_i20.Match>[]),
            returnValueForMissingStub: _i6.Future<List<_i20.Match>>.value(
              <_i20.Match>[],
            ),
          )
          as _i6.Future<List<_i20.Match>>);

  @override
  _i6.Future<List<_i20.Match>> fetchInvitedMatches({
    required String? currentUserId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#fetchInvitedMatches, [], {
              #currentUserId: currentUserId,
            }),
            returnValue: _i6.Future<List<_i20.Match>>.value(<_i20.Match>[]),
            returnValueForMissingStub: _i6.Future<List<_i20.Match>>.value(
              <_i20.Match>[],
            ),
          )
          as _i6.Future<List<_i20.Match>>);

  @override
  _i6.Future<_i20.Match?> getMatchById(String? matchId) =>
      (super.noSuchMethod(
            Invocation.method(#getMatchById, [matchId]),
            returnValue: _i6.Future<_i20.Match?>.value(),
            returnValueForMissingStub: _i6.Future<_i20.Match?>.value(),
          )
          as _i6.Future<_i20.Match?>);

  @override
  _i6.Future<bool> updateMatchInviteLink(String? matchId, String? inviteLink) =>
      (super.noSuchMethod(
            Invocation.method(#updateMatchInviteLink, [matchId, inviteLink]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> cancelMatch(String? matchId) =>
      (super.noSuchMethod(
            Invocation.method(#cancelMatch, [matchId]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<_i20.Match?> fetchMatchByInviteCode(String? inviteCode) =>
      (super.noSuchMethod(
            Invocation.method(#fetchMatchByInviteCode, [inviteCode]),
            returnValue: _i6.Future<_i20.Match?>.value(),
            returnValueForMissingStub: _i6.Future<_i20.Match?>.value(),
          )
          as _i6.Future<_i20.Match?>);

  @override
  _i6.Future<void> declareMatchWinner(String? matchId, String? winnerId) =>
      (super.noSuchMethod(
            Invocation.method(#declareMatchWinner, [matchId, winnerId]),
            returnValue: _i6.Future<void>.value(),
            returnValueForMissingStub: _i6.Future<void>.value(),
          )
          as _i6.Future<void>);

  @override
  _i6.Future<bool> acceptMatch(String? matchId, String? currentUserId) =>
      (super.noSuchMethod(
            Invocation.method(#acceptMatch, [matchId, currentUserId]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> requestMatchCancellation({
    required String? matchId,
    required String? userId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#requestMatchCancellation, [], {
              #matchId: matchId,
              #userId: userId,
            }),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> resetCancellationRequest(String? matchId) =>
      (super.noSuchMethod(
            Invocation.method(#resetCancellationRequest, [matchId]),
            returnValue: _i6.Future<bool>.value(false),
            returnValueForMissingStub: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);
}
