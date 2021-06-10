import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:save_lives/common/youtubePlyr.dart';
import 'package:url_launcher/url_launcher.dart';

class refContent extends StatelessWidget {
  String contentTitle;
  List<List<String>> ytVids, webPages;
  String remember;

  refContent(this.contentTitle, this.ytVids, this.webPages, this.remember);

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    //build widget list
    List<Widget> wLst = [];
    int countWidget = 0;
    //title
    wLst.add(SizedBox(
      height: normalFontSize * 1.8,
    ));
    wLst.add(SizedBox(
        width: sw * 0.90,
        child: Text(
          this.contentTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: normalFontSize * 2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )));
    wLst.add(SizedBox(height: normalFontSize * 1.8));

    //video
    //sub title
    wLst.add(Text(
      'Learn from videos:',
      style: TextStyle(
        fontSize: normalFontSize,
        color: Color(0xff4c7031),
      ),
    ));
    wLst.add(SizedBox(height: normalFontSize));

    countWidget = this.ytVids.length;
    for (int i = 0; i < countWidget; i++) {
      wLst.add(ytPlyr(this.ytVids[i][0], this.ytVids[i][1], this.ytVids[i][2],
          this.ytVids[i][3]));
      wLst.add(SizedBox(height: sw * 0.05));
    }
    //webpages
    //wLst.add(SizedBox(height: normalFontSize * 0.80));
    if (this.webPages[0][0].compareTo('no') != 0) {
      //intro txt
      wLst.add(SizedBox(height: normalFontSize * 0.80));
      wLst.add(Text(
        'Learn from websites:',
        style: TextStyle(
          fontSize: normalFontSize,
          color: Color(0xff4c7031),
        ),
      ));
      wLst.add(SizedBox(height: normalFontSize));

      countWidget = this.webPages.length;
      for (int i = 0; i < countWidget; i++) {
        wLst.add(WebsiteLink(
          this.webPages[i][0],
          this.webPages[i][1],
          this.webPages[i][2],
          this.webPages[i][3],
        ));
        wLst.add(SizedBox(height: sw * 0.05));
      }
    }

    //remember
    if (this.remember.compareTo('no') != 0) {
      //not equal to no
      wLst.add(SizedBox(height: normalFontSize * 0.80));
      wLst.add(Text(
        'Summary',
        style: TextStyle(
          fontSize: normalFontSize,
          color: Color(0xff4c7031),
        ),
      ));
      wLst.add(SizedBox(height: normalFontSize));
      wLst.add(Container(
        width: sw * 0.85,
        padding: EdgeInsets.all(normalFontSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(normalFontSize),
          color: Colors.green,
        ),
        child: SizedBox(
            width: sw * 0.70,
            child: Text(
              this.remember,
              style: TextStyle(
                  color: Colors.white, fontSize: normalFontSize, height: 1.9),
            )),
      ));
      wLst.add(SizedBox(height: normalFontSize * 1.8));
    }

    wLst.add(appQuote());

    return SafeArea(
      child: Scaffold(
        drawer: DrawerUi(),
        body: Padding(
          padding: EdgeInsets.only(
              top: sw * 0.05, left: sw * 0.05, right: sw * 0.05),
          child: Column(
            children: <Widget>[
              //dr
              SizedBox(
                width: sw * 0.90,
                child: Padding(
                  padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                  child: drawerButton(),
                ),
              ),
              SizedBox(
                height: sw * 0.05,
              ),
              //scroll
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: wLst,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebsiteLink extends StatelessWidget {
  //attri
  final String img, txt, addr, url;
  //constructor
  WebsiteLink(this.img, this.txt, this.addr, this.url);

  Future<int> _launchWebView(String url) async {
    int r = 1;
    if (await canLaunch(url)) {
      r = 1;
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      r = 0;
    }
    return r;
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.60;
    return InkWell(
      onTap: () async {
        if (await _launchWebView(this.url) == 0) {
          //show err msg
          showDialog<void>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Could not launch web view'),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK')),
              ],
            ),
          );
        }
      },
      child: Container(
        width: sw * 0.87,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(normalFontSize * 0.30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
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
              imgs(sw * 0.87 * 0.30, sw * 0.87 * 0.30, normalFontSize * 0.50,
                  this.img),
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
              this.addr,
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
