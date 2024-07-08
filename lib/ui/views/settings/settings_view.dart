import 'package:flutter/material.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
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
      backgroundColor: kcBackgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text('Settings View')),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
