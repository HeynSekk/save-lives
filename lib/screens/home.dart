
import 'dart:async';
import 'package:flutter/material.dart' hide DrawerButton;
import 'package:flutter/services.dart';
import 'package:save_lives/common/common.dart';
import 'package:provider/provider.dart';


import 'package:save_lives/models/themeManager.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int _stackToShow = 0;

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    super.initState();
    normalProcess();
  }

  Future<void> normalProcess() async {
    await context.read<ThemeManager>().openSetup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return IndexedStack(
      index: _stackToShow,
      children: [
        //home screen
        SafeArea(
          child: Scaffold(
            backgroundColor: Color(t.bg),
            drawer: DrawerUi(), //from common.dart
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //logo
                            vspace(normalFontSize * 2),
                            SaveLivesLogo(sw * 0.75 * 0.08 * 2.2),
                            vspace(normalFontSize * 2),

                            //card1
                            card(
                              'First Aids',
                              'Save lives in case of health emergencies',
                              '/emergencies',
                              true,
                            ),
                            vspace(normalFontSize * 1.8),
                            //card2
                            card(
                              'Survival Tips',
                              'Ways to survive natural disasters',
                              '/disasters',
                              false,
                            ),
                            vspace(normalFontSize * 1.5),
                            //footer quote
                            AppQuote(),
                            vspace(30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget card(String titleTxt, String bodyTxt, String dest, bool card1) {
    final ThemeManager t = context.watch<ThemeManager>();
    final double sw = MediaQuery.of(context).size.width;
    final double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, dest),
      child: Container(
        width: sw * 0.85,
        height: sw * 0.42,
        decoration: BoxDecoration(
          color: card1 ? Color(t.card1) : Color(t.card2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //title
            Text(
              titleTxt,
              style: TextStyle(
                color: Color(t.cardTxt),
                fontWeight: FontWeight.bold,
                fontSize: normalFontSize * 2.1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: normalFontSize * 0.50,
            ),

            //body
            SizedBox(
              width: sw * 0.68,
              child: Text(
                bodyTxt,
                style: TextStyle(
                  color: Color(t.cardTxt),
                  fontSize: normalFontSize * 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
