import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/util/constants.dart';
import '../../../core/util/controller/date_controller.dart';
import '../../../core/util/model/timing.dart';
import '../controller/success_widget_controller.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget(this.timing,this.timingType);

  final Timing timing;
  final int timingType;

  @override
  Widget build(BuildContext context) {
    final SuccessWidgetController controller = SuccessWidgetController(timing.data.timings, context);
    String imagecontroller='';
    if(timingType==1) imagecontroller=controller.setBackgroundImage();
    if(timingType==2) imagecontroller=controller.setBackgroundImageNafil();
    if(timingType==3) imagecontroller=controller.setBackgroundImageMakruh();
    return Stack(
      children: [
        Container(
          width: 1.sw,
          height: 1.sh,
          child: SvgPicture.asset(
            imagecontroller,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: kPagePadding,
                child: Text(
                  getTodayDate(),
                  style: GoogleFonts.caveat(
                    textStyle: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: kPagePadding,
                child: Text(
                  controller.generateIslamicDate(timing),
                  style: GoogleFonts.caveat(
                    textStyle: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 1.sw,
                padding: kCardPadding,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    )),
                child: Column(
                  children: controller.generateTimingList(timingType),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
