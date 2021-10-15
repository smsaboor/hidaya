import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/location/location_bloc.dart';
import '../../../core/util/constants.dart';
import '../../error/widget/failure_widget.dart';
import '../../utils/loading_widget.dart';
import '../blocs/angle_bloc/angle_bloc.dart';
import '../blocs/qibla_bloc/qibla_bloc.dart';
import '../controller/qibla_controller.dart';
import 'compass.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QiblaScaffold extends StatefulWidget {
  const QiblaScaffold();

  @override
  State<QiblaScaffold> createState() => _QiblaScaffoldState();
}

class _QiblaScaffoldState extends State<QiblaScaffold> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<QiblaBloc>(context).add(
      RequestQiblahDirection(
        BlocProvider.of<LocationBloc>(context).state,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Qiblah Direction',
        ),
      ),
      body: BlocBuilder<QiblaBloc, QiblaState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: kAnimationDuration,
            reverseDuration: Duration.zero,
            switchInCurve: kAnimationCurve,
            child: (state is QiblaLoading)
                ? LoadingWidget()
                : (state is QiblaLoaded)
                    ? SafeArea(
                        child: Container(
                          width: 1.sw,
                          padding: kPagePadding,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Text(
                                    '${state.direction.toStringAsFixed(0)}°',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    getDirectionText(
                                      state.direction.floor(),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: BlocProvider.value(
                                  value: AngleBloc(state.direction),
                                  child: Compass(),
                                ),
                              ),
                              Text(
                                'Rotate your phone until the Kabaa \n is in the center to pray towards.',
                                style:
                                Theme.of(context).textTheme.headline6,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30, top: 70, right: 30, bottom: 50),
                                height: 80.h,
                                width: 350.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  SizedBox(width: 15,),
                                  SvgPicture.asset(
                                    'assets/images/navigation_icon/svg/home_fill.svg',
                                    width: 45.w,
                                  ),
                                  SizedBox(width: 10,),
                                    Text(
                                      '${state.direction.toStringAsFixed(0)}°',
                                      style:
                                      Theme.of(context).textTheme.headline5,
                                    ),
                                  SizedBox(width: 5,),
                                  Text(
                                    'Mecca, Saudi Arabia°',
                                    style:
                                    Theme.of(context).textTheme.headline6,
                                  ),
                                ],),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : (state is QiblaFailed)
                        ? SafeArea(
                            child: FailureWidget(
                              state.failure,
                              () {
                                BlocProvider.of<LocationBloc>(context).add(
                                  InitLocation(),
                                );
                              },
                              withAppbar: true,
                            ),
                          )
                        : Container(),
          );
        },
      ),
    );
  }
}
