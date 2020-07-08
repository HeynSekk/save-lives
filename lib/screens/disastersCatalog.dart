import 'package:flutter/material.dart';
import 'catalog.dart';
import 'package:save_lives/common/common.dart';

//MAIN UI
class disastersCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.8;
    double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: drawerUI(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          sideStick(),
          Padding(
            padding: EdgeInsets.only(
              top: sHeight * 0.07,
              bottom: sHeight * 0.11 * (1 / 5),
              left: 0,//sHeight * 0.11 * (1 / 5),
              right: sHeight * 0.11 * (1 / 5),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  //TITLE
                  catalogTitle('သဘာ၀ဘေးအန္တရာယ်တွေကြုံတွေ့ခဲ့လျှင်အသက်ရှည်သန်နည်းများ'),
                  SizedBox(
                    height: wRow * 0.15 * 0.50,
                  ),
                  //LIST
                  menuItemFirst('assets/images/cpr3.jpg',
                      'CPR\n(အရွယ်ရောက်ပြီးသူ)', '/cpr', 'C'),
                  menuItemFirst('assets/images/heartAttackSit.jpg',
                      'Heart attack\n(နှလုံးသွေးကြောပိတ်ခြင်း)', '/heartAttack', 'H'),
                  menuItemFirst('assets/images/chokThrust.png',
                      'နင်ခြင်း\n(အရွယ်ရောက်ပြီးသူ)', '/chokAdult', 'န'),
                  menuItemNormal('assets/images/chokPregnant.jpg',
                      'နင်ခြင်း\n(အ၀လွန်သူ, ကိုယ်၀န်သည်)', '/chokPregnant'),
                  menuItemNormal('assets/images/chokBabyBack.jpg',
                      'နင်ခြင်း\n(၁နှစ်-၈နှစ်)', '/chokBaby'),
                  menuItemFirst('assets/images/snake.png',
                      'မြွေကိုက်ခံရခြင်း', '/snakeBite', 'မ'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

