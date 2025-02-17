import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/common/enums/match_type.dart';
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
    FormTextField(name: 'opponentUsername'),
  ],
)
class MatchView extends StackedView<MatchViewModel> with $MatchView {
  MatchView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget builder(BuildContext context, MatchViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KazeTextfield(
                hintText: 'Match Title',
                controller: matchTitleController,
                validator: (value) => (value == null || value.isEmpty) ? 'Match title is required' : null,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Match Description',
                controller: matchDescriptionController,
                validator: (value) => (value == null || value.isEmpty) ? 'Match description is required' : null,
              ),
              Gap(10.h),
              KazeTextfield(
                hintText: 'Creator Bet Amount',
                controller: creatorBetAmountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final doubleValue = double.tryParse(value ?? '');
                  if (value == null || value.isEmpty) return 'Creator bet amount is required';
                  if (doubleValue == null || doubleValue <= 0) return 'Invalid bet amount';
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
                  if (value == null || value.isEmpty) return 'Opponent bet amount is required';
                  if (doubleValue == null || doubleValue <= 0) return 'Invalid bet amount';
                  return null;
                },
              ),
              DropdownButtonFormField<MatchType>(
                value: viewModel.matchType,
                items:
                    MatchType.values.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type.toValue()));
                    }).toList(),
                onChanged: viewModel.setMatchType,
              ),

              if (viewModel.matchType == MatchType.inviteOpponent)
                KazeTextfield(
                  hintText: 'Opponent Username',
                  controller: opponentUsernameController,
                  validator: (value) {
                    if (viewModel.matchType == MatchType.inviteOpponent && (value == null || value.isEmpty)) {
                      return 'Opponent username is required';
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
                      viewModel.matchType == MatchType.inviteOpponent ? opponentUsernameController.text : null,
                    );
                  }
                },
                isLoading: viewModel.isBusy,
              ),
              Gap(20.h),
              if (viewModel.validationMessage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(viewModel.validationMessage!, style: const TextStyle(color: Colors.red)),
                ),
              Gap(20.h),
              const Text('Matches:'),
              Expanded(
                child:
                    viewModel.isBusy
                        ? const Center(child: CircularProgressIndicator())
                        : viewModel.matches.isEmpty
                        ? const Center(child: Text('No matches yet'))
                        : ListView.builder(
                          itemCount: viewModel.matches.length,
                          itemBuilder: (context, index) {
                            final match = viewModel.matches[index];
                            return ListTile(title: Text(match.matchTitle), subtitle: Text(match.matchDescription));
                          },
                        ),
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
    viewModel.fetchMatches();
  }

  @override
  void onDispose(MatchViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
