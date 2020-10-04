import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'common.dart';

class ytPlyr extends StatefulWidget {
  String vidUrl;
  String img, txt, channelName;
  ytPlyr(this.vidUrl, this.img, this.txt, this.channelName);
  @override
  _ytPlyrState createState() =>
      new _ytPlyrState(this.vidUrl, this.img, this.txt, this.channelName);
}

class _ytPlyrState extends State<ytPlyr> {
  String vidUrl, img, txt, channelName;
  _ytPlyrState(this.vidUrl, this.img, this.txt, this.channelName);

  @override
  initState() {
    super.initState();
  }

  void playYoutubeVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "AIzaSyA2Ts_Q8lPAESIY4xTepuSr2yW2smMZg1g",
      videoUrl: this.vidUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.60;
    return InkWell(
      onTap: playYoutubeVideo,
      child: Container(
        width: sw * 0.87,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(normalFontSize * 0.30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.3,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(sw * 0.87 * 0.07),
        margin: EdgeInsets.only(left: 5),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              imgs(sw * 0.87 * 0.25, sw * 0.87 * 0.28 * 1.10, 0,
                  'assets/images/ytLogo.png'),
              SizedBox(width: sw * 0.87 * 0.05),
              SizedBox(
                width: sw * 0.87 * 0.50,
                child: Text(
                  this.txt,
                  style: TextStyle(
                    fontSize: normalFontSize,
                    color: Color(0xff353335),
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
                color: Color(0xff555555),
                fontSize: normalFontSize * 0.70,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

/*
class ytLogo extends StatelessWidget {
  double height, width;
  ytLogo(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(this.height*0.25),
      ),
      child: Center(
        child: ,
      ),
    );
  }
}
*/
