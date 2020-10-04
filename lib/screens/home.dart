import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:save_lives/common/common.dart';
import 'package:save_lives/main.dart';

//test
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _showDailyAtTime();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                //Navigator.of(context, rootNavigator: true).pop();
                await Navigator.pushNamed(
                    context, receivedNotification.payload);
                debugPrint('navigated to string receivedNotification.payload');
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('detected payload added');
      await Navigator.pushNamed(context, payload);
      debugPrint('navigated to the string ' + payload);
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  Widget card(String titleTxt, String bodyTxt, String dest) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, dest),
      child: Container(
        width: sw * 0.85,
        height: sw * 0.42,
        decoration: BoxDecoration(
          color: Color(0xff6BCF63),
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
                color: Colors.white,
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
                  color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Scaffold(
      drawer: drawerUI(), //from common.dart
      body: SafeArea(
        child: Scaffold(
          drawer: drawerUI(),
          body: Padding(
            padding: EdgeInsets.all(sw * 0.05),
            child: Column(
              children: <Widget>[
                //drawer
                SizedBox(
                  width: sw * 0.90,
                  child: Padding(
                    padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                    child: drawerButton(),
                  ),
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
                          home_title(),
                          vspace(normalFontSize * 2),

                          //card1
                          card(
                              'First Aids',
                              'Save lives in case of health emergencies',
                              '/emergencies'),
                          vspace(normalFontSize * 1.8),
                          //card2
                          card(
                              'Survival Tips',
                              'Ways to survive natural disasters',
                              '/disasters'),
                          vspace(normalFontSize * 1.5),
                          //footer quote
                          appQuote(),
                          vspace(normalFontSize * 3.3),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /*Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            sideStick(),
            Padding(
              padding: EdgeInsets.only(
                top: sh * 0.11 * 0.90,
                bottom: sh * 0.11 * 0.10,
                left: sh * 0.11 * 0.20,
                right: sh * 0.11 * 0.20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  home_title(),
                  SizedBox(
                    height: sh * 0.09,
                  ),
                  homeMenu(
                      Icon(
                        Icons.add_box,
                        color: Colors.white,
                      ),
                      Text(
                        'Health Emergencies',
                        style: TextStyle(
                          fontSize: sw * 0.75 * (1 / 4) * 0.28,
                          color: Colors.white,
                        ),
                      ),
                      '/emergencies'),

                  SizedBox(
                    height: sw * 0.75 * (1 / 4) * 0.35,
                  ),
                  homeMenu(
                      Icon(
                        Icons.nature_people,
                        color: Colors.white,
                      ),
                      Text(
                        'Disasters',
                        style: TextStyle(
                          fontSize: sw * 0.75 * (1 / 4) * 0.28,
                          color: Colors.white,
                        ),
                      ),
                      '/disasters'),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      await _showNotification();
                    },
                    child: Text(
                      'Show noti',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  //blank
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  appQuote(),
                ],
              ),
            ),
          ],
        ),*/
      ),
    );
  }

  Future<void> _showDailyAtTime() async {
    var rdm = new Random();
    int screenId = rdm.nextInt(24);
    List<String> routeList = [
      '/emergencies',
      '/adCpr',
      '/adCpr',
      '/priSurAd',
      '/recPosAd',
      '/burn',
      '/chokAd',
      '/chokAd',
      '/eye',
      '/fai',
      '/eye',
      '/eye',
      '/heaInj',
      '/heaAtt',
      '/seiAd',
      '/sevBl',
      '/sho',
      '/snak',
      '/snak',
      //disasters
      '/shi',
      '/tor',
      '/wild',
      '/dro',
      '/natdis'
    ];
    List<String> titleList = [
      'Medical first aids',
      'How to save a live by performing CPR',
      'How to save a live by performing CPR',
      'Performing primary survey before approaching a casuality',
      'How to put someone in recovery position',
      'How to make someone relieved from burns and scalds',
      'How to save someone with choking',
      'How to save someone with choking',
      'Helping someone with eye injuries',
      'Performing First aid for a casuality with fainting',
      'What to do when the eye is injuried by a foreign object',
      'What to do when chemicals injuries the eye',
      'First aid for head injuries in children',
      'Helping someone with a heart attacks',
      'Helping someone with seizure',
      'How to save the live of a casuality who is bleeding severely',
      'Performing first aid for someone with shock',
      'How to save yourself when a venomous snake bites you',
      'What to do when a venomous snake bites you',
      // *** DISASTERS ***
      'Tips for survival at sea in case of shipwreck',
      'How to survive tornado',
      'How to escape from wild animal attacks',
      'How to save yourself from drowning',
      'How to survive natural disasters like tsunami'
    ];
    List<String> bodyList = [
      'Many death can be avoided if people had First Aids knowledge',
      'A knowledge that can be useful one day',
      'A knowledge that we should memorize',
      'Learning something valuable today',
      'A knowledge that can save your live one day',
      'Learning something valuable today',
      'A valuable knowledge of health',
      'Today\'s knowledge',
      'A knowledge that can be useful one day',
      'Learning something valuable today',
      'A knowledge that can be useful one day',
      'A valuable knowledge that can be useful one day',
      'Today\'s knowledge',
      'Something special for you to study today',
      'Today\'s knowledge',
      'A valuable knowledge that can save a live one day',
      'Something special for you to study today',
      'A knowledge that can save your live one day',
      'Something special for you to study today',
      // *** NATURAL DISASTERS ***
      'Learning something valuable today',
      'A knowledge that can save a live one day',
      'Something special for you to study today',
      'Learning something valuable today',
      'Learning something valuable today'
    ];
    var morningTime = Time(8, 1, 0), eveningTime = Time(20, 1, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('Show up',
        'Notifying knowledge of the day', 'Notify knowledge of the day');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //morning
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      titleList[screenId],
      bodyList[screenId],
      morningTime,
      platformChannelSpecifics,
      payload: routeList[screenId],
    );
    //evening
    screenId = rdm.nextInt(24);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      1,
      titleList[screenId],
      bodyList[screenId],
      eveningTime,
      platformChannelSpecifics,
      payload: routeList[screenId],
    );
  }
}

//HOME SCREEN

class home_title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.75;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //heart
        Icon(
          Icons.favorite,
          size: wRow * 0.21,
          color: Colors.green,
        ),
        SizedBox(
          width: wRow * 0.02,
        ),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Color(0xff6B6B6B),
            fontSize: wRow * 0.08 * 2.5,
          ),
        ),
      ],
    );
  }
}

