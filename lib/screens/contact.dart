import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
//import 'package:url_launcher/url_launcher.dart';

class contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: drawerUI(),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            sideStick(),
            Padding(
              padding: EdgeInsets.only(
                top: sh * 0.11,
                bottom: sh * 0.11 * (1 / 5),
                left: sh * 0.11 * (1 / 5),
                right: sh * 0.11 * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  body_content(),
                  SizedBox(
                    height: sw * 0.80 * 0.07 * 2,
                  ),
                  addr('assets/images/gmailIcon.png', 'heynxsehhz@gmail.com'),
                  SizedBox(
                    height: sw * 0.80 * 0.07,
                  ),
                  /*InkWell(
                  onTap: ()=> ul.launch('https://m.me/HeynSekk'),
                  child: addr('assets/images/msgrIcon.png', 'Heyn Sekk'),
                ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class addr extends StatelessWidget {
  String iconImg, txt;
  addr(this.iconImg, this.txt);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //icon
        ImageInApp(sw * 0.80 * 0.09, sw * 0.80 * 0.09, this.iconImg),
        SizedBox(width: sw * 0.80 * 0.07),
        //addr text
        SizedBox(
          width: sw * 0.70,
          child: Text(this.txt,
              style: TextStyle(
                //color: Colors.black,
                fontSize: sw * 0.80 * 0.07,
                decoration: TextDecoration.underline,
              )),
        ),
      ],
    );
  }
}

class body_content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.80,
      child: Text(
        'loren',
        style: TextStyle(
          color: Colors.black,
          fontSize: sw * 0.80 * 0.07,
        ),
      ),
    );
  }
}
