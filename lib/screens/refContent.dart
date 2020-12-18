import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:save_lives/common/youtubePlyr.dart';

class refContent extends StatelessWidget {
  String contentTitle;
  List<List<String>> ytVids, webPages;
  String remember;

  refContent(this.contentTitle, this.ytVids, this.webPages, this.remember);
  //String title,vidTitle,vidUrl,webDest,remember;
  //refContent(this.title,this.vidTitle,this.vidUrl,this.webDest,this.remember);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double sHeight = MediaQuery.of(context).size.height;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    //build widget list
    var wLst = new List<Widget>();
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
        wLst.add(contLink(
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
        drawer: drawerUI(),
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

    /*Scaffold(
      drawer: drawerUI(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sideStick(),
            Padding(
              padding: EdgeInsets.only(
                //top: sHeight * 0.07*0.10,
                left: sHeight * 0.11 * 0.20,
                right: 0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: wLst),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
