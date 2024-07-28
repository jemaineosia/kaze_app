import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'bets_viewmodel.dart';

class BetsView extends StackedView<BetsViewModel> {
  const BetsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BetsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Center(
        child: Text(
          'BetsView',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  BetsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BetsViewModel();
}
