import 'package:flutter/material.dart';

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
        height: sw * 0.90 * 0.15,
        width: sw * 0.90 * 0.15,
        decoration: BoxDecoration(
          color: Color(0xffC4C4C4),
          borderRadius: BorderRadius.circular(normalFontSize * 0.80),
        ),
        child: Center(
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: sw * 0.90 * 0.10,
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
          color: Color(0xff69ac37),
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
              color: Color(0xffbf8c00),
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
                    'First Aids',
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
                    'Survival Tips',
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
                SizedBox(height: drWid * 0.07),
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
          size: sw * 0.75 * 0.17,
          color: Color(0xff69ac37),
        ),
        SizedBox(width: drWid * (1 / 6) * 0.20),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Colors.black,
            fontSize: drWid * 0.13,
          ),
        ),
      ],
    );
  }
}
