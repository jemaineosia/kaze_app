import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'username'),
  FormTextField(name: 'password'),
])
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
                suffixIcon: const Icon(Icons.person_outline),
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
                suffixIcon: const Icon(Icons.lock_outline),
              ),
              Gap(20.h),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot Password?",
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
                text: "Login",
                onTap: () => viewModel.login(
                  usernameController.text,
                  passwordController.text,
                ),
                isLoading: viewModel.isBusy,
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New Member? "),
                  GestureDetector(
                    onTap: () => viewModel.navigateToRegister(),
                    child: const Text(
                      "Register Now",
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
  void onDispose(LoginViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
