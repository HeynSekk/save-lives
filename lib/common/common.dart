import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_lives/models/themeManager.dart';

//TITLE
class catalogTitle extends StatelessWidget {
  String title;
  catalogTitle(this.title);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.90;
    //double hTitle=mwid*0.32;
    return Row(
      children: <Widget>[
        //heart
        Icon(
          Icons.favorite,
          size: wRow * 0.18,
          color: Color(t.logoIcon),
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
              color: Color(t.listTitle),
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
    final ThemeManager t = context.watch<ThemeManager>();
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.84;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    //double hTitle=mwid*0.32;
    return SizedBox(
      width: screenWidth * 0.87,
      child: Text(
        this.title,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Color(t.listTitle), fontSize: normalFontSize * 1.2),
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
    final ThemeManager t = context.watch<ThemeManager>();
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
    final ThemeManager t = context.watch<ThemeManager>();
    MediaQueryData media = MediaQuery.of(context);
    double screenWidth = media.size.width;
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
    final ThemeManager t = context.watch<ThemeManager>();
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
          color: Color(t.listItem),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //img h*.7
            ListItemImage(hRow * 0.90, hRow * 0.90, this.iconPicPath),
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
                  fontSize: wRow * 0.06, //screenWidth * 0.75 * 0.055
                  color: Color(t.listItemTxt),
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
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      height: sw * 0.06,
      width: sw * 0.06,
      child: Center(
        child: Text(
          this.alphabet,
          style: TextStyle(
            fontSize: sw * 0.05,
            color: Color(t.listTitle),
            height: 1,
          ),
        ),
      ),
    );
  }
}

class ListItemImage extends StatelessWidget {
  //attri
  final double height, width;
  final String path;
  //constructor
  ListItemImage(this.height, this.width, this.path);

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

class Imgs extends StatelessWidget {
  //attri
  final double height, width, bRadi;
  final String path;
  //constructor
  Imgs(this.height, this.width, this.bRadi, this.path);

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

//button
class ActionButton extends StatelessWidget {
  final IconData btnIcon;
  final String txt;
  ActionButton(this.btnIcon, this.txt);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
      decoration: BoxDecoration(
        color: Color(t.card1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            this.btnIcon,
            color: Color(t.cardTxt),
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            this.txt,
            style: TextStyle(color: Color(t.cardTxt), fontSize: 18),
          ),
        ],
      ),
    );
  }
}

//txt button
class TxtButton extends StatelessWidget {
  final String txt;
  TxtButton(this.txt);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    return Text(
      this.txt,
      style: TextStyle(color: Color(t.card1), fontSize: 18),
    );
  }
}

//desc txt
class DescTxt extends StatelessWidget {
  final String txt;
  final bool center;
  DescTxt(this.txt, this.center);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.87,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          height: 1.5,
          color: Color(t.paraText),
          fontSize: 18,
        ),
      ),
    );
  }
}

//leading txt
class LeadingTxt extends StatelessWidget {
  final String txt;
  final bool center;
  LeadingTxt(this.txt, this.center);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Color(t.listTitle),
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
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.80;
    final double menuSpace = 20;
    return SizedBox(
      width: drWid,
      child: Drawer(
        child: Flexible(
          fit: FlexFit.tight,
          child: Container(
            color: Color(t.drBg),
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
                  SaveLivesLogo(drWid * 0.12),
                  SizedBox(
                    height: drWid * 0.15,
                  ),
                  //lang
                  DrMenuWithSwitch(Icons.dark_mode, Colors.green, 'Dark mode'),
                  Padding(
                    padding: EdgeInsets.only(
                        top: menuSpace * 0.50, bottom: menuSpace * 0.70),
                    child: Divider(
                      color: Color(t.linkBtn),
                    ),
                  ),
                  //first aids
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/emergencies'),
                    child: DrMenu(Icons.medication, 'First aids'),
                  ),
                  SizedBox(
                    height: menuSpace,
                  ),
                  //survive
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/disasters'),
                    child: DrMenu(Icons.nature, 'Survival tips'),
                  ),
                  SizedBox(
                    height: menuSpace,
                  ),
                  //purpose
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/purpose'),
                    child: DrMenu(Icons.favorite, 'Purpose of this app'),
                  ),
                  SizedBox(
                    height: menuSpace,
                  ),
                  //contact
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/contact'),
                    child: DrMenu(Icons.phone, 'Contact'),
                  ),
                  SizedBox(
                    height: menuSpace,
                  ),
                ],
              ),
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
  DrMenu(this.leadIcon, this.menuName);
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.50;
    return Row(
      children: <Widget>[
        Icon(
          this.leadIcon,
          color: Color(t.quote),
          size: drWid * 0.14,
        ),
        SizedBox(width: drWid * 0.07),
        //text
        Text(
          this.menuName,
          style: TextStyle(
            color: Color(t.paraText),
            fontSize: drWid * 0.095,
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
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double drWid = sw * 0.50;
    return Row(
      children: <Widget>[
        Icon(
          this.leadIcon,
          color: Color(t.quote),
          size: drWid * 0.14,
        ),
        SizedBox(width: drWid * 0.07),
        //text
        Text(
          this.menuName,
          style: TextStyle(
            color: Color(t.paraText),
            fontSize: drWid * 0.095,
          ),
        ),
        //space
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(),
        ),
        //switch
        Switch(
          value: t.dark,
          onChanged: (bool val) async {
            await t.changeTheme(val);
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
    final ThemeManager t = context.watch<ThemeManager>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.favorite,
          size: size * 1.10,
          color: Color(t.logoIcon),
        ),
        SizedBox(width: size * 0.25),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Color(t.logoTxt),
            fontSize: size,
          ),
        ),
      ],
    );
  }
}

class vspace extends StatelessWidget {
  final double quant;
  vspace(this.quant);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.quant,
    );
  }
}

class hspace extends StatelessWidget {
  final double quant;
  hspace(this.quant);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.quant,
    );
  }
}

class DrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.48;
    return InkWell(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        height: sw * 0.90 * 0.15,
        width: sw * 0.90 * 0.15,
        decoration: BoxDecoration(
          color: Color(t.drBtn),
          borderRadius: BorderRadius.circular(normalFontSize * 0.80),
        ),
        child: Center(
          child: Icon(
            Icons.menu,
            color: Color(t.drBtnIcon),
            size: sw * 0.90 * 0.085,
          ),
        ),
      ),
    );
  }
}

class AppQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.8;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.48;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: normalFontSize),
        Icon(
          Icons.favorite,
          color: Color(t.logoIcon),
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
              color: Color(t.quote),
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

class ImageInApp extends StatelessWidget {
  //attri
  final double height, width;
  final String path;
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
