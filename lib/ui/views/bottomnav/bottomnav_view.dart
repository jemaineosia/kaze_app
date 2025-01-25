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
        width: 60, // Width of the FAB
        height: 60, // Height of the FAB (making it circular)
        decoration: const BoxDecoration(
          shape: BoxShape.circle, // Ensuring the FAB is circular
          color: kcDarkGreyColor, // FAB color
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Handle the floating action button press
            print("Floating Button Pressed");
          }, // Icon inside the FAB
          backgroundColor: Colors
              .transparent, // Transparent background (as it's inside a container)
          elevation: 0,
          child: const Icon(Icons.add), // Remove shadow for a flat look
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: viewModel.iconsList, // List of icons for the navigation items
        activeIndex: viewModel.currentIndex, // Currently selected index
        gapLocation: GapLocation.center, // Place the items in the center
        notchSmoothness: NotchSmoothness.softEdge, // Smooth curve for the notch
        onTap: viewModel.onTabTapped, // Handle item tap
        // Optional: Customize animation duration, colors, and more
        // animationDuration: const Duration(milliseconds: 300),
        backgroundColor:
            kcDarkGreyColor, // Background color of the navigation bar
        activeColor: Colors.white, // Color of the selected icon
        inactiveColor: Colors.white30, // Color of the unselected icons
      ),
    );
  }

  @override
  BottomnavViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BottomnavViewModel();
}
