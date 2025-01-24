import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
  RegisterView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
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
                  hintText: "Email",
                  controller: emailController,
                  suffixIcon: const Icon(Icons.email_outlined),
                ),
                Gap(10.h),
                KazeTextfield(
                  hintText: "Password",
                  controller: passwordController,
                  suffixIcon: const Icon(Icons.lock_outline),
                  obscureText: true,
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By continuing, you agree to our ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "terms of service.",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                KazeButton(
                  text: "Sign Up",
                  onTap: () => viewModel.register(
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                  isLoading: viewModel.isBusy,
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => viewModel.navigateToLogin(),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
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
