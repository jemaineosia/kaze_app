import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'forgot_password_view.form.dart';
import 'forgot_password_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
])
class ForgotPasswordView extends StackedView<ForgotPasswordViewModel>
    with $ForgotPasswordView {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "KAZE ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                  Text(
                    "APP",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
              Gap(80.h),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Gap(10.h),
              const Text(
                "Enter your email address to get the password reset link",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              Gap(20.h),
              KazeTextfield(
                hintText: "Email",
                controller: emailController,
              ),
              Gap(20.h),
              KazeButton(
                text: "Password Reset",
                onTap: () {},
                isLoading: viewModel.isBusy,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Create an account",
                      style: TextStyle(
                        color: kcOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onDispose(ForgotPasswordViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  void onViewModelReady(ForgotPasswordViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotPasswordViewModel();
}
