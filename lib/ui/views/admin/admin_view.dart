import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'admin_viewmodel.dart';

class AdminView extends StackedView<AdminViewModel> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed:
                viewModel.fetchPendingTransactions, // Reload transactions
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child:
            viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.getPendingTransactions == null ||
                    viewModel.getPendingTransactions!.isEmpty
                ? const Center(child: Text('No pending transactions found.'))
                : ListView.builder(
                  itemCount: viewModel.getPendingTransactions!.length,
                  itemBuilder: (context, index) {
                    final transaction =
                        viewModel.getPendingTransactions![index];
                    return Card(
                      child: ListTile(
                        title: Text('Username: ${transaction.username}'),
                        subtitle: Text('Amount: ${transaction.amount}'),
                        trailing: TextButton(
                          onPressed:
                              () =>
                                  viewModel.approveTransaction(transaction.id),
                          child: const Text('Approve'),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  @override
  AdminViewModel viewModelBuilder(BuildContext context) => AdminViewModel();

  @override
  void onViewModelReady(AdminViewModel viewModel) {
    viewModel.fetchPendingTransactions(); // Fetch transactions on load
    super.onViewModelReady(viewModel);
  }
}
