import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:stacked/stacked.dart';

import 'wallet_viewmodel.dart';

class WalletView extends StackedView<WalletViewModel> {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WalletViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),

            // Current Balance
            Text(
              "P${viewModel.currentBalance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Current Balance"),

            Gap(10.h),

            // On-Hold Balance
            Text(
              "On-Hold: P${viewModel.onHoldBalance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.orange,
              ),
            ),

            Gap(20.h),

            // Cash In and Cash Out Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: KazeButton(
                    text: 'Cash In',
                    onTap: () => viewModel.navigateToCashIn(),
                    isLoading: viewModel.isBusy,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: KazeButton(
                    text: 'Cash Out',
                    onTap: () => viewModel.navigateToCashOut(),
                    isLoading: viewModel.isBusy,
                  ),
                ),
              ],
            ),

            Gap(20.h),

            // Transactions List
            Expanded(
              child: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : viewModel.transactions.isEmpty
                      ? const Center(child: Text("No transactions yet."))
                      : ListView.builder(
                          itemCount: viewModel.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = viewModel.transactions[index];
                            return ListTile(
                              leading: Icon(
                                transaction.transactionType ==
                                        TransactionType.cashIn
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: transaction.transactionType ==
                                        TransactionType.cashIn
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text(
                                transaction.transactionType.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              subtitle: Text(transaction.referenceNote ?? ''),
                              trailing: Text(
                                "P${transaction.amount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  WalletViewModel viewModelBuilder(BuildContext context) => WalletViewModel();

  @override
  void onViewModelReady(WalletViewModel viewModel) {
    viewModel.fetchWalletData();
  }
}
