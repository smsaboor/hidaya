import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/bloc/location/location_bloc.dart';
import '../../../core/util/bloc/prayer_timing_bloc/timing_bloc.dart';
import '../../../core/util/constants.dart';
import '../../error/widget/failure_widget.dart';
import '../../utils/loading_widget.dart';
import 'success_widget.dart';

class TimingScreenScaffold extends StatelessWidget {
  TimingScreenScaffold();

  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor:
            Theme
                .of(context)
                .appBarTheme
                .backgroundColor!
                .withOpacity(0.3),
            elevation: 0,
            title: Text('Prayer Timing'),
            bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(text: 'Farz Timing',),
                  Tab(text: 'Nawafil Timing',),
                  Tab(text: 'Makruh Timing',),
                ]
            ),
          ),
          body: BlocBuilder<TimingBloc, TimingState>(
            builder: (context, state) {
              return TabBarView(controller: tabController, children: [
                AnimatedSwitcher(
                  duration: kAnimationDuration,
                  reverseDuration: Duration.zero,
                  switchInCurve: kAnimationCurve,
                  child: (state is TimingLoading)
                      ? LoadingWidget()
                      : (state is TimingLoaded)
                      ? SuccessWidget(state.timing,1)
                      : (state is TimingFailed)
                      ? Container(
                    child: FailureWidget(
                      state.failure,
                          () {
                        BlocProvider.of<LocationBloc>(context)
                            .add(
                          InitLocation(),
                        );
                      },
                      withAppbar: true,
                    ),
                  )
                      : Container(),
                ),
                AnimatedSwitcher(
                  duration: kAnimationDuration,
                  reverseDuration: Duration.zero,
                  switchInCurve: kAnimationCurve,
                  child: (state is TimingLoading)
                      ? LoadingWidget()
                      : (state is TimingLoaded)
                      ? SuccessWidget(state.timing,2)
                      : (state is TimingFailed)
                      ? Container(
                    child: FailureWidget(
                      state.failure,
                          () {
                        BlocProvider.of<LocationBloc>(context)
                            .add(
                          InitLocation(),
                        );
                      },
                      withAppbar: true,
                    ),
                  )
                      : Container(),
                ),
                AnimatedSwitcher(
                  duration: kAnimationDuration,
                  reverseDuration: Duration.zero,
                  switchInCurve: kAnimationCurve,
                  child: (state is TimingLoading)
                      ? LoadingWidget()
                      : (state is TimingLoaded)
                      ? SuccessWidget(state.timing,3)
                      : (state is TimingFailed)
                      ? Container(
                    child: FailureWidget(
                      state.failure,
                          () {
                        BlocProvider.of<LocationBloc>(context)
                            .add(
                          InitLocation(),
                        );
                      },
                      withAppbar: true,
                    ),
                  )
                      : Container(),
                )
              ]);
            },
          ),
        ));
  }
}
