import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/ui/common/app_colors.dart';
import 'package:kaze_app/ui/widgets/common/kaze_textfield/kaze_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_shared/stacked_shared.dart';

import 'bets_view.form.dart';
import 'bets_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'game'),
  FormTextField(name: 'eventDate'),
  FormTextField(name: 'opponentUsername'),
  FormTextField(name: 'betAmount'),
  FormTextField(name: 'opponentBetAmount'),
])
class BetsView extends StackedView<BetsViewModel> with $BetsView {
  const BetsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    BetsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 30.h,
          ),
          child: Column(
            children: [
              _header(viewModel),
              KazeTextfield(
                hintText: 'Game',
                controller: gameController,
              ),
              SizedBox(height: 10.h),
              KazeTextfield(
                hintText: 'Event Date',
                controller: gameController,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    // setState(() {
                    //   // Update the TextFormField with the selected time
                    //   _timeController.text = pickedTime.format(context);
                    // });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _header(BetsViewModel viewModel) {
    return Row(
      children: [
        IconButton(
          onPressed: () => viewModel.pop,
          icon: Icon(
            Icons.close,
            size: 20.sp,
          ),
        ),
        const Spacer(),
        Text(
          "Create Event",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  void onViewModelReady(BetsViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(BetsViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  BetsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BetsViewModel();
}
