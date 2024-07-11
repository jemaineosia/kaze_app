import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'kaze_textfield_model.dart';

class KazeTextfield extends StackedView<KazeTextfieldModel> {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon suffixIcon;

  const KazeTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon = const Icon(Icons.person_outline),
  });

  @override
  Widget builder(
    BuildContext context,
    KazeTextfieldModel viewModel,
    Widget? child,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 12.sp,
        fontFamily: "Pilat",
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: kcGrey20,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.87.w),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  @override
  KazeTextfieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      KazeTextfieldModel();
}
