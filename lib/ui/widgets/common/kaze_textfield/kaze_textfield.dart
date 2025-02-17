import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'kaze_textfield_model.dart';

class KazeTextfield extends StackedView<KazeTextfieldModel> {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon suffixIcon;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const KazeTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon = const Icon(null),
    this.onTap,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget builder(
    BuildContext context,
    KazeTextfieldModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: TextFormField(
        validator: validator,
        onTap: onTap,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          errorStyle: const TextStyle(color: Colors.redAccent),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.h),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.h),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.w),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  KazeTextfieldModel viewModelBuilder(BuildContext context) =>
      KazeTextfieldModel();
}
