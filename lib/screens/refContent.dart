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
      height: sHeight * 0.07,
    ));
    wLst.add(SizedBox(
        width: sw * 0.70,
        child: Text(
          this.contentTitle,
          style: TextStyle(
            fontSize: normalFontSize * 2,
          ),
        )));
    wLst.add(SizedBox(height: normalFontSize * 2));

    //video
    //sub title
    wLst.add(Text(
      'Learn from videos:',
      style: TextStyle(
        fontSize: normalFontSize,
        color: Color(0xff6BCF63),
      ),
    ));
    wLst.add(SizedBox(height: normalFontSize * 2));

    countWidget = this.ytVids.length;
    for (int i = 0; i < countWidget; i++) {
      wLst.add(ytPlyr(this.ytVids[i][0], this.ytVids[i][1], this.ytVids[i][2],
          this.ytVids[i][3]));
      wLst.add(SizedBox(height: normalFontSize * 2));
    }
    //webpages
    if (this.webPages[0][0].compareTo('no') != 0) {
      //intro txt
      wLst.add(Text(
        'Learn from websites:',
        style: TextStyle(
          fontSize: normalFontSize,
          color: Color(0xff6BCF63),
        ),
      ));
      wLst.add(SizedBox(height: normalFontSize * 2));

      countWidget = this.webPages.length;
      for (int i = 0; i < countWidget; i++) {
        wLst.add(contLink(
          this.webPages[i][0],
          this.webPages[i][1],
          this.webPages[i][2],
          this.webPages[i][3],
        ));
        wLst.add(SizedBox(height: normalFontSize * 2));
      }
    }

    //remember
    if (this.remember.compareTo('no')!=0) { //not equal to no
      wLst.add(Text(
        'Brief memorizing:',
        style: TextStyle(
          fontSize: normalFontSize,
          color: Color(0xff6BCF63),
        ),
      ));
      wLst.add(SizedBox(height: normalFontSize * 2));
      wLst.add(Container(
        width: sw * 0.80,
        padding: EdgeInsets.all(normalFontSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(normalFontSize),
          color: Color(0xff5EBE73),
        ),
        child: SizedBox(
            width: sw * 0.70,
            child: Text(
              this.remember,
              style: TextStyle(
                  color: Colors.white, fontSize: normalFontSize, height: 1.9),
            )),
      ));
      wLst.add(SizedBox(height: normalFontSize));
    }

    wLst.add(appQuote());

    return Scaffold(
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
                right:0,
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
    );
  }
}

/*class markLearned extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.pushNamed(context, this.dest),
      child: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          children: <Widget>[
            Row(
          children: <Widget>[
            imgs(30, 30, this.img),
            SizedBox(width: 10),
            Text(this.txt),
          ],
        ),
        Text(this.addr),

          ]
        ),
        
        

      ),
    );
  }
}*/
