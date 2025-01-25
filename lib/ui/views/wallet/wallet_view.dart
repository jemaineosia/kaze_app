import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'wallet_viewmodel.dart';

class WalletView extends StackedView<WalletViewModel> {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WalletViewModel viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: Center(
        child: Text('W A L L E T'),
      ),
    );
  }

  @override
  WalletViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WalletViewModel();
}
