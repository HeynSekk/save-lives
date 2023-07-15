import 'package:flutter/material.dart';
import 'package:save_lives/common/yt_player.dart';
import 'package:save_lives/models/themeManager.dart';
import 'common.dart';
import 'package:provider/provider.dart';

class YtVideoInfoUi extends StatefulWidget {
  String vidUrl;
  String img, txt, channelName;
  YtVideoInfoUi(this.vidUrl, this.img, this.txt, this.channelName);
  @override
  _YtVideoInfoUiState createState() => new _YtVideoInfoUiState(
      this.vidUrl, this.img, this.txt, this.channelName);
}

class _YtVideoInfoUiState extends State<YtVideoInfoUi> {
  String vidUrl, img, txt, channelName;
  _YtVideoInfoUiState(this.vidUrl, this.img, this.txt, this.channelName);

  @override
  initState() {
    super.initState();
  }

  void playYoutubeVideo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => YtPlayer(
          vdUrl: vidUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.60;
    return InkWell(
      onTap: playYoutubeVideo,
      child: Container(
        width: sw * 0.90,
        decoration: BoxDecoration(
          color: Color(t.linkBtn),
          borderRadius: BorderRadius.circular(normalFontSize * 0.30),
        ),
        padding: EdgeInsets.all(sw * 0.87 * 0.07),
        margin: EdgeInsets.only(left: 5),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Imgs(sw * 0.87 * 0.25, sw * 0.87 * 0.28 * 1.10, 0,
                  'assets/images/ytLogo.png'),
              SizedBox(width: sw * 0.87 * 0.05),
              SizedBox(
                width: sw * 0.87 * 0.50,
                child: Text(
                  this.txt,
                  style: TextStyle(
                    fontSize: normalFontSize,
                    color: Color(t.linkBtnTxt),
                  ),
                ),
              ),
            ],
          ),
          //addr
          SizedBox(height: normalFontSize),
          SizedBox(
            width: sw * 0.70,
            child: Text(
              this.channelName,
              style: TextStyle(
                color: Color(t.linkBtnTxt),
                fontSize: normalFontSize * 0.70,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
