import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'match_details_viewmodel.dart';

class MatchDetailsView extends StackedView<MatchDetailsViewModel> {
  final String matchId;

  const MatchDetailsView({required this.matchId, Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, MatchDetailsViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Details')),
      body:
          viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.match == null
              ? const Center(child: Text('Match not found'))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Match Title: ${viewModel.match!.matchTitle}'),
                  Text('Description: ${viewModel.match!.matchDescription}'),
                  Text('Status: ${viewModel.match!.status.toValue()}'),
                  if (viewModel.isCreator)
                    ElevatedButton(
                      onPressed: viewModel.canEdit ? viewModel.editMatch : null,
                      child: const Text('Edit Match'),
                    ),
                  if (viewModel.canCancel)
                    ElevatedButton(onPressed: viewModel.cancelMatch, child: const Text('Cancel Match')),
                  if (viewModel.canDeclareWinner)
                    ElevatedButton(onPressed: viewModel.declareWinner, child: const Text('Declare Winner')),
                ],
              ),
    );
  }

  @override
  MatchDetailsViewModel viewModelBuilder(BuildContext context) => MatchDetailsViewModel(matchId);

  @override
  void onViewModelReady(MatchDetailsViewModel viewModel) {
    viewModel.fetchMatch();
  }
}
