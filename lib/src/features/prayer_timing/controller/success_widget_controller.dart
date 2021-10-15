import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/time_format/time_format_bloc.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/controller/timing_controller.dart';
import '../../../core/util/model/timing.dart';

enum TimingProps {
  Fajr,
  Dhuhr,
  Asr,
  Maghrib,
  Isha,
}



Map<TimingProps, String> backgroundAsset = {
  TimingProps.Fajr: 'assets/images/praying_time/svg/morning.svg',
  TimingProps.Dhuhr: 'assets/images/praying_time/svg/noon.svg',
  TimingProps.Asr: 'assets/images/praying_time/svg/afternoon.svg',
  TimingProps.Maghrib: 'assets/images/praying_time/svg/evening.svg',
  TimingProps.Isha: 'assets/images/praying_time/svg/night.svg',
};

class SuccessWidgetController {
  final Timings timings;
  final BuildContext context;
  late final int timingCount;
  late final List<Map<String, String>> timingsList;

  SuccessWidgetController(this.timings, this.context) {
    final controller = TimingController(timings);
    timingCount = controller.timingCount;
    timingsList = controller.timingsList;
  }
   int timingCount2=4;
   int timingCount3=3;
   List<String> timingsList2= ["Tahjjud","Ishraq","Chast","Awwabin"];
   List<String> timingsList3= ["Tulu (at the time of sunrise)","Istiwa (at midday)","Ghurub (at the time of sunset)"];

  String setBackgroundImage() {
    switch (timingCount) {
      case 0:
        return backgroundAsset[TimingProps.Fajr]!;
      case 1:
        return backgroundAsset[TimingProps.Dhuhr]!;
      case 2:
        return backgroundAsset[TimingProps.Asr]!;
      case 3:
        return backgroundAsset[TimingProps.Maghrib]!;
      case 4:
        return backgroundAsset[TimingProps.Isha]!;
      default:
        return backgroundAsset[TimingProps.Fajr]!;
    }
  }
  String setBackgroundImageNafil() {
    switch (timingCount2) {
      case 0:
        return backgroundAsset[TimingProps.Isha]!;
      case 1:
        return backgroundAsset[TimingProps.Fajr]!;
      case 2:
        return backgroundAsset[TimingProps.Dhuhr]!;
      case 3:
        return backgroundAsset[TimingProps.Maghrib]!;
        //END OF NAFIL NAMAZ
      default:
        return backgroundAsset[TimingProps.Isha]!;
    }
  }
  String setBackgroundImageMakruh() {
    switch (timingCount3) {
      case 0:
        return backgroundAsset[TimingProps.Fajr]!;
      case 1:
        return backgroundAsset[TimingProps.Dhuhr]!;
    //END OF mAKRUH NAMAZ
      default:
        return backgroundAsset[TimingProps.Asr]!;
    }
  }

  String generateIslamicDate(Timing timing) {
    return '${timing.data.date.hijri.weekday.en}, ${timing.data.date.hijri.day} ${timing.data.date.hijri.month.en}, ${timing.data.date.hijri.year}';
  }

  List<Widget> generateTimingList(int i) {
    List<String> timingsListGen=[];
    int lenght=0;
    int timingCountGen=0;
    if(i==1){timingCountGen=timingCount;};
    if(i==2){timingsListGen=timingsList2;lenght=timingsList2.length;timingCountGen=timingCount2;};
    if(i==3){timingsListGen=timingsList3;lenght=timingsList3.length;timingCountGen=timingCount3;};
    return List.generate(
      i==0 ? timingsList.length : lenght,
      (index) => Container(
        decoration: index == timingCountGen
            ? BoxDecoration(
                color: kDarkPlaceholder.withOpacity(0.8),
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              )
            : null,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                i==0 ? timingsList[index].entries.first.key : timingsListGen[index],
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            Expanded(
              child: BlocBuilder<TimeFormatBloc, TimeFormatState>(
                builder: (context, state) {
                  return Text(
                    state.is24
                        ? timingsList[index].entries.first.value
                        : convertTimeTo12HourFormat(
                            timingsList[index].entries.first.value),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
