import 'dart:math';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ota_update/ota_update.dart';
import 'package:device_info/device_info.dart';

import 'package:save_lives/common/common.dart';
import 'package:save_lives/main.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  //DON'T FORGET TO UPDATE THE curVer WHEN ROLL OUT UPDATES
  final double curVer = 1.1;
  bool upd = false;
  double verCode = 0;
  String apkUrlArm = 'https://internal1.4q.sk/flutter_hello_world.apk';
  String apkUrlArme = 'https://internal1.4q.sk/flutter_hello_world.apk';
  String apkUrlArmx = 'https://internal1.4q.sk/flutter_hello_world.apk';
  Widget forceCheckResult = new Container();
  Widget updatingStatus = new Container();
  OtaEvent currentEvent = new OtaEvent();
  //for debug
  String debugLogs = 'Debug Logs:';
  bool gonnaFetch = false;
  String expireDate = 'no';
  double verCodeSP = 0;
  String apkUrlSP = 'no';
  List<String> supportedAbisDB = [];
  List<String> supported32BitAbisDB = [];
  List<String> supported64BitAbisDB = [];

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _showDailyAtTime();
    checkForUpd();
  }

  //methods
  Future<void> forceFetchCheckForUpd() async {
    double fetchedVerCode;
    String fetchedUrlArm, fetchedUrlArme, fetchedUrlArmx;
    var curTime = new DateTime.now();
    //create pref instance
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs.catchError((e) {
      print('error= $e');
      return null;
    });
    //check internet connected
    var connResult = await (Connectivity().checkConnectivity().catchError((e) {
      print(e);
      return null;
    }));

    if (connResult == ConnectivityResult.mobile ||
        connResult == ConnectivityResult.wifi) {
      //fetch from fs
      Map<String, dynamic> versionInfo = await getVersionInfo();
      print('fetched ver info');
      fetchedVerCode = versionInfo['verCode'] as double;
      fetchedUrlArm = versionInfo['apkUrlArm'] as String;
      fetchedUrlArme = versionInfo['apkUrlArme'] as String;
      fetchedUrlArmx = versionInfo['apkUrlArmx'] as String;
      print(
          'fetchedVerCode=$fetchedVerCode, fetchedUrl=$fetchedUrlArm and $fetchedUrlArme and $fetchedUrlArmx');

      //set new expire date to SP
      await prefs
          .setString('expDate', curTime.add(new Duration(days: 3)).toString())
          .catchError((e) => print('error= $e'));

      //write fetched data to sp
      await prefs
          .setDouble('verCode', fetchedVerCode)
          .catchError((e) => print('error in setDouble= $e'));
      await prefs
          .setString('apkUrlArm', fetchedUrlArm)
          .catchError((e) => print('error in setString= $e'));
      await prefs
          .setString('apkUrlArme', fetchedUrlArme)
          .catchError((e) => print('error in setString= $e'));
      await prefs
          .setString('apkUrlArmx', fetchedUrlArmx)
          .catchError((e) => print('error in setString= $e'));

      setState(() {
        verCodeSP = fetchedVerCode;
        apkUrlSP = fetchedUrlArm;
      });
      //compare cur ver and fetched ver code
      if (curVer < fetchedVerCode) {
        //updates
        setState(() {
          upd = true;
          verCode = fetchedVerCode;
          apkUrlArm = fetchedUrlArm;
          apkUrlArme = fetchedUrlArme;
          apkUrlArmx = fetchedUrlArmx;
        });
      } else {
        //no updates
        setState(() {
          forceCheckResult = Text('ur app is up to date');
        });
      }
    } else {
      setState(() {
        forceCheckResult =
            Text('plz connect to internet and try Checking again');
      });
    }
  }

  Future<void> checkForUpd() async {
    double fetchedVerCode;
    String fetchedUrlArm, fetchedUrlArme, fetchedUrlArmx;
    //create pref instance
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs.catchError((e) {
      print('error= $e');
      return null;
    });

    //decide whether to fetch fs or not
    bool shouldFetch = await shouldFetchFromFS();
    print('shouldFetch=$shouldFetch');
    //check internet connected
    var connResult = await (Connectivity().checkConnectivity().catchError((e) {
      print(e);
      return null;
    }));
    if ((connResult == ConnectivityResult.mobile ||
            connResult == ConnectivityResult.wifi) &&
        shouldFetch)
      shouldFetch = true;
    else
      shouldFetch = false;
    //yes decided to fetch
    if (shouldFetch) {
      print('gonna fetch fs');
      setState(() {
        gonnaFetch = true;
      });
      //fetch version info from fs
      Map<String, dynamic> versionInfo = await getVersionInfo();
      print('fetched ver info');
      fetchedVerCode = versionInfo['verCode'] as double;
      fetchedUrlArm = versionInfo['apkUrlArm'] as String;
      fetchedUrlArme = versionInfo['apkUrlArme'] as String;
      fetchedUrlArmx = versionInfo['apkUrlArmx'] as String;
      print(
          'fetchedVerCode=$fetchedVerCode, fetchedUrl=$fetchedUrlArm and $fetchedUrlArme and $fetchedUrlArmx');

      //write updated verCode and apkUrl to SP
      await prefs
          .setDouble('verCode', fetchedVerCode)
          .catchError((e) => print('error in setDouble= $e'));
      await prefs
          .setString('apkUrlArm', fetchedUrlArm)
          .catchError((e) => print('error in setString= $e'));
      await prefs
          .setString('apkUrlArme', fetchedUrlArme)
          .catchError((e) => print('error in setString= $e'));
      await prefs
          .setString('apkUrlArmx', fetchedUrlArmx)
          .catchError((e) => print('error in setString= $e'));

      setState(() {
        verCodeSP = fetchedVerCode;
        apkUrlSP = fetchedUrlArm;
      });
    }
    //not to fetch
    else {
      //get verCode and apkUrl from SP
      try {
        fetchedVerCode = prefs.getDouble('verCode');
        fetchedUrlArm = prefs.getString('apkUrlArm');
        fetchedUrlArme = prefs.getString('apkUrlArme');
        fetchedUrlArmx = prefs.getString('apkUrlArmx');
        print(
            'fetchedVerCode SP=$fetchedVerCode, fetchedUrl SP=$fetchedUrlArm');
        setState(() {
          verCodeSP = fetchedVerCode;
          apkUrlSP = fetchedUrlArm;
          debugLogs =
              '$debugLogs\n Shouldnt fetch data from FS so fetch from SP';
        });
      } catch (e) {
        print('error fetching from SP= $e');
      }
    }
    //compare. if cur ver is smaller, show noti
    if (fetchedVerCode != null) {
      if (curVer < fetchedVerCode) {
        setState(() {
          upd = true;
          verCode = fetchedVerCode;
          apkUrlArm = fetchedUrlArm;
          apkUrlArme = fetchedUrlArme;
          apkUrlArmx = fetchedUrlArmx;
        });
      }
    }
    //for debug
    else {
      setState(() {
        debugLogs =
            '$debugLogs\n fetchedVerCode==null meaning first time launching and internet not connected and no data in SP';
      });
    }
  }

  Future<String> chooseApk() async {
    //choose abi
    //initialize plugin
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo
        .catchError((e) => print('error= $e'));
    //device's supported abis
    List<String> supported64BitAbis = build.supported64BitAbis;
    setState(() {
      supportedAbisDB = build.supportedAbis;
      supported32BitAbisDB = build.supported32BitAbis;
      supported64BitAbisDB = build.supported64BitAbis;
    });
    print('supportedAbis= $supportedAbisDB');
    print('supported32BitAbis= $supported32BitAbisDB');
    print('supported64BitAbis= $supported64BitAbisDB');
    //return the right apkUrl
    if (supported64BitAbis.contains('arm64-v8a'))
      return apkUrlArm;
    else if (supported64BitAbis.contains('armeabi-v7a'))
      return apkUrlArme;
    else if (supported64BitAbis.contains('x86_64'))
      return apkUrlArmx;
    else
      return null;
  }

  Future<void> tryOtaUpdate() async {
    //choose the right apk
    String apkUrl = await chooseApk();
    print('the right apk= $apkUrl');
    setState(() {
      debugLogs = '$debugLogs\n the right apk= $apkUrl';
    });
    //check internet connected
    var connResult = await (Connectivity().checkConnectivity().catchError((e) {
      print(e);
      return null;
    }));
    if (connResult == ConnectivityResult.mobile ||
        connResult == ConnectivityResult.wifi) {
      //connected
      setState(() {
        updatingStatus = Column(
          children: [
            Text('Updating...\n Plz don\'t quit the app'),
            SizedBox(
              height: 20,
            ),
            Text('OTA status\n ${currentEvent.status}: ${currentEvent.value}'),
            SizedBox(
              height: 20,
            ),
          ],
        );
      });
      try {
        OtaUpdate()
            .execute(
          apkUrl,
          destinationFilename: 'SaveLives.apk',
        )
            .listen(
          (OtaEvent event) {
            setState(() => currentEvent = event);
          },
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        print('Failed to make OTA update. Details: $e');
      }
    } else {
      //not connected
      setState(() {
        updatingStatus = Column(
          children: [
            Text(
                'No internet connection. Turn on mobile data or wifi and try again.'),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                //debug
                print('internet not connected and trying again.');
                tryOtaUpdate();
              },
              child: Container(
                height: 30,
                width: 80,
                color: Colors.grey,
                child: Text('Try again'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      });
    }
  }

  Future<bool> shouldFetchFromFS() async {
    var curTime = new DateTime.now();
    var expDate = new DateTime.now();
    //create pref instance
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs.catchError((e) {
      print('error= $e');
      return null;
    });

    print('created an SP instance');

    //get expDate from sp
    String expDateStr = prefs.getString('expDate');
    if (expDateStr != null) {
      setState(() {
        expireDate = expDateStr;
      });
      expDate = DateTime.parse(expDateStr);
      if (curTime.isAfter(expDate)) {
        expDateStr = curTime.add(new Duration(days: 3)).toString();
        setState(() {
          expireDate = expDateStr;
        });
        //set exp date
        await prefs
            .setString('expDate', expDateStr)
            .catchError((e) => print('error in setString= $e'));
        //tell to check
        return true;
      } else {
        //dont check
        return false;
      }
    } else {
      //first time
      expDateStr = curTime.add(new Duration(days: 3)).toString();
      setState(() {
        expireDate = expDateStr;
      });
      //set exp date
      await prefs
          .setString('expDate', expDateStr)
          .catchError((e) => print('error in setString= $e'));
      //tell to check
      return true;
    }
  }

  Future<Map<String, dynamic>> getVersionInfo() async {
    DocumentReference dr =
        FirebaseFirestore.instance.collection('versions').doc('version');
    print('created an instance');
    return dr.get().then((ds) {
      String apkUrlArm = ds['apkUrlArm'] as String;
      String apkUrlArme = ds['apkUrlArme'] as String;
      String apkUrlArmx = ds['apkUrlArmx'] as String;
      double verCode = ds['verCode'] as double;
      int forceUpd = ds['forceUpd'] as int;
      Map<String, dynamic> versionInfo = {
        'apkUrlArm': apkUrlArm,
        'apkUrlArme': apkUrlArme,
        'apkUrlArmx': apkUrlArmx,
        'verCode': verCode,
        'forceUpd': forceUpd
      };
      return versionInfo;
    }).catchError((e) {
      print(e);
      return null;
    });
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
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    if (upd == false) {
      //normal screen
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
                            //debug section
                            FutureBuilder<Map<String, dynamic>>(
                                future: getVersionInfo(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    print('url=${snapshot.data['apkUrl']}');
                                    print(
                                        'ver code=${snapshot.data['verCode']}');
                                    print(
                                        'force upd=${snapshot.data['forceUpd']}');
                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text('''
url=${snapshot.data['apkUrlArm']}
ver code FS=${snapshot.data['verCode']}
force upd FS=${snapshot.data['forceUpd']}
expire date=$expireDate
gonna check for update=$gonnaFetch
ver code SP='$verCodeSP
apkUrl SP=$apkUrlSP
supportedAbis = $supportedAbisDB
supported32BitAbis = $supported32BitAbisDB
supported64BitAbis = $supported64BitAbisDB
'''),
                                            //debug log
                                            SizedBox(
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(debugLogs)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Text('error ${snapshot.error}');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                            vspace(30),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  forceCheckResult = Padding(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text('Checking for updates...'),
                                      ],
                                    ),
                                  );
                                });
                                forceFetchCheckForUpd();
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                color: Colors.green,
                                child: Center(
                                  child: Text('Check for updates'),
                                ),
                              ),
                            ),
                            vspace(30),
                            forceCheckResult,

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
        ),
      );
    } else {
      //UPDATE SCREEN
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Plz update the app'),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  tryOtaUpdate();
                },
                child: Text(
                  'Install',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              updatingStatus,
              SizedBox(
                height: 20,
              ),
              Text(
                  'OTA STATUS:\n ${currentEvent.status}: ${currentEvent.value}'),
            ],
          ),
        ),
      );
    }
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
            color: Colors.black, //Color(0xff6B6B6B),
            fontSize: wRow * 0.08 * 2.2,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
