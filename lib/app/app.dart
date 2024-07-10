import 'package:kaze_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:kaze_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:kaze_app/ui/views/home/home_view.dart';
import 'package:kaze_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kaze_app/ui/views/bets/bets_view.dart';
import 'package:kaze_app/ui/views/inbox/inbox_view.dart';
import 'package:kaze_app/ui/views/settings/settings_view.dart';
import 'package:kaze_app/ui/views/login/login_view.dart';
import 'package:kaze_app/ui/views/register/register_view.dart';
import 'package:kaze_app/ui/views/reset_password/reset_password_view.dart';
import 'package:kaze_app/ui/views/forgot_password/forgot_password_view.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/firestore_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: BetsView),
    MaterialRoute(page: InboxView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ResetPasswordView),
    MaterialRoute(page: ForgotPasswordView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: FirestoreService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
