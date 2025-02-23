import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'match_view.form.dart';
import 'match_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'matchTitle'),
    FormTextField(name: 'matchDescription'),
    FormTextField(name: 'creatorBetAmount'),
    FormTextField(name: 'opponentBetAmount'),
  ],
)
class MatchView extends StackedView<MatchViewModel> with $MatchView {
  MatchView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
    BuildContext context,
    MatchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Balance: P${viewModel.currentBalance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Match Title',
                controller: matchTitleController,
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Match title is required'
                            : null,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Match Description',
                controller: matchDescriptionController,
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Match description is required'
                            : null,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Creator Bet Amount',
                controller: creatorBetAmountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final doubleValue = double.tryParse(value ?? '');
                  if (value == null || value.isEmpty) {
                    return 'Creator bet amount is required';
                  }
                  if (doubleValue == null || doubleValue <= 0) {
                    return 'Invalid bet amount';
                  }
                  return null;
                },
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Opponent Bet Amount',
                controller: opponentBetAmountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final doubleValue = double.tryParse(value ?? '');
                  if (value == null || value.isEmpty) {
                    return 'Opponent bet amount is required';
                  }
                  if (doubleValue == null || doubleValue <= 0) {
                    return 'Invalid bet amount';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              KazeButton(
                text: 'Create Match',
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    viewModel.createMatch(
                      matchTitleController.text,
                      matchDescriptionController.text,
                      double.parse(creatorBetAmountController.text),
                      double.parse(opponentBetAmountController.text),
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
  MatchViewModel viewModelBuilder(BuildContext context) => MatchViewModel();

  @override
  void onViewModelReady(MatchViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.initialize();
  }

  @override
  void onDispose(MatchViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
