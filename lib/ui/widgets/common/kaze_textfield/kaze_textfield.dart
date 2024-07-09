import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'kaze_textfield_model.dart';

class KazeTextfield extends StackedView<KazeTextfieldModel> {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const KazeTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.87.w),
          borderSide: BorderSide(
            color: Colors.black45,
            width: 0.5.w,
          ),
        ),
      ),
    );
  }

  @override
  KazeTextfieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      KazeTextfieldModel();
}
