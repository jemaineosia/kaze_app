import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaze_app/app/app.locator.dart';
import 'package:kaze_app/main.dart';
import 'package:kaze_app/ui/views/home/home_viewmodel.dart';
import 'package:kaze_app/ui/widgets/common/kaze_appbar/kaze_appbar.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator<HomeViewModel>();
    _viewModel.fetchHomeMatches();
    _viewModel.subscribeToMatches();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    myRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _viewModel.fetchHomeMatches();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => _viewModel,
      disposeViewModel: false,
      builder: (context, viewModel, child) {
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
                        // Row with title and "Find Match" button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Matches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ElevatedButton(onPressed: () => viewModel.findMatch(), child: const Text('Find Match')),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                                              'Status: ${match.status.toDisplay()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: match.opponentId == null ? Colors.green : Colors.orange,
                                              ),
                                            ),
                                            Text(
                                              'Creator Bet: P${match.creatorBetAmount.toStringAsFixed(2)} - Opponent Bet: P${match.opponentBetAmount.toStringAsFixed(2)}',
                                            ),
                                          ],
                                        ),
                                        onTap: () => viewModel.navigateToMatchDetails(match),
                                      );
                                    },
                                  ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
