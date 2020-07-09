import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';

//MAIN UI
class catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.8;
    double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: drawerUI(),
      body: SafeArea(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          sideStick(),
          Padding(
            padding: EdgeInsets.only(
              //top: sHeight * 0.07,
              bottom: sHeight * 0.11 * (1 / 5),
              left: 0, //sHeight * 0.11 * (1 / 5),
              right: sHeight * 0.11 * (1 / 5),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  //TITLE
                  SizedBox(
                    height: sHeight*0.03
                  ),
                  catalogTitle('Learn First Aids to Save Lives'),
                  SizedBox(
                    height: wRow * 0.15 * 0.43,
                  ),
                  subTitle('The fundamentals'),
                  menuItemNormal('assets/images/priSurAd.png', 'Primry Survey', '/priSurAd'),
                  menuItemNormal('assets/images/priSurBa.png','Primary Survey (Baby)', '/priSurBa'),
                  menuItemNormal('assets/images/recPosAd.png','Recovery position (adult)', '/recPosAd'),
                  menuItemNormal('assets/images/recPosBa.png','Recovery position (baby)', '/recPosBa'),

                  //LIST
                  subTitle('Common first aids'),
                  menuItemFirst('assets/images/chokAd.png', 'Choking (adult)','/chokAd', 'C'),
                  menuItemNormal('assets/images/chokBaby.png', 'Choking (baby)','/chokBaby'),
                  menuItemNormal('assets/images/chokChi.png', 'Choking (child)','/chokChi'),
                  //menuItemNormal('assets/images/cprAd.png', 'CPR for adult', '/adCpr'),
                  menuItemNormal('assets/images/cprBaby.png', 'CPR for baby', '/babyCpr'),
                  menuItemNormal('assets/images/cprChild.png', 'CPR for child','/childCpr'),

                  //menuItemFirst('assets/images/heaAtt.png', 'Heart attack','/heaAtt','H'),
                  menuItemNormal('assets/images/heaInj.png', 'Head injuries in children, babies','/heaInj'),
                  menuItemFirst('assets/images/seiAd.png', 'Seizure (adult)','/seiAd','S'),
                  /*menuItemNormal('assets/images/seiBa.png', 'Seizure (baby)','/seiBa'),
                  menuItemNormal('assets/images/seiChi.png', 'Seizure (children)','/seiChi'),
                  menuItemNormal('assets/images/sevBl.png', 'Severe bleeding','/sevBl'),
                  menuItemNormal('assets/images/sevBlBa.png', 'Severe bleeding (baby)','/sevBlBa'),
                  menuItemNormal('assets/images/sho.png', 'Shock','/sho'),
                  menuItemNormal('assets/images/snak.png', 'Snake Bite','/snak'),*/
                ],
              ),
            ),
          ),
        ],
      ),

      ), 
      
    );
  }
}

//TITLE
class catalogTitle extends StatelessWidget {
  String title;
  catalogTitle(this.title);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.84;
    //double hTitle=mwid*0.32;
    return Row(
      children: <Widget>[
        //image
        ImageInApp(wRow * 0.15, wRow * 0.15, 'assets/images/heartIcon.png'),
        //space
        SizedBox(
          width: wRow * 0.04,
        ),
        //text
        SizedBox(
          //height: 45,
          width: wRow * 0.76,
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: wRow * 0.07,
              fontWeight: FontWeight.bold,
              //color: Colors.black,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class subTitle extends StatelessWidget {
  String title;
  subTitle(this.title);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.84;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    //double hTitle=mwid*0.32;
    return Padding(
      padding: EdgeInsets.only(bottom: normalFontSize, top: normalFontSize),
      child: SizedBox(
        width: screenWidth*0.75,
        child: Text(
        this.title,
        style: TextStyle(color: Color(0xff6BCF63), fontSize: normalFontSize),
      ),
      ), 
      
    );
  }
}

//ITEM
class menuItemFirst extends StatelessWidget {
  String iconPicPath;
  String eName, destination, alphaData;

  menuItemFirst(this.iconPicPath, this.eName, this.destination, this.alphaData);
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double screenWidth = media.size.width;
    double wRow = screenWidth * 0.75;
    double hRow = wRow * 0.47;
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.70 * 0.32 * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //tag
          alphaTag(this.alphaData),
          //space
          SizedBox(
            width: screenWidth * 0.70 * 0.32 * 0.33 * 0.25,
          ),
          //menuCtnr
          menuCtnr(this.iconPicPath, this.eName, this.destination),
        ],
      ),
    );
  }
}

class menuItemNormal extends StatelessWidget {
  String iconPicPath;
  String eName, destination;
  menuItemNormal(this.iconPicPath, this.eName, this.destination);
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double screenWidth = media.size.width;
    double wRow = screenWidth * 0.70;
    double hRow = wRow * 0.32;
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.70 * 0.32 * 0.05),
      child: menuCtnr(iconPicPath, eName, destination),
    );
  }
}

class menuCtnr extends StatelessWidget {
  String iconPicPath;
  String eName, destination;

  menuCtnr(this.iconPicPath, this.eName, this.destination);
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double screenWidth = media.size.width;
    double wRow = screenWidth * 0.75;
    double hRow = wRow * 0.47;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, this.destination);
      },
      child: Container(
        height: hRow,
        width: wRow,
        padding: EdgeInsets.only(
          top: hRow * 0.05,
          bottom: hRow * 0.05,
          left: hRow * 0.05,
          right: hRow * 0.08,
        ),
        decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //img h*.7
            imgs(hRow * 0.90, hRow * 0.90, this.iconPicPath),
            //space 1/10
            SizedBox(
              width: hRow * 0.11,
            ),
            //text 9/10
            SizedBox(
              width: wRow * 0.45,
              child: Text(
                this.eName,
                style: TextStyle(
                  fontSize: wRow * 0.075, //screenWidth * 0.75 * 0.055
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class alphaTag extends StatelessWidget {
  //attri
  String alphabet;
  //constructor
  alphaTag(this.alphabet);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double hRow = screenWidth * 0.75 * 0.47;
    return Container(
      height: hRow * (1 / 6), //screenWidth * 0.70 * 0.32 * 0.33*0.33
      width: hRow * (1 / 6),
      child: Padding(
          padding: EdgeInsets.all(0),
          child: Center(
            child: Text(
              this.alphabet,
              style: TextStyle(
                fontSize: hRow * (1 / 6),
                color: Colors.black,
                height: 1,
              ),
            ),
          )),
    );
  }
}

class imgs extends StatelessWidget {
  //attri
  double height, width;
  String path;
  //constructor
  imgs(this.height, this.width, this.path);

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: this.width,
      height: this.height, //30.0
      //alignment: Alignment.center,
      decoration: new BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.fill),
      ),
    ));
  }
}
