import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileBar(viewModel.username),
            Gap(20.sp),
            const Text('NOTIFICATIONS'),
            Expanded(
              child:
                  viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: viewModel.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = viewModel.notifications[index];
                          return ListTile(
                            title: Text(notification.title),
                            subtitle: Text(notification.message),
                            trailing: Icon(
                              notification.isRead
                                  ? Icons.check_circle
                                  : Icons.circle,
                              color:
                                  notification.isRead
                                      ? Colors.green
                                      : Colors.grey,
                            ),
                            onTap:
                                () => viewModel.handleNotificationTap(
                                  notification.id,
                                ),
                          );
                        },
                      ),
            ),
            const Spacer(),
            KazeButton(
              text: 'Sign Out',
              onTap: () => viewModel.signOut(),
              isLoading: viewModel.isBusy,
            ),
            const Gap(5),
            KazeButton(
              text: 'Admin',
              onTap: () => viewModel.navigateToAdmin(),
              isLoading: viewModel.isBusy,
            ),
            Gap(20.sp),
          ],
        ),
      ),
    );
  }

  Row profileBar(String username) {
    return Row(
      children: [
        profileAvatar(),
        Gap(20.sp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('WELCOME BACK,', style: TextStyle(fontSize: 15.sp)),
              Text(
                username,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.sp),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'P10,000',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('EARNED'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('0', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('FOLLOWERS'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '305',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('WINS'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack profileAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: kcBlack,
          maxRadius: 30.sp,
          child: Icon(Icons.person, size: 40.sp),
        ),
        Positioned(
          bottom: 0, // Align to the bottom
          right: 0, // Align to the right
          child: CircleAvatar(
            maxRadius: 10.sp,
            backgroundColor: Colors.green,
            child: Icon(size: 15.sp, Icons.check, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  void onViewModelReady(SettingsViewModel viewModel) {
    viewModel.fetchUsername();
    viewModel.fetchNotifications();
    super.onViewModelReady(viewModel);
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) =>
      SettingsViewModel();
}
