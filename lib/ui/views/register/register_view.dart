import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'register_view.form.dart';
import 'register_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'username'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
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
              Gap(20.h),
              KazeTextfield(
                hintText: "Username",
                controller: usernameController,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: "Email",
                controller: emailController,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "By continuing, you agree to our ",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "terms of service.",
                      style: TextStyle(
                        color: kcOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              KazeButton(
                text: "Sign Up",
                onTap: () {},
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Sign in here",
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
  void onDispose(RegisterViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  void onViewModelReady(RegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}
