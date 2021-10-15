import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/util/bloc/quran/quran_bloc.dart';
import '../../../core/util/constants.dart';
import '../bloc/selected_surah/selected_surah_bloc.dart';
import 'quran_card.dart';
import '../../../core/util/bloc/surah/surah_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/util/constants.dart';
import '../../bottom_tab/bloc/tab/tab_bloc.dart';
import '../cubit/quran_cubit.dart' as qc;
import '../widget/juz_content.dart';
import '../widget/surah_content.dart';
import '../screen/option_screen.dart';

class SurahContent extends StatefulWidget {
  const SurahContent();

  @override
  State<SurahContent> createState() => _SurahContentState();
}

class _SurahContentState extends State<SurahContent> {
  TabController? tabController;

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedSurahBloc, SelectedSurahState>(
        builder: (context, currentSurahState) {
      return BlocBuilder<QuranBloc, QuranState>(builder: (context, quranState) {
        return BlocBuilder<SurahBloc, SurahState>(builder: (context, state) {
          return DefaultTabController(
            initialIndex: state.surahs.surahs.length - 1,
            length: state.surahs.surahs.length,
            child: Scaffold(

              appBar: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 14,
                leadingWidth: 18, // <-- Use this
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,size: 20,),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (!BlocProvider.of<qc.QuranCubit>(context).state.fromNav)
                        Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      BlocProvider.of<TabBloc>(context).add(SetTab(3));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/navigation_icon/svg/bookmark_nfill.svg',
                        width: 20.w,
                        color: kDarkTextColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OptionScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/navigation_icon/svg/setting_nfill.svg',
                        width: 20.w,
                        color: kDarkTextColor,
                      ),
                    ),
                  )
                ],
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: kAppIconBorderRadius,
                      child: SvgPicture.asset(
                        'assets/images/core/svg/app_logo.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Al-Qur\'an',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                bottom: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  dragStartBehavior: DragStartBehavior.values.last,
                  tabs: List.generate(
                          state.surahs.surahs.length,
                          (index) => Tab(
                              child: Text(
                                  '${index + 1}. ${state.surahs.surahs[index].nameEn}')))
                      .reversed
                      .toList(),
                ),
              ),
              body: TabBarView(
                controller: tabController,
                children: List.generate(
                  state.surahs.surahs.length,
                  (index) => Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: kBottomSheetBorderRadius,
                      ),
                      child: ListView.builder(
                          itemCount: quranState.qurans
                              .getQuransBySurah(index + 1)
                              .length,
                          itemBuilder: (context, index2) {
                            return QuranCard(
                              quranState.qurans
                                  .getQuransBySurah(index + 1)[index2],
                            );
                          }),
                    ),
                  ),
                ).reversed.toList(),
              ),
            ),
          );
        });
      });
    });
  }
}
