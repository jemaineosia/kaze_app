import 'package:flutter/material.dart';
import 'package:kaze_app/ui/views/home/home_view.dart';
import 'package:kaze_app/ui/views/wallet/wallet_view.dart';
import 'package:stacked/stacked.dart';

import 'bottomnav_viewmodel.dart';

class BottomnavView extends StackedView<BottomnavViewModel> {
  const BottomnavView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BottomnavViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _getSelectedScreen(viewModel.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: (index) {
          viewModel.onTabTapped(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Floating button pressed");
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getSelectedScreen(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const WalletView();
      default:
        return const HomeView();
    }
  }

  @override
  BottomnavViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomnavViewModel();
}
