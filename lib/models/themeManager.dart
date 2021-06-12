import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  bool dark = false;
  int bg = 0xffffffff;
  int drBg = 0xffffffff;
  int drBtn = 0xffD4EDE3;
  int drBtnIcon = 0xff38B72D;
  int logoIcon = 0xff38B72D;
  int logoTxt = 0xff000000;
  int card1 = 0xff38B72D;
  int card2 = 0xff38B72D;
  int quote = 0xffbf8c00;
  int cardTxt = 0xffffffff;
  int listTitle = 0xff135E35;
  int listItem = 0xffD4EDE3;
  int listItemTxt = 0xff000000;
  int linkBtn = 0xffD4EDE3;
  int linkBtnTxt = 0xff000000;
  int contentTitle = 0xff135E35;
  int drMenu = 0xff000000;
  int paraText = 0xff000000;

  Future<void> openSetup() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    //get user pref
    final bool themePref = sp.getBool('darkTheme');
    if (themePref != null) {
      this.dark = themePref;
    }
    //if user pref was dark, change theme
    if (dark == true) {
      await changeTheme(dark);
    }
  }

  Future<void> changeTheme(bool dark) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    //save user pref in sp
    sp.setBool('darkTheme', dark);
    //change var
    //dark mode
    if (dark) {
      dark = true;
      bg = 0xff000000; //ffffff
      drBg = 0xff072540; //ffffff
      drBtn = 0xff1D4B5F; //D4EDE3
      drBtnIcon = 0xff7B90A9; //38B72D
      logoIcon = 0xffffffff; //38B72D
      logoTxt = 0xff93BED2; //000000
      card1 = 0xff12564A; //38B72D
      card2 = 0xff072540; //38B72D
      quote = 0xff708672; //0xffbf8c00
      cardTxt = 0xffB1E6FF; //ffffff
      listTitle = 0xff93BED2; //135E35
      listItem = 0xff072540; //D4EDE3
      listItemTxt = 0xffB1E6FF; //000000
      linkBtn = 0xff0B3234; //D4EDE3
      linkBtnTxt = 0xffB1E6FF; //000000
      contentTitle = 0xffB1E6FF; //135E35
      drMenu = 0xffffffff; //000000
      paraText = 0xff93BED2; //000000
    }
    //light mode
    else {
      dark = false;
      bg = 0xffffffff;
      drBg = 0xffffffff;
      drBtn = 0xffD4EDE3;
      drBtnIcon = 0xff38B72D;
      logoIcon = 0xff38B72D;
      logoTxt = 0xff000000;
      card1 = 0xff38B72D;
      card2 = 0xff38B72D;
      quote = 0xffbf8c00;
      cardTxt = 0xffffffff;
      listTitle = 0xff135E35;
      listItem = 0xffD4EDE3;
      listItemTxt = 0xff000000;
      linkBtn = 0xffD4EDE3;
      linkBtnTxt = 0xff000000;
      contentTitle = 0xff135E35;
      drMenu = 0xff000000;
      paraText = 0xff000000;
    }
    notifyListeners();
  }
}
