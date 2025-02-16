import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
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
      body: viewModel.screensList[viewModel.currentIndex],
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kcDarkGreyColor,
        ),
        child: FloatingActionButton(
          onPressed: () {
            viewModel.showCreateMatch(context); // Pass the context!
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: viewModel.barItems.length,
        tabBuilder: (int index, bool isActive) {
          final item = viewModel.barItems[index];
          final color = isActive ? Colors.white : Colors.white30;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 24, color: color),
              const SizedBox(height: 4),
              Text(item.label, style: TextStyle(color: color, fontSize: 12)),
            ],
          );
        },
        activeIndex: viewModel.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: viewModel.onTabTapped,
        backgroundColor: kcDarkGreyColor,
        // activeColor: Colors.white,
        // inactiveColor: Colors.white30,
      ),
    );
  }

  @override
  BottomnavViewModel viewModelBuilder(BuildContext context) =>
      BottomnavViewModel();
}
