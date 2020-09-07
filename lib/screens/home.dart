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
  Future<void> _showNotification() async {
    var rdm = new Random();
    int screenId = rdm.nextInt(3);
    List<String> routeList = ['/priSurAd', '/adCpr', '/babyCpr'];
    List<String> titleList = ['priSurAd', 'adCpr', 'babyCpr'];
    List<String> bodyList = ['How to do it', 'How to do it', 'How to do it'];
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, titleList[screenId], bodyList[screenId], platformChannelSpecifics,
        payload: routeList[screenId]);
  }

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

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawerUI(), //from common.dart
      body: SafeArea(
        child: Row(
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
                          fontSize: screenWidth * 0.75 * (1 / 4) * 0.28,
                          color: Colors.white,
                        ),
                      ),
                      '/emergencies'),

                  SizedBox(
                    height: screenWidth * 0.75 * (1 / 4) * 0.35,
                  ),
                  homeMenu(
                      Icon(
                        Icons.nature_people,
                        color: Colors.white,
                      ),
                      Text(
                        'Disasters',
                        style: TextStyle(
                          fontSize: screenWidth * 0.75 * (1 / 4) * 0.28,
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
        ),
      ),
    );
  }

  Future<void> _showDailyAtTime() async {
    var rdm = new Random();
    int screenId = rdm.nextInt(3);
    List<String> routeList = [
      '/emergencies',
      '/priSurAd',
      '/adCpr',
      '/babyCpr'
    ];
    List<String> titleList = [
      'Medical first aids',
      'How to perform primary survey on adults',
      'Performing CPR on adults',
      'Performing CPR on babies',
    ];
    List<String> bodyList = [
      'Many death can be avoided if people had First Aids knowledge',
      'Performing primary survey before approaching a casuality can prevent you from the dangers',
      'Many death can be avoided if people knew how to perform the CPR',
      'Knowing how to perform CPR can save the lives of babies in cases of life threatening conditions',
    ];
    var morningTime = Time(8, 1, 0), eveningTime = Time(20, 1, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
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
    screenId = rdm.nextInt(3);
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
          size: wRow * 0.20,
          color: Colors.green,
        ),
        SizedBox(
          width: wRow * 0.02,
        ),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Colors.black,
            fontSize: wRow * 0.07 * 2.5,
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
class homeMenu extends StatelessWidget {
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
}
