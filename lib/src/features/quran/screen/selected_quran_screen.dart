import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/util/constants.dart';
import '../../bottom_tab/bloc/tab/tab_bloc.dart';
import '../cubit/quran_cubit.dart' as qc;
import '../widget/juz_content.dart';
import '../widget/surah_content.dart';
import 'option_screen.dart';

class SelectedQuranScreen extends StatelessWidget {
  const SelectedQuranScreen({required this.surah});

  final bool surah;

  @override
  Widget build(BuildContext context) {
    return surah ? SurahContent() : JuzContent();
  }
}
