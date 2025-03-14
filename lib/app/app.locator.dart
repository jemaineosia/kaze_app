// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:kaze_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/appuser_service.dart';
import '../services/auth_service.dart';
import '../services/image_service.dart';
import '../services/logger_service.dart';
import '../services/match_service.dart';
import '../services/notification_service.dart';
import '../services/transaction_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({String? environment, EnvironmentFilter? environmentFilter}) async {
  // Register environments
  locator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

  // Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LoggerService());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => AppuserService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => MatchService());
  locator.registerLazySingleton(() => HomeViewModel());
}
