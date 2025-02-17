import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/common/enums/cashout_method.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'cashout_view.form.dart';
import 'cashout_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'bankName'),
    FormTextField(name: 'fullName'),
    FormTextField(name: 'accountNumber'),
    FormTextField(name: 'amount'),
  ],
)
class CashoutView extends StackedView<CashoutViewModel> with $CashoutView {
  CashoutView({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    CashoutViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KAZE", style: TextStyle(color: kcWhite)),
        backgroundColor: kcBlack,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              Text(
                "P${viewModel.currentBalance.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Text("Current Balance"),
              Gap(30.h),
              DropdownButtonFormField<CashOutMethod>(
                value: viewModel.selectedPaymentMode,
                items:
                    viewModel.paymentModes.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(
                          mode.toValue(),
                        ), // Use the enum's string representation
                      );
                    }).toList(),
                onChanged: viewModel.setSelectedPaymentMode,
                decoration: InputDecoration(
                  labelText: 'Payment Mode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
                validator:
                    (value) =>
                        value == null ? 'Please select a payment mode' : null,
              ),
              if (viewModel.selectedPaymentMode == CashOutMethod.bank) ...[
                Gap(10.h),
                KazeTextfield(
                  hintText: 'Bank Name',
                  controller: bankNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank name';
                    }
                    return null;
                  },
                ),
              ],
              KazeTextfield(
                hintText: 'Full Name',
                controller: fullNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              KazeTextfield(
                hintText: 'Account Number',
                controller: accountNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your account number';
                  }
                  return null;
                },
              ),
              KazeTextfield(
                hintText: 'Amount',
                controller: amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  if (amount > viewModel.currentBalance) {
                    return 'Amount exceeds current balance';
                  }
                  return null;
                },
              ),
              Gap(10.h),
              KazeButton(
                text: 'Submit',
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    viewModel.submit(
                      bankNameController.text,
                      fullNameController.text,
                      accountNumberController.text,
                      double.tryParse(amountController.text) ?? 0.0,
                      viewModel.selectedPaymentMode ?? CashOutMethod.gcash,
                    );
                  }
                },
                isLoading: viewModel.isBusy,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onViewModelReady(CashoutViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  CashoutViewModel viewModelBuilder(BuildContext context) => CashoutViewModel();
}
