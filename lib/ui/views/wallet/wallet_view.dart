import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kaze_app/common/enums/transaction_type.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago show format;

import 'wallet_viewmodel.dart';

class WalletView extends StackedView<WalletViewModel> {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, WalletViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            // Display Total Balance
            Card(
              child: ListTile(
                title: const Text("Total Balance"),
                trailing: Text(
                  "P${viewModel.totalBalance.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Display On Hold Balance
            Card(
              child: ListTile(
                title: const Text("Cash On Hold"),
                trailing: Text(
                  "P${viewModel.onHoldBalance.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ),
            ),
            // Display Available Balance
            Card(
              child: ListTile(
                title: const Text("Available Balance"),
                trailing: Text(
                  "P${viewModel.currentBalance.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
              child:
                  viewModel.isBusy
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.transactions.isEmpty
                      ? const Center(child: Text("No transactions yet."))
                      : ListView.builder(
                        itemCount: viewModel.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = viewModel.transactions[index];
                          final isCashIn = transaction.transactionType == TransactionType.cashIn;
                          final isCashOutPending = transaction.transactionType == TransactionType.cashOutPending;

                          return ListTile(
                            leading: Icon(
                              isCashIn ? Icons.arrow_downward : Icons.arrow_upward,
                              color:
                                  isCashIn
                                      ? Colors.green
                                      : isCashOutPending
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                            title: Text(
                              transaction.transactionType == TransactionType.cashInPending ||
                                      transaction.transactionType == TransactionType.cashOutPending
                                  ? transaction.transactionType.toString()
                                  : transaction.referenceNote.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: isCashOutPending ? Colors.orange : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              transaction.transactionType == TransactionType.cashOut && transaction.processedAt != null
                                  ? timeago.format(transaction.processedAt!)
                                  : timeago.format(transaction.createdAt),
                            ),

                            trailing: Text(
                              "P${transaction.amount.toStringAsFixed(2)}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
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
    viewModel.subscribeToWalletData();
  }
}
