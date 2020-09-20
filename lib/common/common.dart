import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class vspace extends StatelessWidget {
  double quant;
  vspace(this.quant);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.quant,
    );
  }
}

class hspace extends StatelessWidget {
  double quant;
  hspace(this.quant);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.quant,
    );
  }
}

class drawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.48;
    return InkWell(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        height: normalFontSize * 3,
        width: normalFontSize * 3,
        decoration: BoxDecoration(
          color: Color(0xffC4C4C4),
          borderRadius: BorderRadius.circular(normalFontSize * 0.80),
        ),
        child: Center(
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: normalFontSize * 2.2,
          ),
        ),
      ),
    );
  }
}

class appQuote extends StatelessWidget {
  //attri

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.48;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: normalFontSize),
        Icon(
          Icons.favorite,
          color: Color(0xff6BCF63),
          size: normalFontSize * 2,
        ),
        SizedBox(
          height: normalFontSize * 0.50,
        ),
        SizedBox(
          width: wRow,
          child: Text(
            'Learn how to save lives.\nAnd share the knowledge to others',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff1BC163),
              fontSize: normalFontSize,
            ),
          ),
        ),
        SizedBox(
          height: normalFontSize * 1.1,
        ),
      ],
    );
  }
}
//content link

class contLink extends StatelessWidget {
  //attri
  String img, txt, addr, dest;
  //constructor
  contLink(this.img, this.txt, this.addr, this.dest);

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.60;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, this.dest),
      child: Container(
        width: sw * 0.76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(normalFontSize * 0.90),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 4,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(normalFontSize * 0.80),
        margin: EdgeInsets.only(left: 5),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              imgs(sw * 0.80 * 0.30, sw * 0.80 * 0.30, normalFontSize * 0.50,
                  this.img),
              SizedBox(width: normalFontSize * 0.77),
              SizedBox(
                width: sw * 0.80 * 0.50,
                child: Text(
                  this.txt,
                  style: TextStyle(
                    fontSize: normalFontSize,
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

/*class myAppBar extends StatelessWidget {
  //attri
  Widget barTitle;
  //constructor
  myAppBar(this.barTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ,
      height: ,
    );
  }
}*/
/*
void launchURL(String urlToLaunch) async
{
  if(await canLaunch(urlToLaunch))
  {
    await launch(urlToLaunch);
  }
  else
  {
    throw 'cant launch';
  }
}*/

class imgs extends StatelessWidget {
  //attri
  double height, width, bRadi;
  String path;
  //constructor
  imgs(this.height, this.width, this.bRadi, this.path);

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: this.width,
      height: this.height, //30.0
      //alignment: Alignment.center,
      decoration: new BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(this.bRadi),
        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.fill),
      ),
    ));
  }
}

class ImageInApp extends StatelessWidget {
  //attri
  double height, width;
  String path;
  //constructor
  ImageInApp(this.height, this.width, this.path);

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: this.height,
      height: this.width, //30.0
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        //color: Colors.green,
        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.fill),
      ),
    ));
  }
}

