import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: const KazeAppBar(),
      body:
          viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Matches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child:
                          viewModel.matches.isEmpty
                              ? const Text('No matches available.')
                              : ListView.builder(
                                itemCount: viewModel.matches.length,
                                itemBuilder: (context, index) {
                                  final match = viewModel.matches[index];
                                  return ListTile(
                                    title: Text(match.matchTitle),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(match.matchDescription),
                                        Text(
                                          'Creator Bet: P${match.creatorBetAmount.toStringAsFixed(2)} - Opponent Bet: P${match.opponentBetAmount.toStringAsFixed(2)}',
                                        ),
                                      ],
                                    ),
                                    onTap: () => viewModel.navigateToMatchDetails(match),
                                    trailing:
                                        match.inviteLink != null
                                            ? IconButton(
                                              icon: const Icon(Icons.share),
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(text: match.inviteLink!));
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Link copied to clipboard')),
                                                );
                                              },
                                            )
                                            : null,
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
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.fetchHomeMatches();
  }
}
