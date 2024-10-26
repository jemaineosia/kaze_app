import 'package:flutter/material.dart';
import 'package:kaze_app/ui/widgets/common/kaze_drawer/kaze_drawer.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KAZE",
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: KazeDrawer(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
