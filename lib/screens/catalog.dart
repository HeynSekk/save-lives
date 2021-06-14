import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:save_lives/models/themeManager.dart';
import 'package:provider/provider.dart';

//MAIN UI
class catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double wRow = sw * 0.90;
    final double sHeight = MediaQuery.of(context).size.height;
    final double normalFontSize = wRow * 0.07 * 1.5 * 0.50;
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
                        menuItemFirst('assets/images/asthma.jpg',
                            'Asthma attack', '/asthma', 'A'),
                        menuItemFirst('assets/images/burn.png',
                            'Burn and scalds', '/burn', 'B'),
                        menuItemNormal('assets/images/chemBurn.jpeg',
                            'Burn (chemical burns)', '/burnCh'),
                        menuItemFirst('assets/images/chokAl.png',
                            'Choking when you\'re alone', '/chokAl', 'C'),
                        menuItemNormal('assets/images/chokAd.png',
                            'Choking (adults)', '/chokAd'),
                        menuItemNormal('assets/images/chokBaby.png',
                            'Choking (babies)', '/chokBaby'),
                        menuItemNormal('assets/images/chokChi.png',
                            'Choking (children)', '/chokChi'),
                        menuItemFirst('assets/images/elec.jpeg',
                            'Electric shock', '/elec', 'E'),
                        menuItemNormal(
                            'assets/images/eye.jpg', 'Eye injuries', '/eye'),
                        menuItemFirst(
                            'assets/images/faint.png', 'Fainting', '/fai', 'F'),
                        menuItemNormal('assets/images/foreign.jpeg',
                            'Foreign object in the body', '/foreign'),
                        menuItemNormal(
                            'assets/images/fra.jpeg', 'Fracture', '/fra'),
                        menuItemFirst(
                            'assets/images/heaInj.png',
                            'Head injuries in children, babies',
                            '/heaInj',
                            'H'),
                        menuItemNormal('assets/images/heaAtt.png',
                            'Heart attack', '/heaAtt'),
                        menuItemFirst('assets/images/nose.jpeg',
                            'Nose bleeding', '/nose', 'N'),
                        menuItemFirst(
                            'assets/images/poi.png', 'Poisoning', '/poi', 'P'),
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
                        menuItemNormal(
                            'assets/images/stro.jpeg', 'Stroke', '/stro'),
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
