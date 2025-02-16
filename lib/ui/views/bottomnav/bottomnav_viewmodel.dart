import 'package:flutter/material.dart';
import 'package:kaze_app/models/bottom_nav_bar_item.dart';
import 'package:kaze_app/ui/views/chat/chat_view.dart';
import 'package:kaze_app/ui/views/home/home_view.dart';
import 'package:kaze_app/ui/views/match/match_view.dart';
import 'package:kaze_app/ui/views/settings/settings_view.dart';
import 'package:kaze_app/ui/views/wallet/wallet_view.dart';
import 'package:stacked/stacked.dart';

class BottomnavViewModel extends IndexTrackingViewModel {
  void onTabTapped(int index) {
    setIndex(index);
  }

  final List<IconData> iconsList = [
    Icons.home,
    Icons.chat,
    Icons.account_balance_wallet,
    Icons.settings,
  ];

  final List<Widget> screensList = [
    const HomeView(),
    const ChatView(),
    const WalletView(),
    const SettingsView(),
  ];

  List<BottomNavBarItem> barItems = [
    BottomNavBarItem(icon: Icons.home, label: "Home"),
    BottomNavBarItem(icon: Icons.chat, label: "Chat"),
    BottomNavBarItem(icon: Icons.wallet, label: "Wallet"),
    BottomNavBarItem(icon: Icons.settings, label: "Settings"),
  ];

  void showCreateMatch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Full-screen height for modal
      backgroundColor: Colors.white,
      builder: (context) => MatchView(),
    );
  }
}
