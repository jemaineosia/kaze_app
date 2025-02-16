import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'kaze_button_model.dart';

class KazeButton extends StackedView<KazeButtonModel> {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final bool isLoading;

  const KazeButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    required this.isLoading,
  });

  @override
  Widget builder(
    BuildContext context,
    KazeButtonModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Center(
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }

  @override
  KazeButtonModel viewModelBuilder(BuildContext context) => KazeButtonModel();
}
