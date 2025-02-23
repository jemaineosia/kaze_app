import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaze_app/common/enums/match_status.dart';
import 'package:kaze_app/ui/widgets/common/kaze_button/kaze_button.dart';
import 'package:stacked/stacked.dart';

import 'match_details_viewmodel.dart';

class MatchDetailsView extends StackedView<MatchDetailsViewModel> {
  final String matchId;

  const MatchDetailsView({required this.matchId, Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MatchDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Details')),
      body:
          viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.match == null
              ? const Center(child: Text('Match not found'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Match Title: ${viewModel.match!.matchTitle}'),
                    Text('Description: ${viewModel.match!.matchDescription}'),
                    Text('Status: ${viewModel.match!.status.toValue()}'),
                    Text(
                      'Creator Bet: P${viewModel.match!.creatorBetAmount.toStringAsFixed(2)}',
                    ),
                    Text(
                      'Opponent Bet: P${viewModel.match!.opponentBetAmount.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 20),
                    // Only show the invite code if the status is waiting for opponent (pending)
                    if (viewModel.match!.status == MatchStatus.pending &&
                        viewModel.match!.inviteCode != null &&
                        viewModel.match!.inviteCode!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Invite Code: ${viewModel.match!.inviteCode}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: viewModel.match!.inviteCode!,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Invite code copied to clipboard',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    // Creator Buttons
                    if (viewModel.isCreator) ...[
                      if (viewModel.canCancel)
                        KazeButton(
                          text: 'Cancel Match',
                          onTap: viewModel.cancelMatch,
                          isLoading: viewModel.isBusy,
                        ),
                      if (viewModel.canDeclareWinner)
                        KazeButton(
                          text: 'Declare Winner',
                          onTap: viewModel.declareWinner,
                          isLoading: viewModel.isBusy,
                        ),
                    ],
                    // Opponent Buttons
                    if (viewModel.isOpponent) ...[
                      if (viewModel.canAccept)
                        KazeButton(
                          text: 'Accept Match',
                          onTap: viewModel.acceptMatch,
                          isLoading: viewModel.isBusy,
                        ),
                      const SizedBox(height: 10),
                      if (viewModel.canDecline)
                        KazeButton(
                          text: 'Decline Match',
                          onTap: viewModel.declineMatch,
                          isLoading: viewModel.isBusy,
                        ),
                      const SizedBox(height: 10),
                      if (viewModel.canCancel)
                        KazeButton(
                          text: 'Cancel Match',
                          onTap: viewModel.cancelMatch,
                          isLoading: viewModel.isBusy,
                        ),
                      const SizedBox(height: 10),
                      if (viewModel.canDeclareWinner)
                        KazeButton(
                          text: 'Declare Winner',
                          onTap: viewModel.declareWinner,
                          isLoading: viewModel.isBusy,
                        ),
                    ],
                  ],
                ),
              ),
    );
  }

  @override
  MatchDetailsViewModel viewModelBuilder(BuildContext context) =>
      MatchDetailsViewModel(matchId);

  @override
  void onViewModelReady(MatchDetailsViewModel viewModel) {
    viewModel.fetchMatch();
  }
}
