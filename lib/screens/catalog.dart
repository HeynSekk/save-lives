import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';

//MAIN UI
class catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.90;
    double sHeight = MediaQuery.of(context).size.height;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    return SafeArea(
      child: Scaffold(
        drawer: drawerUI(),
        body: Padding(
          padding: EdgeInsets.all(sw * 0.05),
          child: Column(
            children: <Widget>[
              //drawer
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //title
                        SizedBox(height: sHeight * 0.03),
                        catalogTitle('Learn First Aids to Save Lives'),
                        SizedBox(
                          height: wRow * 0.15 * 0.43,
                        ),
                        //sub title
                        SizedBox(
                          height: normalFontSize * 0.50,
                        ),
                        subTitle('Basic first aids'),
                        SizedBox(
                          height: normalFontSize * 1.2,
                        ),
                        //items
                        menuItemNormal('assets/images/cprAd.jpg',
                            'CPR for adults', '/adCpr'),
                        menuItemNormal('assets/images/cprBaby.png',
                            'CPR for babies', '/babyCpr'),
                        menuItemNormal('assets/images/cprChild.png',
                            'CPR for children', '/childCpr'),
                        menuItemNormal('assets/images/priSurAd.png',
                            'Primary Survey', '/priSurAd'),
                        menuItemNormal('assets/images/priSurBa.png',
                            'Primary Survey (Babies)', '/priSurBa'),
                        menuItemNormal('assets/images/recPosAd.png',
                            'Recovery position (adults)', '/recPosAd'),
                        menuItemNormal('assets/images/recPosBa.png',
                            'Recovery position (babies)', '/recPosBa'),

                        //LIST
                        SizedBox(
                          height: normalFontSize * 1.3,
                        ),
                        subTitle('Common health emergency conditions:'),
                        SizedBox(
                          height: normalFontSize * 1.2,
                        ),
                        menuItemFirst('assets/images/burn.png',
                            'Burn and scalds', '/burn', 'B'),
                        menuItemFirst('assets/images/chokAd.png',
                            'Choking (adults)', '/chokAd', 'C'),
                        menuItemNormal('assets/images/chokBaby.png',
                            'Choking (babies)', '/chokBaby'),
                        menuItemNormal('assets/images/chokChi.png',
                            'Choking (children)', '/chokChi'),
                        menuItemFirst('assets/images/eye.jpg', 'Eye injuries',
                            '/eye', 'E'),
                        menuItemFirst(
                            'assets/images/faint.png', 'Fainting', '/fai', 'F'),

                        //menuItemFirst('assets/images/heaAtt.png', 'Heart attack','/heaAtt','H'),
                        menuItemFirst(
                            'assets/images/heaInj.png',
                            'Head injuries in children, babies',
                            '/heaInj',
                            'H'),
                        menuItemNormal('assets/images/heaAtt.png',
                            'Heart attack', '/heaAtt'),
                        menuItemFirst('assets/images/seiAd.png',
                            'Seizure (adults)', '/seiAd', 'S'),
                        menuItemNormal('assets/images/seiBa.png',
                            'Seizure (babies)', '/seibb'),

                        //menuItemNormal('assets/images/seiBa.png', 'Seizure (baby)','/seiBa'),
                        menuItemNormal('assets/images/seiChi.png',
                            'Seizure (children)', '/seiChi'),
                        menuItemNormal('assets/images/sevBl.png',
                            'Severe bleeding', '/sevBl'),
                        menuItemNormal('assets/images/sevBlBa.png',
                            'Severe bleeding (babies)', '/sevBlBa'),
                        menuItemNormal(
                            'assets/images/sho.png', 'Shock', '/sho'),
                        menuItemNormal(
                            'assets/images/snak.png', 'Snake Bite', '/snak'),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            //title
            //sub title
            //items list
          ),
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
    double wRow = screenWidth * 0.90;
    //double hTitle=mwid*0.32;
    return Row(
      children: <Widget>[
        //heart
        Icon(
          Icons.favorite,
          size: wRow * 0.18,
          color: Colors.green,
        ),
        //ImageInApp(wRow * 0.15, wRow * 0.15, 'assets/images/heartIcon.png'),
        //space
        SizedBox(
          width: wRow * 0.03,
        ),
        //text
        SizedBox(
          //height: 45,
          width: wRow * 0.79,
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: wRow * 0.07,
              fontWeight: FontWeight.bold,
              color: Color(0xff6B6B6B),
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
    return SizedBox(
      width: screenWidth * 0.87,
      child: Text(
        this.title,
        textAlign: TextAlign.start,
        style:
            TextStyle(color: Color(0xff6B6B6B), fontSize: normalFontSize * 1.2),
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
    double sw = media.size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: sw * 0.70 * 0.32 * 0.15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //tag
          alphaTag(this.alphaData),
          //space
          SizedBox(
            width: sw * 0.01,
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
      padding: EdgeInsets.only(bottom: screenWidth * 0.70 * 0.32 * 0.15),
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
    double wRow = screenWidth * 0.83;
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
          color: Color(0xffe3e8e4),
          borderRadius: BorderRadius.circular(16.0),
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
                  color: Color(0xff353335),
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
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      height: sw * 0.06,
      width: sw * 0.06,
      child: Center(
        child: Text(
          this.alphabet,
          style: TextStyle(
            fontSize: sw * 0.05,
            color: Color(0xff353335),
            height: 1,
          ),
        ),
      ),
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
