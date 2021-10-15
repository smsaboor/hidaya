import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/routes.dart';
import '../../../core/util/bloc/prayer_timing_bloc/timing_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/date_controller.dart';
import '../../../core/util/controller/timing_controller.dart';
import '../bloc/timer_bloc/timer_bloc.dart';
import 'countdown_timer.dart';
import 'prayers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../prayer_timing/controller/success_widget_controller.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/date_controller.dart';
import '../../../core/util/model/timing.dart';
import '../../utils/loading_widget.dart';
import 'dart:core';
class PrayerTimingWidget extends StatelessWidget {
  PrayerTimingWidget();
  String? time;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.prayerTimingPage);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TimingBloc, TimingState>(
            builder: (context, state) {
              SuccessWidgetController sc;
              if (state is TimingLoaded) {
                sc=SuccessWidgetController(state.timing.data.timings, context);
                time=sc.generateIslamicDate(state.timing);
              }
              return Text('${time}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Text(
            getTodayDate(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          BlocBuilder<TimingBloc, TimingState>(
            builder: (context, state) {
              TimingController? controller;
              if (state is TimingLoaded) {
                controller = TimingController(state.timing.data.timings);
                SuccessWidgetController(state.timing.data.timings, context);
              }
              return AnimatedSwitcher(
                duration: kAnimationDuration,
                reverseDuration: Duration.zero,
                switchInCurve: kAnimationCurve,
                child: !(state is TimingLoaded)
                    ? Container()
                    : BlocProvider.value(
                  value: TimerBloc(controller!.time),
                  child: Row(children: [
                    Text(
                      '${controller.prayerPrevious}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                    ),
                    Text(
                      ' time left :',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    CountDownTimer(controller),
                  ],)
                ),
              );
            },
          ),
          Row(children: [
            Text(
              'Next Namaz :',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Prayers(),
          ],)
        ],
      ),
    );
  }
}
