import 'package:flutter/material.dart';
import 'package:kaze_app/ui/widgets/common/kaze_drawer/kaze_drawer.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
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
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
