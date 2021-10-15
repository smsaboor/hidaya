import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/model/quran.dart';

import '../bloc/quran_theme/quran_theme_bloc.dart';
import 'package:flutter/services.dart';
import 'share_with_image.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'sample.dart';

class ShareWithImage extends StatefulWidget {
  final Quran quran;

  ShareWithImage(this.quran);

  @override
  _ShareWithImageState createState() => _ShareWithImageState();
}

class _ShareWithImageState extends State<ShareWithImage> {
  _ShareWithImageState();

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) => _snackbarDefault());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bottomNavbar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Text',
        ),
        //hide show text & font Size & align text & shadow text & color text with color opacity & font text
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Background',
        ),
        // Size of card with width height & Color with opacity & image of background
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Effect',
          // blur image, shadow text , color opacity
        ),
      ],
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
      unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
      onTap: (int index) async {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Background'),
          actions: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: Text('Share'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomNavbar(),
        bottomSheet: selectedIndex == 0
            ? getBottomSheet1()
            : selectedIndex == 1
                ? GeolocatorWidget()
                : getBottomSheet3(),
        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 4.0, right: 4.0),
                child: Column(
                  children: [
                    Container(
                      height: 250.h,
                      width: 400.w,
                      child: Expanded(
                        child: Card(
                          elevation: 4.0,
                          clipBehavior: Clip.antiAlias,
                          color: Colors.black12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  state.withArabs
                                      ? '${widget.quran.arabicText}'
                                      : '${widget.quran.withoutAerab}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        fontFamily: 'Uthman',
                                        fontSize: state.quranFontSize,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              if (state.showTranslation)
                                Container(
                                  child: Text(
                                    '${widget.quran.urduTranslation}',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Jameel',
                                          fontSize: state.translationFontSize,
                                        ),
                                  ),
                                ),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.bottomLeft,
                      child: Text("Asa Quraan"),
                    ),
                  ],
                )),
            Row(
              children: [
                Card(
                    color: Colors.green,
                    child:
                        FlatButton(onPressed: () {}, child: Text("Header 1"))),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget getBottomSheet1() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 4.0, right: 4.0),
              child: Card(
                color: Colors.deepOrangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                            height: 50, child: Text("Postpone Start 1")),
                      ),
                      SizedBox(height: 50, child: Text("Postpone Start 1")),
                      SizedBox(height: 50, child: Text("Postpone Start 1")),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Card(
                    color: Colors.green,
                    child:
                        FlatButton(onPressed: () {}, child: Text("Header 1"))),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget getBottomSheet2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
              child: Card(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                            height: 50, child: Text("Postpone Start2")),
                      ),
                      SizedBox(height: 50, child: Text("Postpone Start2")),
                      SizedBox(height: 50, child: Text("Postpone Start2")),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Card(
                    color: Colors.orange,
                    child:
                        FlatButton(onPressed: () {}, child: Text("Header2"))),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget getBottomSheet3() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
              child: Card(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                            height: 50, child: Text("Postpone Start3")),
                      ),
                      SizedBox(height: 50, child: Text("Postpone Start3")),
                      SizedBox(height: 50, child: Text("Postpone Start3")),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Card(
                    color: Colors.amber,
                    child:
                        FlatButton(onPressed: () {}, child: Text("Header3"))),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
