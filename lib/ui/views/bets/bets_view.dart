import 'package:flutter/material.dart';
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
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text('Bets View')),
      ),
    );
  }

  @override
  BetsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BetsViewModel();
}
