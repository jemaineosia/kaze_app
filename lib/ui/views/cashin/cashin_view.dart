import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/common/enums/cashin_method.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'cashin_view.form.dart';
import 'cashin_viewmodel.dart';

@FormView(fields: [FormTextField(name: 'amount')])
class CashinView extends StackedView<CashinViewModel> with $CashinView {
  CashinView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    CashinViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KAZE", style: TextStyle(color: kcWhite)),
        backgroundColor: kcBlack,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _paymentMode(viewModel),
                const Gap(20),
                TextField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  style: const TextStyle(
                    fontSize: 30, // Increase font size here
                    fontWeight:
                        FontWeight.bold, // Optional: make it bold, if desired
                  ),
                ),
                const Gap(20),
                TextButton(
                  onPressed: () async {
                    await viewModel.pickReceiptImage();
                  },
                  child: const Text('Upload Receipt'),
                ),
                if (viewModel.receiptImage != null) ...[
                  const Gap(10),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.file(
                      File(viewModel.receiptImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const Gap(30),
                KazeButton(
                  text: 'Submit',
                  onTap: () async {
                    await viewModel.submitTopup(amountController.text);
                  },
                  isLoading: viewModel.isBusy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _paymentMode(CashinViewModel viewModel) {
    return Column(
      children: [
        Text("Payment Mode", style: TextStyle(fontSize: 20.sp)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GCash radio
            Row(
              children: [
                Radio<CashInMethod>(
                  value: CashInMethod.gcash,
                  groupValue: viewModel.selectedMethod,
                  onChanged: (CashInMethod? newValue) {
                    if (newValue != null) {
                      viewModel.setSelectedMethod(newValue);
                    }
                  },
                ),
                const Text('GCash'),
              ],
            ),
            const SizedBox(width: 24),
            // Bank radio
            Row(
              children: [
                Radio<CashInMethod>(
                  value: CashInMethod.paymaya,
                  groupValue: viewModel.selectedMethod,
                  onChanged: (CashInMethod? newValue) {
                    if (newValue != null) {
                      viewModel.setSelectedMethod(newValue);
                    }
                  },
                ),
                const Text('Paymaya'),
              ],
            ),
          ],
        ),
        Gap(20.h),
        Builder(
          builder: (context) {
            if (viewModel.selectedMethod == CashInMethod.gcash) {
              return _gcashWidget();
            } else {
              return _bankWidget();
            }
          },
        ),
      ],
    );
  }

  Widget _gcashWidget() {
    return const Column(
      children: [
        Text("Send Payment To"),
        Text("Juan Bakokang"),
        Text("09485094930"),
      ],
    );
  }

  Widget _bankWidget() {
    return const Column(
      children: [
        Text("Send Payment To"),
        Text("Don Facundo"),
        Text("BDO Bank Account: A0344593404"),
      ],
    );
  }

  @override
  CashinViewModel viewModelBuilder(BuildContext context) => CashinViewModel();
}
