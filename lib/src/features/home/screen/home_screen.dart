import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/appbar_bloc/appbar_bloc.dart';
import '../widget/home_sliver_appbar.dart';
import '../widget/home_sliver_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/util/bloc/juz/juz_bloc.dart';
import '../../../core/util/bloc/surah/surah_bloc.dart';
import '../../bottom_tab/bloc/tab/tab_bloc.dart' as btb;
import 'package:hamari_quraan/src/features/quran/cubit/quran_cubit.dart';

import 'package:hamari_quraan/src/features/quran/screen/option_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppbarBloc(),
      child: ScrollView(),
    );
  }
}

class ScrollView extends StatefulWidget {
  const ScrollView();

  @override
  State<ScrollView> createState() => _ScrollViewState();
}

class _ScrollViewState extends State<ScrollView> {
  final ScrollController controller = ScrollController();

  final String _userAvatar = "https://randomuser.me/api/portraits/men/46.jpg";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.addListener(() {
      if (BlocProvider.of<AppbarBloc>(context).state.displayAppbar &&
          controller.offset < 0.2.sh) {
        BlocProvider.of<AppbarBloc>(context).add(
          ToggleDisplay(),
        );
      } else if (!BlocProvider.of<AppbarBloc>(context).state.displayAppbar &&
          controller.offset > 0.2.sh) {
        BlocProvider.of<AppbarBloc>(context).add(
          ToggleDisplay(),
        );
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
          controller: controller,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const HomeSliverAppbar(),
            const HomeSliverList(),
          ],
        );
  }
}