/*
Container
padding 15
Row
icon 30 30,space 15,text 30
*/
/*class homeMenu extends StatelessWidget {
  Icon iconPic;
  Text nameText;
  String onTapDest;
  homeMenu(this.iconPic, this.nameText, this.onTapDest);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, this.onTapDest),
      child: Container(
        //height: screenWidth * 0.75 * 0.30,
        width: screenWidth * 0.68,
        decoration: BoxDecoration(
          color: Color(0xff6BCF63),
          //border: Border.all(),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.only(
            top: screenWidth * 0.75 * (1 / 4) * 0.30,
            bottom: screenWidth * 0.75 * (1 / 4) * 0.30,
            left: screenWidth * 0.75 * (1 / 4) * 0.25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //ICON
            SizedBox(
              height: screenWidth * 0.75 * (1 / 4) * 0.35,
              width: screenWidth * 0.75 * (1 / 4) * 0.35,
              child: this.iconPic,
            ),
            //SPACE
            SizedBox(
              width: screenWidth * 0.75 * (1 / 4) * 0.20,
            ),
            //TEXT
            this.nameText,
          ],
        ),
      ),
    );
  }
}

class benefits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String benefitTitle = 'ဒီ App ရဲ့ရည်ရွယ်ချက်ကဘာလဲ?';
    final String benefitContent =
        'ကျန်းမာရေးအရေးပေါ်အခြေနေတွေ၊ သဘာ၀ဘေးအန္တရာယ်တွေကြုံတွေ့လာရင်အသက်ရှင်နိုင်ဖို့ဘာလုပ်ရမယ်မှန်းသိမယ်။\n\nတကယ်ကြုံတွေ့လာရင် အသက်ကယ်နိုင်မယ်။ အသက်ရှင်နိုင်မယ်။\n\nရှေးဉီးသူနာပြုစုနည်း လေ့လာချင်သူတွေအတွက် ပြန့်ကြဲပီးလျှောက်ရှာစရာမလိုပဲ တစ်နေရာတည်းမှာ တစ်စုတစ်စည်းတည်းလေ့လာနိုင်မယ်။\n\nမေ့သွားခဲ့ရင်လည်း internet connection မလိုပဲ ပြန်ကြည့်နိုင်မယ်။ စာအုပ်တစ်အုပ်သဖွယ် ဖုန်းထဲမှာသိမ်းထားတော့ နေရာမရွေး internet မလိုပဲသွား‌လေရာထုတ်ဖတ်လို့ရမယ်။\n\nဒီအကျိုးကျေးဇူးတွေပေးနိုင်ဖို့ကဒီappရဲ့ရည်ရွယ်ချက်ပါပဲ။';
    double sw = MediaQuery.of(context).size.width;
    double fontSizeBenefit = sw * 0.80 * 0.055;
    return Container(
      //DL container
      height: sw * 0.80 * 0.70,
      width: sw * 0.79,
      decoration: BoxDecoration(
        color: Color(0xffE5E5E5),
        //bord5r: Border.all(),
        borderRadius: BorderRadius.circular(fontSizeBenefit * 0.80),
      ),
      padding: EdgeInsets.all(fontSizeBenefit),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //title
            Text(
              benefitTitle,
              style: TextStyle(
                //color:Colors.black,
                fontSize: fontSizeBenefit,
              ),
            ),
            SizedBox(
              height: fontSizeBenefit,
            ),
            //content
            Text(
              benefitContent,
              style: TextStyle(
                //color: Colors.black,
                fontSize: fontSizeBenefit,
                height: 1.9,
              ),
            ),
            SizedBox(
              height: fontSizeBenefit,
            ),
            //more button
            moreButton(),
          ],
        ),
      ),
    );
  }
}

class moreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double fontSizeBenefit = sw * 0.85 * 0.055;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/purpose');
      },
      child: Container(
        width: sw * 0.80,
        height: sw * 0.80 * (1 / 6),
        decoration: BoxDecoration(
          color: Color(0xff6BCF63),
          borderRadius: BorderRadius.circular(fontSizeBenefit * 0.70),
        ),
        child: Center(
          child: Text(
            'အပြည့်အစုံဖတ်ရန်',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSizeBenefit * 0.80,
            ),
          ),
        ),
      ),
    );
  }
}*/
