import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'cashout_viewmodel.dart';

class CashoutView extends StackedView<CashoutViewModel> {
  const CashoutView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CashoutViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  CashoutViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CashoutViewModel();
}
