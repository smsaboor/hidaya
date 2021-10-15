import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamari_quraan/src/core/notification/notification_service.dart';

import '../../../core/util/bloc/location/location_bloc.dart';
import '../../../core/util/bloc/notification/notification_bloc.dart';
import '../../../core/util/bloc/prayer_timing_bloc/timing_bloc.dart';
import '../../../core/util/constants.dart';
import '../../utils/loading_widget.dart';
import '../bloc/tab/tab_bloc.dart';
import 'sirat_bottom_tab.dart';

import '../../../core/util/bloc/juz/juz_bloc.dart';
import '../../../core/util/bloc/surah/surah_bloc.dart';
import '../../bottom_tab/bloc/tab/tab_bloc.dart' as btb;
import 'package:hamari_quraan/src/features/quran/cubit/quran_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamari_quraan/src/features/quran/screen/option_screen.dart';


import '../../../../src/features/allah_name/screen/allah_name_screen.dart';
import '../../../../src/features/bottom_tab/screen/tab_screen.dart';
import '../../../../src/features/download/screen/download_screen.dart';
import '../../../../src/features/dua/screen/dua_screen.dart';
import '../../../../src/features/error/screen/database_error_screen.dart';
import '../../../../src/features/permission/screen/location_permission_screen.dart';
import '../../../../src/features/permission/screen/notification_permission_screen.dart';
import '../../../../src/features/prayer_timing/screen/prayer_timing_screen.dart';
import '../../../../src/features/qibla/screen/qibla_screen.dart';
import '../../../../src/features/quran/screen/quran_screen.dart';
import '../../../../src/features/setting/screen/thankyou_screen.dart';
import '../../../../src/features/splash/screen/splash_screen.dart';
import '../../../../src/features/tasbih/screen/tasbih_screen.dart';

class TabScaffold extends StatefulWidget {
  const TabScaffold();

  @override
  State<TabScaffold> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold> {
  final String _userAvatar = "https://randomuser.me/api/portraits/men/46.jpg";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    BlocProvider.of<TimingBloc>(context).add(
      RequestTiming(
        BlocProvider.of<NotificationBloc>(context).state.status,
        BlocProvider.of<LocationBloc>(context).state,
      ),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimingBloc, TimingState>(
      builder: (context, state) {
        if (state is TimingLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: LoadingWidget(),
          );
        }
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child:
          Container(
            width: 250,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(31, 38, 135, 0.4),
                    blurRadius: 8.0,
                  )
                ],
                border: Border(
                    right: BorderSide(
                      color: Colors.black,
                    ))),
            child: Stack(
              children: [
                SizedBox(
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.white.withOpacity(0.2),
                          ])),
                    ),
                  ),
                ),
                Column(
                  children: [
                    DrawerHeader(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(_userAvatar),
                            radius: 30.0,
                          ),
                          SizedBox(
                            width: 20,
                            height: 40,
                          ),
                          Text("User Name"),

                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(0));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/navigation_icon/svg/home_fill.svg',
                              width: 25,
                            ),
                            title: Text("Home",),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                            focusColor: Colors.amberAccent,
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(2));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/quran.svg',
                              width: 30,
                            ),
                            title: Text("Quran"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(1));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/hadees.svg',
                              width: 30,
                            ),
                            title: Text("Hadees"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const DuaScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/duas.svg',
                              width: 30,
                            ),
                            title: Text("Dua"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const TasbihScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/tasbih.svg',
                              width: 30,
                            ),
                            title: Text("Tasbih"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const AllahNameScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/allah.svg',
                              width: 30,
                            ),
                            title: Text("99 Names of Allah"),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const PrayerTimingScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/prayer_time_1.svg',
                              width: 30,
                            ),
                            title: Text("Prayer Times"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const QiblaScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/collection_icon/svg/kiblat.svg',
                              width: 30,
                            ),
                            title: Text("Qibla Direcion"),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(3));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/navigation_icon/svg/bookmark_fill.svg',
                              width: 20,
                              color: Colors.amberAccent,
                            ),
                            title: Text("Bookmark"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<btb.TabBloc>(context).add(btb.SetTab(4));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/navigation_icon/svg/setting_fill.svg',
                              width: 20,
                              color: Colors.amberAccent,
                            ),
                            title: Text("App Setting"),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const OptionScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/navigation_icon/svg/setting_fill.svg',
                              width: 20,
                              color: Colors.amberAccent,
                            ),
                            title: Text("Quran Setting"),
                          ),ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (_) => const ThankyouScreen()));
                            },
                            leading: SvgPicture.asset(
                              'assets/images/navigation_icon/svg/setting_fill.svg',
                              width: 20,
                              color: Colors.amberAccent,
                            ),
                            title: Text("Thank You!"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),),
          bottomNavigationBar: SiratNavigationBar(),
          body: BlocBuilder<TabBloc, TabState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: kAnimationDuration,
                switchInCurve: kAnimationCurve,
                child: state.screen,
              );
            },
          ),
        );
      },
    );
  }
}
