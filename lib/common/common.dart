import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_lives/models/themeManager.dart';

//desc txt
class DescTxt extends StatelessWidget {
  String txt;
  bool center;
  DescTxt(this.txt, this.center);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}

//leading txt
class LeadingTxt extends StatelessWidget {
  String txt;
  bool center;
  LeadingTxt(this.txt, this.center);
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DrawerUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.80;
    final double menuSpace = 12;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SaveLivesLogo(drWid * 0.10),
                SizedBox(
                  height: drWid * 0.15,
                ),
                //lang
                DrMenuWithSwitch(Icons.dark_mode, Colors.green, 'Dark mode'),
                Padding(
                  padding: EdgeInsets.only(
                      top: menuSpace * 0.50, bottom: menuSpace * 0.70),
                  child: Divider(),
                ),
                //first aids
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/emergencies'),
                  child:
                      DrMenu(Icons.label_important, Colors.green, 'First aids'),
                ),
                SizedBox(
                  height: menuSpace,
                ),
                //survive
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/disasters'),
                  child: DrMenu(Icons.nature, Colors.green, 'Survival tips'),
                ),
                SizedBox(
                  height: menuSpace,
                ),
                //purpose
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/purpose'),
                  child: DrMenu(
                      Icons.favorite, Colors.green, 'Purpose of this app'),
                ),
                SizedBox(
                  height: menuSpace,
                ),
                //contact
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/contact'),
                  child: DrMenu(Icons.phone, Colors.green, 'Contact'),
                ),
                SizedBox(
                  height: menuSpace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrMenu extends StatelessWidget {
  final IconData leadIcon;
  final String menuName;
  final Color iconBgColor;
  DrMenu(this.leadIcon, this.iconBgColor, this.menuName);
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.50;
    return Row(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: this.iconBgColor),
          child: Padding(
            padding: EdgeInsets.all(drWid * 0.03),
            child: Icon(
              this.leadIcon,
              color: Colors.white,
              size: drWid * 0.10,
            ),
          ),
        ),
        SizedBox(width: drWid * 0.07),
        //text
        Text(
          this.menuName,
          style: TextStyle(
            color: Colors.black,
            fontSize: drWid * 0.09,
          ),
        ),
      ],
    );
  }
}

class DrMenuWithSwitch extends StatelessWidget {
  final IconData leadIcon;
  final String menuName;
  final Color iconBgColor;
  DrMenuWithSwitch(this.leadIcon, this.iconBgColor, this.menuName);
  @override
  Widget build(BuildContext context) {
    final ThemeManager tm = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.80;
    return Row(
      children: <Widget>[
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: this.iconBgColor),
          child: Padding(
            padding: EdgeInsets.all(drWid * 0.03),
            child: Icon(
              this.leadIcon,
              color: Colors.white,
              size: drWid * 0.10,
            ),
          ),
        ),
        SizedBox(width: drWid * 0.07),
        //text
        Text(
          '${this.menuName} ',
          style: TextStyle(
            color: Colors.black,
            fontSize: drWid * 0.09,
          ),
        ),
        //space
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(),
        ),
        //switch
        Switch(
          value: tm.dark,
          onChanged: (bool val) async {
            await tm.changeTheme(val);
          },
        ),
      ],
    );
  }
}

class SaveLivesLogo extends StatelessWidget {
  final double size;
  SaveLivesLogo(this.size);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.favorite,
          size: size,
          color: Color(0xff69ac37),
        ),
        SizedBox(width: size * 0.30),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Colors.black,
            fontSize: size,
          ),
        ),
      ],
    );
  }
}

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