//SIDE STICK
class sideStick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //sw*(1/11)
    double sw = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //tight, flex 1/15
        //flex 2/15
        //12/15

        //first
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Container(
            //height: 4,
            width: sw * 0.022, //15
            color: Colors.green,
          ),
        ),
        //second
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: InkWell(
            child: Container(
              //height: 4,
              width: sw * (1 / 20) * 2, //40
              child: Center(
                  child: Icon(
                Icons.menu,
                color: Colors.white,
                //size: sw * (2 / 29) * 0.75,
              )),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(sw * 0.07),
                  bottomRight: Radius.circular(sw * 0.07),
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        //third
        Flexible(
          fit: FlexFit.tight,
          flex: 17,
          child: Container(
            width: sw * 0.022,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

//DRAWER
class drawerUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double sw = media.size.width;
    Orientation deviceOri = media.orientation;
    if (deviceOri == Orientation.portrait) {
      sw = media.size.width;
    } else {
      sw = media.size.height;
    }
    double drWid = sw * 0.95;
    return SizedBox(
      width: drWid,
      child: Drawer(
        child: Padding(
          padding: EdgeInsets.only(
            top: drWid * 0.20,
            left: drWid * 0.10,
            right: drWid * 0.10,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                drHeader(),
                SizedBox(
                  height: drWid * 0.15,
                ),
                //emergen
                drMenuWithIcon(
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: drWid * 0.063,
                    ),
                    0xffe60707,
                    'Health Emergencies',
                    '/emergencies'),
                SizedBox(height: drWid * 0.07),
                //disasters
                drMenuWithIcon(
                    Icon(
                      Icons.nature_people,
                      color: Colors.white,
                      size: drWid * 0.063,
                    ),
                    0xff44d449,
                    'Disasters',
                    '/disasters'),

                Divider(
                  height: drWid * 0.14,
                  thickness: 1,
                ),
                //purpose
                drMenu(
                    'assets/images/qm.png', 'Purpose of this app', '/purpose'),

                SizedBox(height: drWid * 0.07),
                //contact
                drMenu('assets/images/feedback.png', 'Contact & Credits',
                    '/contact'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class drMenuWithIcon extends StatelessWidget {
  Icon leadIcon;

  String menuName, destOnTap;
  int iconBgColor;
  drMenuWithIcon(
      this.leadIcon, this.iconBgColor, this.menuName, this.destOnTap);
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double sw = media.size.width;
    Orientation deviceOri = media.orientation;
    if (deviceOri == Orientation.portrait) {
      sw = media.size.width;
    } else {
      sw = media.size.height;
    }
    double drWid = sw * 0.85;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, this.destOnTap);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: drWid * 0.08,
            width: drWid * 0.08,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Color(this.iconBgColor)),
            child: this
                .leadIcon, /*Icon(
              this.leadIcon,//Icons.book,
              color: Colors.white,
              size: drWid * 0.063,
            ),*/
          ),
          SizedBox(width: drWid * 0.05),
          //text
          Text(
            this.menuName,
            style: TextStyle(
              color: Colors.black,
              fontSize: drWid * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}

class drMenu extends StatelessWidget {
  String menuIcon, menuName, destOnTap;
  drMenu(this.menuIcon, this.menuName, this.destOnTap);
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double sw = media.size.width;
    Orientation deviceOri = media.orientation;
    if (deviceOri == Orientation.portrait) {
      sw = media.size.width;
    } else {
      sw = media.size.height;
    }
    double drWid = sw * 0.85;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, this.destOnTap);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ImageInApp(drWid * 0.08, drWid * 0.08, this.menuIcon),
          SizedBox(width: drWid * 0.05),
          Text(
            this.menuName,
            style: TextStyle(
              color: Colors.black,
              fontSize: drWid * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}

class drHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double sw = media.size.width;
    Orientation deviceOri = media.orientation;
    if (deviceOri == Orientation.portrait) {
      sw = media.size.width;
    } else {
      sw = media.size.height;
    }
    double drWid = sw * 0.85;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.favorite,
          size: sw * 0.75 * 0.11,
          color: Colors.green,
        ),
        SizedBox(width: drWid * (1 / 6) * 0.20),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Colors.black,
            fontSize: drWid * 0.1,
          ),
        ),
      ],
    );
  }
}

class menuItem1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double sw = media.size.width;
    Orientation deviceOri = media.orientation;
    if (deviceOri == Orientation.portrait) {
      sw = media.size.width;
    } else {
      sw = media.size.height;
    }
    double drWid = sw * 0.80;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //image
        ImageInApp(drWid * 0.08, drWid * 0.08, 'assets/images/flag.png'),
        SizedBox(width: drWid * 0.05),
        //Text
        Text(
          'မြန်မာဘာသာ',
          style: TextStyle(
            fontSize: drWid * 0.06,
            //fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: drWid * 0.05),
        //switch
        Consumer<LanguageChanger>(
          builder: (context, LanguageChanger, child) => Switch(
            value: LanguageChanger.myLang,
            onChanged: (bool value) => LanguageChanger.changeLang(),
          ),
        ),
      ],
    );
  }
}
