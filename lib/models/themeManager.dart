import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  bool dark = false;
  int bg = 0xffe5e5e5;

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
    this.dark = dark;
    //dark mode
    if (dark) {
      bg = 0xffffffff;
    }
    //light mode
    else {
      bg = 0xff000000;
    }
    notifyListeners();
  }
}
