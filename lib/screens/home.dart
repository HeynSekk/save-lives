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
  int _stackToShow = 0;
  bool upd = false;
  double verCode = 0;
  String apkUrlArm = 'https://internal1.4q.sk/flutter_hello_world.apk';
  String apkUrlArme = 'https://internal1.4q.sk/flutter_hello_world.apk';
  String apkUrlArmx = 'https://internal1.4q.sk/flutter_hello_world.apk';
  Widget forceCheckResult = new Container();
  Widget updatingStatus = new Container();
  OtaEvent currentEvent = new OtaEvent();
  double downloadProgress = 0.0;

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

  //get version info
  Future<Map<String, dynamic>> getVersionInfo() async {
    DocumentReference dr =
        FirebaseFirestore.instance.collection('versions2').doc('version2');
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
      print('err in db read= $e');
      return null;
    });
  }

  //check for update
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

    //yes decided to fetch
    if (shouldFetch) {
      print('yes should fetch');
      //fetch version info from fs
      Map<String, dynamic> versionInfo = await getVersionInfo();
      print('db has data? = ${versionInfo != null}');
      if (versionInfo != null) {
        print('success db read');
        fetchedVerCode = versionInfo['verCode'] as double;
        fetchedUrlArm = versionInfo['apkUrlArm'] as String;
        fetchedUrlArme = versionInfo['apkUrlArme'] as String;
        fetchedUrlArmx = versionInfo['apkUrlArmx'] as String;
        print('fetchedVerCode= $fetchedVerCode');

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
      }
    }
    //not to fetch
    else {
      print('should not fetch db\n fetchedVerCode=$fetchedVerCode');
      //get verCode and apkUrl from SP
      try {
        fetchedVerCode = prefs.getDouble('verCode');
        fetchedUrlArm = prefs.getString('apkUrlArm');
        fetchedUrlArme = prefs.getString('apkUrlArme');
        fetchedUrlArmx = prefs.getString('apkUrlArmx');
      } catch (e) {
        print('error fetching from SP= $e');
      }
    }
    //compare. if cur ver is smaller, show noti
    if (fetchedVerCode != null) {
      print('got data from db');
      if (curVer < fetchedVerCode) {
        setState(() {
          _stackToShow = 1;
          verCode = fetchedVerCode;
          apkUrlArm = fetchedUrlArm;
          apkUrlArme = fetchedUrlArme;
          apkUrlArmx = fetchedUrlArmx;
        });
      }
    }
  }

  //force check update
  Future<void> forceFetchCheckForUpd(BuildContext context) async {
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
      print('db has data? = ${versionInfo != null}');
      if (versionInfo != null) {
        print('success db read');
        fetchedVerCode = versionInfo['verCode'] as double;
        fetchedUrlArm = versionInfo['apkUrlArm'] as String;
        fetchedUrlArme = versionInfo['apkUrlArme'] as String;
        fetchedUrlArmx = versionInfo['apkUrlArmx'] as String;
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

        //compare cur ver and fetched ver code
        if (curVer < fetchedVerCode) {
          //updates
          setState(() {
            _stackToShow = 1;
            verCode = fetchedVerCode;
            apkUrlArm = fetchedUrlArm;
            apkUrlArme = fetchedUrlArme;
            apkUrlArmx = fetchedUrlArmx;
          });
        } else {
          //no updates
          setState(() {
            forceCheckResult = Text(
              'The app is up to date',
              textAlign: TextAlign.center,
            );
          });
        }
      }
    } else {
      setState(() {
        forceCheckResult = SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text(
            'Please turn on mobile data or wifi. And try Checking again',
            textAlign: TextAlign.center,
          ),
        );
      });
    }
  }

  //should fetch
  Future<bool> shouldFetchFromFS() async {
    var curTime = new DateTime.now();
    var expDate = new DateTime.now();
    bool intConn = false;
    //check internet connected
    var connResult = await (Connectivity().checkConnectivity().catchError((e) {
      print(e);
      return null;
    }));
    if (connResult == ConnectivityResult.mobile ||
        connResult == ConnectivityResult.wifi) intConn = true;

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
      expDate = DateTime.parse(expDateStr);
      if (curTime.isAfter(expDate) && intConn) {
        //calculate new expire date
        expDateStr = curTime.add(new Duration(days: 3)).toString();

        //write exp date to SP
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
      if (intConn) {
        //calculate new expire date
        expDateStr = curTime.add(new Duration(days: 3)).toString();

        //write exp date to SP
        await prefs
            .setString('expDate', expDateStr)
            .catchError((e) => print('error in setString= $e'));

        //tell to check
        return true;
      } else {
        return false;
      }
    }
  }

  //choose apk
  Future<String> chooseApk() async {
    //initialize plugin
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo
        .catchError((e) => print('error= $e'));
    //device's supported abis
    List<String> supportedAbis = build.supportedAbis;

    //return the right apkUrl
    if (supportedAbis[0].compareTo('arm64-v8a') == 0) {
      return apkUrlArm;
    } else if (supportedAbis[0].compareTo('armeabi-v7a') == 0) {
      return apkUrlArme;
    } else if (supportedAbis[0].compareTo('x86_64') == 0) {
      return apkUrlArmx;
    } else
      return null;
  }

  //ota update
  Future<void> tryOtaUpdate() async {
    //choose the right apk
    String apkUrl = await chooseApk();
    //check internet connected
    var connResult = await (Connectivity().checkConnectivity().catchError((e) {
      print(e);
      return null;
    }));
    if (connResult == ConnectivityResult.mobile ||
        connResult == ConnectivityResult.wifi) {
      //connected
      setState(() {
        //show downloading screen
        _stackToShow = 2;
      });
      try {
        OtaUpdate()
            .execute(
          apkUrl,
          destinationFilename: 'SaveLives.apk',
        )
            .listen(
          (OtaEvent event) {
            setState(() {
              currentEvent = event;
              downloadProgress = double.parse(currentEvent.value);
            });
            print('currentEvent.value = ${currentEvent.value}');
            //print('downloadProgress = $downloadProgress');
          },
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        print('Failed to make OTA update. Details: $e');
        setState(() {
          //show error updating screen
          _stackToShow = 4;
        });
      }
    } else {
      //not connected
      setState(() {
        //no internet screen
        _stackToShow = 3;
      });
    }
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
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return IndexedStack(
      index: _stackToShow,
      children: [
        //home screen
        Scaffold(
          drawer: DrawerUi(), //from common.dart
          body: SafeArea(
            child: Scaffold(
              drawer: DrawerUi(),
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
                                  forceFetchCheckForUpd(context);
                                },
                                child:
                                    actionBtn('Check for updates', 0xff69ac37),
                              ),
                              vspace(30),
                              forceCheckResult,
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
        ),
        //update notify screen
        Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title
                titleTxt('Software updates available!'),
                SizedBox(
                  height: normalFontSize * 1.5,
                ),
                //desc
                descText(
                    'Please turn on mobile data or wifi. And update the app.'),
                SizedBox(
                  height: normalFontSize * 2.9,
                ),
                //btn
                InkWell(
                  onTap: () async {
                    tryOtaUpdate();
                  },
                  child: actionBtn('Update now', 0xff69ac37),
                ),
                SizedBox(
                  height: normalFontSize * 1.7,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      _stackToShow = 0;
                      forceCheckResult = Container();
                    });
                  },
                  child: actionBtn('Cancel', 0xff69ac37),
                ),
              ],
            ),
          ),
        ),
        //update success
        SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //title
                  titleTxt('Updating...'),
                  SizedBox(
                    height: normalFontSize * 1.5,
                  ),
                  //desc
                  descText('Please don\'t quit the app while updating'),
                  SizedBox(
                    height: normalFontSize * 2.9,
                  ),
                  //progress
                  SizedBox(
                    width: sw * 0.70,
                    child: LinearProgressIndicator(
                      value: downloadProgress * 0.01,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff69ac37)),
                      backgroundColor: Color(0xffd6d6d6),
                    ),
                  ),

                  SizedBox(
                    height: normalFontSize * 1.5,
                  ),
                  //percent
                  Text(
                    '$downloadProgress%',
                    style: TextStyle(
                      color: Color(0xffbf8c00),
                      fontSize: normalFontSize * 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: normalFontSize * 1.5,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _stackToShow = 0;
                        forceCheckResult = Container();
                      });
                    },
                    child: actionBtn('Run in background', 0xff69ac37),
                  ),
                ],
              ),
            ),
          ),
        ),
        //no internet
        Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title
                titleTxt('No internet connection!'),
                SizedBox(
                  height: normalFontSize * 1.5,
                ),
                //desc
                descText('Please turn on mobile data or wifi. And try again.'),
                SizedBox(
                  height: normalFontSize * 2.9,
                ),
                //btn
                InkWell(
                  onTap: () async {
                    tryOtaUpdate();
                  },
                  child: actionBtn('Try Again', 0xff69ac37),
                ),
              ],
            ),
          ),
        ),
        //error updating
        Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //desc
                Text(
                  'Couldn\'t download updates',
                  style: TextStyle(
                    fontSize: normalFontSize * 1.2,
                    color: Color(0xff4c7031),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: normalFontSize * 1.5,
                ),
                //btn
                InkWell(
                  onTap: () async {
                    tryOtaUpdate();
                  },
                  child: actionBtn('Try Again', 0xff69ac37),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
          color: Color(0xff69ac37),
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
          color: Color(0xff69ac37),
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

/*
title green #4c7031
desc yellow #bf8c00
button green #69ac37

*/
//title text
class titleTxt extends StatelessWidget {
  String txt;
  titleTxt(this.txt);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.95,
      child: Text(
        this.txt,
        style: TextStyle(
          color: Color(0xff4c7031),
          fontWeight: FontWeight.bold,
          fontSize: sw * 0.8 * 0.07 * 3 * 0.48,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

//descText
class descText extends StatelessWidget {
  String txt;
  descText(this.txt);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.85,
      child: Text(
        this.txt,
        style: TextStyle(
          color: Color(0xffbf8c00),
          fontSize: sw * 0.8 * 0.07 * 1.8 * 0.48,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

//actionBtn
class actionBtn extends StatelessWidget {
  String txt;
  int color;
  actionBtn(this.txt, this.color);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Container(
      padding: EdgeInsets.all(normalFontSize * 0.85),
      decoration: BoxDecoration(
        color: Color(this.color),
        borderRadius: BorderRadius.circular(normalFontSize * 0.85),
      ),
      child: Text(
        txt,
        style: TextStyle(color: Colors.white, fontSize: normalFontSize * 1.1),
      ),
    );
  }
}
