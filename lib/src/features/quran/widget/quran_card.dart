import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/util/constants.dart';
import '../../../core/util/model/quran.dart';

import '../bloc/quran_theme/quran_theme_bloc.dart';
import 'package:flutter/services.dart';
import 'share_with_image.dart';

import 'package:url_launcher/url_launcher.dart';

class QuranCard extends StatefulWidget {
  final Quran quran;
  final bool bookmarkScreen;

  QuranCard(this.quran, {this.bookmarkScreen = false});

  @override
  _QuranCardState createState() => _QuranCardState();
}

class _QuranCardState extends State<QuranCard> {
  _QuranCardState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _modalMenu() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return _bottomSheetMenu();
      },
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
              'Surah ${widget.quran.surahId} Ayah ${widget.quran.ayatNumber}'),
          content: new Text("Copied to clipboard"),
        );
      },
    );
  }

  void _showDialogShare() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(

          title: new Text('Share Type'),
          content: Container(
            width: 300.w,
            height: 200,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Ayah with background'),
                    onTap: () {
                      Navigator.pop(context, true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShareWithImage(widget.quran)),
                      );
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (_) => new SettingsScreen()));
                    }),
                Divider(),
                ListTile(
                    leading: Icon(Icons.line_style),
                    title: Text('Ayah only'),
                    onTap: () {
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    }),
              ],
            ),),
        );
      },
    );
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(
        text: 'Allah Subhaahu Wa Ta''ala said: ${widget.quran.arabicText} "${widget.quran.urduTranslation}" ---Surah:${widget.quran.surahId}   Verse:${widget.quran.ayatId} '));
    _showDialog();
  }

  _feedback() async {
    const url = 'mailto:mca.saboor@gmail.com?subject=News Feedback';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
        builder: (context, state) {
      return GestureDetector(
        // When the user taps the button, show a snackbar.
        onTap: () {
          _modalMenu();
        },
        child: Container(
          padding: kPagePadding,
          child: Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                    width: 4.sp,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state.withArabs
                        ? '${widget.quran.arabicText}'
                        : '${widget.quran.withoutAerab}',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontFamily: 'Uthman',
                          fontSize: state.quranFontSize,
                        ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (state.showTranslation)
                    Text(
                      '${widget.quran.urduTranslation}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontFamily: 'Jameel',
                            fontSize: state.translationFontSize,
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
      );
    });
  }

  _bottomSheetMenu() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      decoration: new BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0))),
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.play_arrow),
              title: Text('Play Ayah'),
              onTap: () {}),
          Divider(),
          ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copy Ayah'),
              onTap: () {
                _copyToClipboard();
                Navigator.of(context).pop();
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.share),
              title: Text('Share Ayah'),
              onTap: () {
                Navigator.pop(context, true);
                _showDialogShare();
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Add to Bookmark'),
              onTap: () {
                Navigator.pop(context, true);
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (_) => new SettingsScreen()));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.attachment),
              title: Text('Mark as last read'),
              onTap: () {
                Navigator.pop(context, true);
                _feedback();
              }),
        ],
      ),
    );
  }
}
