import 'package:kaze_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:kaze_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:kaze_app/ui/views/home/home_view.dart';
import 'package:kaze_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kaze_app/ui/views/login/login_view.dart';
import 'package:kaze_app/ui/views/register/register_view.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/services/database_service.dart';
import 'package:kaze_app/ui/views/bottomnav/bottomnav_view.dart';
import 'package:kaze_app/ui/views/wallet/wallet_view.dart';
import 'package:kaze_app/ui/views/settings/settings_view.dart';
import 'package:kaze_app/ui/views/chat/chat_view.dart';
import 'package:kaze_app/ui/views/topup/topup_view.dart';
import 'package:kaze_app/services/logger_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: BottomnavView),
    MaterialRoute(page: WalletView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: TopupView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: LoggerService),
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
