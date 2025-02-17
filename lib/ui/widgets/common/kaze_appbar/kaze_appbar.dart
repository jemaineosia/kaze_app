import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'kaze_appbar_model.dart';

class KazeAppBar extends StackedView<KazeAppbarModel>
    implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;

  const KazeAppBar({
    Key? key,
    this.title = "KAZE",
    this.centerTitle = false,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    KazeAppbarModel viewModel,
    Widget? child,
  ) {
    return AppBar(
      title: Text(title),
      titleTextStyle: TextStyle(color: kcWhite, fontSize: 20.sp),
      backgroundColor: kcDarkGreyColor,
      centerTitle: centerTitle,
      leading: leading,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: kcWhite),
        ),
        const Gap(10),
      ],
    );
  }

  Widget walletDisplay(KazeAppbarModel viewModel) => ElevatedButton(
    onPressed: () {
      // Handle button press
      print('Rounded Button Pressed');
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
    ),
    child: Row(
      children: [
        // Black circular background for the icon
        InkWell(
          onTap: () => viewModel.showTopupView(),
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.black, // Background color
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white, // Icon color for contrast
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Coins: 0',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  KazeAppbarModel viewModelBuilder(BuildContext context) => KazeAppbarModel();
}
