import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/ui/widgets/common/kaze_drawer/kaze_drawer_tile.dart';
import 'package:stacked/stacked.dart';

import 'kaze_drawer_model.dart';

class KazeDrawer extends StackedView<KazeDrawerModel> {
  const KazeDrawer({super.key});

  @override
  Widget builder(
    BuildContext context,
    KazeDrawerModel viewModel,
    Widget? child,
  ) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Icon(
                  Icons.person,
                  size: 80.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(color: Theme.of(context).colorScheme.secondary),
              KazeDrawerTile(
                title: 'H O M E',
                icon: Icons.home,
                onTap: () {
                  viewModel.navigateToHome();
                  Navigator.of(context).pop();
                },
              ),
              KazeDrawerTile(
                title: 'S E T T I N G S',
                icon: Icons.settings,
                onTap: () => viewModel.navigateToSettings(),
              ),
              const Spacer(),
              KazeDrawerTile(
                title: 'L O G O U T',
                icon: Icons.logout,
                onTap: () => viewModel.logout(),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  KazeDrawerModel viewModelBuilder(BuildContext context) => KazeDrawerModel();
}
