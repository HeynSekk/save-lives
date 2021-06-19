import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:provider/provider.dart';
import 'package:save_lives/models/themeManager.dart';

//MAIN UI
class disastersCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double wRow = sw * 0.90;
    double sHeight = MediaQuery.of(context).size.height;
    double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(t.bg),
        drawer: DrawerUi(),
        body: Padding(
          padding: EdgeInsets.only(
              top: sw * 0.05, left: sw * 0.05, right: sw * 0.05),
          child: Column(
            children: <Widget>[
              //drawer
              SizedBox(
                width: sw * 0.90,
                child: Padding(
                  padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                  child: DrawerButton(),
                ),
              ),
              SizedBox(
                height: sw * 0.01,
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
                        catalogTitle('Ways to survive natural disasters'),
                        SizedBox(
                          height: wRow * 0.15 * 0.43,
                        ),
                        //sub title
                        subTitle('How to survive'),
                        SizedBox(
                          height: normalFontSize * 1.2,
                        ),
                        //items
                        menuItemFirst('assets/images/drowning.jpg', 'Drowning',
                            '/dro', 'D'),
                        menuItemFirst('assets/images/natural.jpg',
                            'Natural disasters', '/natdis', 'N'),
                        menuItemFirst('assets/images/ship.png',
                            'Shipwreck at sea', '/shi', 'S'),
                        menuItemFirst('assets/images/tornado.jpg', 'Tornado',
                            '/tor', 'T'),
                        menuItemFirst('assets/images/wild.jpg',
                            'Wild animal attacks', '/wild', 'W'),
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
