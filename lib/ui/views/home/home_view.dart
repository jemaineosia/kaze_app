import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/views/bets/bets_view.dart';
import 'package:kaze_app/ui/views/inbox/inbox_view.dart';
import 'package:kaze_app/ui/views/settings/settings_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        title: const Row(
          children: [
            Text(
              "KAZE ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "APP",
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => viewModel.signOut(),
            ),
          ),
        ],
      ),
      backgroundColor: kcBackgroundColor,
      body: getViewForIndex(viewModel.currentIndex),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.h),
        child: Container(
          height: 75.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(14.h),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8.w,
                activeColor: Colors.black,
                iconSize: 24.sp,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.white60,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Inbox',
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: viewModel.currentIndex,
                onTabChange: viewModel.setIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const BetsView();
      case 1:
        return const InboxView();
      case 2:
        return const SettingsView();
      default:
        return const BetsView();
    }
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
