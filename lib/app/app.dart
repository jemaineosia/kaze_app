import 'package:kaze_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:kaze_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:kaze_app/ui/views/home/home_view.dart';
import 'package:kaze_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:kaze_app/ui/views/login/login_view.dart';
import 'package:kaze_app/ui/views/register/register_view.dart';
import 'package:kaze_app/services/auth_service.dart';
import 'package:kaze_app/ui/views/bottomnav/bottomnav_view.dart';
import 'package:kaze_app/ui/views/wallet/wallet_view.dart';
import 'package:kaze_app/ui/views/settings/settings_view.dart';
import 'package:kaze_app/ui/views/chat/chat_view.dart';
import 'package:kaze_app/services/logger_service.dart';
import 'package:kaze_app/ui/views/admin/admin_view.dart';
import 'package:kaze_app/services/transaction_service.dart';
import 'package:kaze_app/services/image_service.dart';
import 'package:kaze_app/services/appuser_service.dart';
import 'package:kaze_app/services/notification_service.dart';
import 'package:kaze_app/ui/views/cashout/cashout_view.dart';
import 'package:kaze_app/ui/views/cashin/cashin_view.dart';
import 'package:kaze_app/services/match_service.dart';
import 'package:kaze_app/ui/views/match/match_view.dart';
import 'package:kaze_app/ui/views/match_details/match_details_view.dart';
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
    MaterialRoute(page: AdminView),
    MaterialRoute(page: CashoutView),
    MaterialRoute(page: CashinView),
    MaterialRoute(page: MatchView),
    MaterialRoute(page: MatchDetailsView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: LoggerService),
    LazySingleton(classType: TransactionService),
    LazySingleton(classType: ImageService),
    LazySingleton(classType: AppuserService),
    LazySingleton(classType: NotificationService),
    LazySingleton(classType: MatchService),
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