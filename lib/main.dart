import 'dart:async';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:save_lives/common/theme.dart';
import 'package:save_lives/screens/disastersCatalog.dart';
import 'package:save_lives/screens/home.dart';
import 'package:save_lives/screens/contact.dart';
import 'package:save_lives/screens/purpose.dart';
import 'package:save_lives/screens/catalog.dart';
import 'package:save_lives/common/webViewer.dart';
import 'package:save_lives/screens/refContent.dart';

//***INITIALIZE***
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

// *** MAIN ***
Future<void> main() async {
  // *** VARIABLE CREATING ***
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  // *** ACTUAL INITIALIZE ***
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
    debugPrint('payload added to selectNotificationSubject');
  });

  //WRAP IT
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageChanger(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MaterialApp(
      title: 'Save Lives',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        //SCREENS
        '/': (context) => home(),
        '/emergencies': (context) => catalog(),
        '/disasters': (context) => disastersCatalog(),
        '/purpose': (context) => purpose('assets/texts/purpose.json'),
        '/contact': (context) => contact(),

        // ***CONTENTS***
        //CPR ADULT
        '/adCpr': (context) => refContent(
            'CPR for adults',
            [
              [
                'https://youtu.be/f4ZI1PAsmks',
                'assets/images/cpr.png',
                'How to do CPR on an adult - YouTube',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/cprAd.jpg',
                'How to do CPR on an adult - first aid',
                'www.sja.org.uk',
                '/adCprW'
              ]
            ],
            '-30 chest compression\n-2 resuce breathe'),
        '/adCprW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-cpr-on-an-adult/'),

        //CPR BABY
        '/babyCpr': (context) => refContent(
            'CPR for babies',
            [
              [
                'https://youtu.be/avYRvVHAvfM',
                'assets/images/cpr.png',
                'How to do CPR on a baby - YouTube',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/cprBaby.png',
                'How to do CPR on a baby - first aid',
                'www.sja.org.uk',
                '/babyCprW'
              ]
            ],
            'no'),
        '/babyCprW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-baby/'),

        //CPR CHILD
        '/childCpr': (context) => refContent(
            'CPR for children',
            [
              [
                'https://youtu.be/0aV9NS0ogiM',
                'assets/images/cpr.png',
                'How to do CPR on a child - YouTube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/cprChild.png',
                'How to do CPR on children - first aid',
                'www.sja.org.uk',
                '/cprChildW'
              ],
            ],
            'no'),
        '/cprChildW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-child/'),

        //PRI SUR ADULT
        '/priSurAd': (context) => refContent(
            //title
            'Primary survey (Adults)',
            //vid
            [
              [
                //url, img, titleText, channelName
                'https://youtu.be/ea1RJUOiNfQ',
                'assets/images/priSurAd.png',
                'How to do the primary survey on an adult - YouTube',
                'St John Ambulance'
              ],
            ],
            //web pages
            [
              [
                'assets/images/priSurAd.png',
                'How to do the primary survey on an adult - first aid',
                'www.sja.org.uk',
                '/priSurAdW'
              ],
            ],
            //remember
            'no'),
        '/priSurAdW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/how-to/how-to-do-the-primary-survey/'),

        //PRI SUR BABY
        '/priSurBa': (context) => refContent(
            'Primary Survey (Babies)',
            [
              [
                'https://youtu.be/uZYptqxfZ1E',
                'img',
                'How to do primary survey on a baby',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/priSurBa.png',
                'Baby primary survey - first aid',
                'www.sja.org.uk',
                '/priSurBaW'
              ]
            ],
            'no'),
        '/priSurBaW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/baby-primary-survey/'),
        //REC POS ADULT
        '/recPosAd': (context) => refContent(
            'Recovery position (adults)',
            [
              [
                'https://youtu.be/GmqXqwSV3bo',
                'img',
                'How to put someone in recovery position - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/recPosAd.png',
                'Recovery position (adults) - first aid',
                'www.sja.org.uk',
                '/recPosAdW'
              ]
            ],
            'no'),
        '/recPosAdW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-the-recovery-position/'),

        //REC POS BABY
        '/recPosBa': (context) => refContent(
            'Recovery Position (Babies)',
            [
              [
                'https://youtu.be/NupCeGFUuoo',
                'img',
                'How to put a baby in recovery position- Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/recPosBa.png',
                'First aid - Recovery Position for babies',
                'www.sja.org.uk',
                '/recPosBaW'
              ]
            ],
            'no'),
        '/recPosBaW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-the-recovery-position-baby/'),

        //# COMMON MFA #
        //BURN AND SCALDS
        '/burn': (context) => refContent(
            'How to treat burn and scalds',
            [
              [
                'https://youtu.be/EaJmzB8YgS0',
                'assets/images/cpr.png',
                'How to treat burn and scalds - First aid training',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/burn.png',
                'Burn and scalds - signs and first aid',
                'www.sja.org.uk',
                '/burnW1'
              ],
              [
                'assets/images/burn.png',
                'First aids for chemical burns',
                'www.sja.org.uk',
                '/burnW2'
              ]
            ],
            'no'),
        '/burnW1': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/burns-and-scalds/'),
        '/burnW2': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/chemical-burns/'),
        //CHOKING ADULT
        '/chokAd': (context) => refContent(
            'Choking(Adults)',
            [
              [
                'https://youtu.be/PA9hpOnvtCk',
                'img',
                'What To Do When Someone Is Choking',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/chokAd.png',
                'What To Do When Someone Is Choking - first aid',
                'www.sja.org.uk',
                '/chokAdW'
              ]
            ],
            'no'),
        '/chokAdW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/choking/adult-choking/'),

        //CHOKING BABY
        '/chokBaby': (context) => refContent(
            'Choking(Babies)',
            [
              [
                'https://youtu.be/oswDpwzbAV8',
                'img',
                'What To Do When A Baby Is Choking',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/chokBaby.png',
                'First aid advices for Choking (babies)',
                'www.sja.org.uk',
                '/chokBabyW'
              ]
            ],
            'no'),
        '/chokBabyW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/choking/baby-choking/'),

        //CHOKING CHILD
        '/chokChi': (context) => refContent(
            'Choking(Children)',
            [
              [
                'https://youtu.be/PA9hpOnvtCk',
                'img',
                'What To Do When A Child Is Choking',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/chokChi.png',
                'First aid advices for Choking (children)',
                'www.sja.org.uk',
                '/chokChiW'
              ]
            ],
            'no'),
        '/chokChiW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/choking/child-choking/'),
        //EYE INJURIES
        '/eye': (context) => refContent(
            'Eye injuries',
            [
              [
                'https://youtu.be/PHrrxe3p8vw',
                'assets/images/cpr.png',
                'How to treat an eye injuried by foreign objects',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/eye.jpg',
                'Eye injuried by foreign objects - First aid',
                'www.sja.org.uk',
                '/eyew1'
              ],
              [
                'assets/images/eye.jpg',
                'Eye wound and injuries - First aid',
                'www.sja.org.uk',
                '/eyew2'
              ],
              [
                'assets/images/eye.jpg',
                'Eye injuried by chemicals - First aid',
                'www.sja.org.uk',
                '/eyew3'
              ]
            ],
            'no'),
        '/eyew1': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/minor-illnesses-and-injuries/eye-injuries/'),
        '/eyew2': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/minor-illnesses-and-injuries/eye-injuries---eye-wounds/'),
        '/eyew3': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/eye-injuries---chemical-burns/'),
        //FAINTING
        '/fai': (context) => refContent(
            'First aid for fainting',
            [
              [
                'https://youtu.be/ddHKwkMwNyI',
                'assets/images/cpr.png',
                'Fainting Causes & Treatment - First Aid Training - St John Ambulance',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/faint.png',
                'First aid for fainting',
                'www.mayoclinic.org',
                '/faiw1'
              ],
              [
                'assets/images/faint.png',
                'First aid for fainting - St John Ambulance',
                'www.sja.org.uk',
                '/faiw2'
              ]
            ],
            'no'),
        '/faiw1': (context) => webViewer(
            'https://www.mayoclinic.org/first-aid/first-aid-fainting/basics/art-20056606'),
        '/faiw2': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/fainting/'),
        //HEART ATTACK
        '/heaAtt': (context) => refContent(
            'Heart attack',
            [
              [
                'https://youtu.be/gDwt7dD3awc',
                'assets/images/cpr.png',
                'Heart Attack Symptoms & How to Treat a Heart Attack',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/heaAtt.png',
                'First aid for heart attack - St John Ambulance',
                'www.sja.org.uk',
                '/heaAttW'
              ]
            ],
            'no'),
        '/heaAttW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/heart-conditions/heart-attack/'),
        //HEAD INJURIES
        '/heaInj': (context) => refContent(
            'Head injuries in children and babies',
            [
              [
                'https://youtu.be/Yps5NGkCPEk',
                'img',
                'Head injuries in children, babies - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/heaInj.png',
                'First aids - Head injuries in children, babies',
                'www.sja.org.uk',
                '/heaInjW'
              ]
            ],
            'no'),
        '/heaInjW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/head-injuries/baby-and-child-head-injury/'),
        //SEIZURE ADULT
        '/seiAd': (context) => refContent(
            'Seizure (adults)',
            [
              [
                'https://youtu.be/Ovsw7tdneqE',
                'img',
                'Seizure in adults - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/seiAd.png',
                'Seizure in adults - First aid',
                'www.sja.org.uk',
                '/seiAdW'
              ]
            ],
            'no'),
        '/seiAdW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adults/'), //https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adults/

        //SEIZURE BABY
        '/seibb': (context) => refContent(
            'Seizure (babies)',
            [
              [
                'https://youtu.be/CcQZRDcGZpE',
                'assets/images/cpr.png',
                'If Your Baby has a Seizure - First Aid Training - St John Ambulance',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/seiBa.png',
                'First aid for seizure in babies',
                'www.sja.org.uk',
                '/seibbw'
              ]
            ],
            'no'),
        '/seibbw': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/febrile-convulsion-seizures/'),

        //SEIZURE CHILDREN
        '/seiChi': (context) => refContent(
            'Seizure (children)',
            [
              [
                'https://youtu.be/yQgih6KAwLU',
                'img',
                'Seizure in children - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/seiChi.png',
                'Seizure in children - First aid',
                'www.sja.org.uk',
                '/seiChiW'
              ]
            ],
            'no'),
        '/seiChiW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/seizures-in-children/'),

        //SEVERE BLEEDING
        '/sevBl': (context) => refContent(
            'Severe bleeding',
            [
              [
                'https://youtu.be/NxO5LvgqZe0',
                'img',
                'Severe bleeding - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/sevBl.png',
                'Severe bleeding - First aids',
                'www.sja.org.uk',
                '/sevBlW'
              ]
            ],
            'no'),
        '/sevBlW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/severe-bleeding/'),
        //SEVERE BLEEDING BABY
        '/sevBlBa': (context) => refContent(
            'Severe bleeding (babies)',
            [
              [
                'https://youtu.be/RZ6hBvAulpE',
                'img',
                'Severe bleeding for babies - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/sevBlBa.png',
                'Severe bleeding in babies - First aids',
                'www.sja.org.uk',
                '/sevBlBaW'
              ]
            ],
            'no'),
        '/sevBlBaW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/baby-bleeding/'),
        //SHOCK
        '/sho': (context) => refContent(
            'Shock',
            [
              [
                'https://youtu.be/61urGQrmeNM',
                'img',
                'First aids for Shock - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/sho.png',
                'Shock - First aids',
                'www.sja.org.uk',
                '/shoW'
              ]
            ],
            'no'),
        '/shoW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/shock/'),
        //SNAKE BITE
        '/snak': (context) => refContent(
            'Snake bite',
            [
              [
                'https://youtu.be/5k8nDlfaA9E',
                'img',
                'First aids for snake bites - Youtube',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/snak.png',
                'Snake bite - First aids',
                'www.paradisefirstaid.com.au',
                '/snakW'
              ]
            ],
            'no'),
        '/snakW': (context) => webViewer(
            'https://www.paradisefirstaid.com.au/snake-bite-first-aid/'),

        //DISASTERS

        //DROWNING
        '/dro': (context) => refContent(
            'Drowning (For those who can\'t swim)',
            [
              [
                'https://youtu.be/yt8M6qFBT5Y',
                'img',
                '2 ways to save yourself from drowning ',
                'Bright Side'
              ],
              [
                'https://youtu.be/_radmCM_HDg',
                'img',
                'How to save yourself from drowning',
                'Super Tony'
              ]
            ],
            [
              ['no']
            ],
            'no'),

        //NATURAL DISASTERS
        '/natdis': (context) => refContent(
            'How to survive natural disasters',
            [
              [
                'https://youtu.be/OCjl6tp8dnw',
                'img',
                'How to survive natural disasters',
                'Bright Side'
              ]
            ],
            [
              ['no']
            ],
            'no'),

        //SHIPWRECK
        '/shi': (context) => refContent(
            'Shipwreck at sea',
            [
              [
                'https://youtu.be/W4AOdOhERY0',
                'img',
                '8 great tips for survival at sea',
                'Bright Side'
              ]
            ],
            [
              [
                'assets/images/ship.png',
                'Save yourself from drowning in a shipwreck',
                'www.wikihow.com',
                '/shiW'
              ]
            ],
            'no'),
        '/shiW': (context) => webViewer(
            'https://www.wikihow.com/Save-Yourself-from-Drowning-in-a-Shipwreck'),
        //TORNADO
        '/tor': (context) => refContent(
            'How to survive tornado',
            [
              [
                'https://youtu.be/OCjl6tp8dnw',
                'img',
                'Ways to survive natural disasters',
                'Bright Side'
              ]
            ],
            [
              [
                'assets/images/tornado.jpg',
                'How to survive tornado',
                'www.wikihow.com',
                '/torW'
              ]
            ],
            'no'),
        '/torW': (context) =>
            webViewer('https://www.wikihow.com/Survive-a-Tornado'),
        //WILD ANIMAL ATTACKS
        '/wild': (context) => refContent(
            'How to survive wild animal attacks',
            [
              [
                'https://youtu.be/kkFFq11j6dQ',
                'img',
                '13 tips on how to survive wild animal attacks',
                'Bright Side'
              ]
            ],
            [
              [
                'assets/images/wild.jpg',
                '12 Techniques That Will Help You Survive a Deadly Battle With an Animal',
                'www.brightside.me',
                '/wildW'
              ]
            ],
            'no'),
        '/wildW': (context) => webViewer(
            'https://brightside.me/inspiration-tips-and-tricks/12-techniques-that-will-help-you-survive-a-deadly-battle-with-an-animal-387910/'),
      },
    );
  }
}

//MODEL
class LanguageChanger with ChangeNotifier {
  bool myLang = false;
  String drMenu4 = 'How to use?';
  String drMenu5 = 'Report Bugs';
  String menu1 = 'Emergency';
  String menu2 = 'Knowledges';
  //catalog
  String catInt = 'When you or someone else encounter';

  String todayKnowledgeTitle = 'Today\'s knowledge';
  String todayKnowledgeBody = 'Today\'s knowledge';
  //htu
  String htuTitle = 'How you can use this app to save lives';
  //contact
  String contactBody =
      'You can\n\n- share ideas\n- report bugs\n- request new features\n\nby contacting:';

  void changeLang() {
    var lang = DemoLocalizations(const Locale('my'));
    if (myLang == false) //change to My
    {
      //create My object
      lang = DemoLocalizations(const Locale('my'));
      myLang = true;
    } else //change to Eng
    {
      lang = DemoLocalizations(const Locale('en'));
      myLang = false;
    }
    //update to new lang
    drMenu4 = lang.getValue('drMenu4');
    drMenu5 = lang.getValue('drMenu5');

    menu1 = lang.getValue('menu1');
    menu2 = lang.getValue('menu2');

    //catalog
    catInt = lang.getValue('catInt');
    //htu
    htuTitle = lang.getValue('htuTitle');
    //contact
    contactBody = lang.getValue('contactBody');

    todayKnowledgeTitle = lang.getValue('todayKnowledgeTitle');
    todayKnowledgeBody = lang.getValue('todayKnowledgeBody');

    notifyListeners();
  }
}

//DEMO LOCALIZE'N
class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      //drawer
      'drMenu2': 'Health Emergencies',
      'drMenu3': 'Knowledges',
      'drMenu4': 'Purpose of this App',
      'drMenu5': 'Contact developer',
      //home
      'menu1': 'Emergencies',
      'menu2': 'Knowledges',
      //catalog
      'catInt': 'When you or someone else encounter',
      //htu
      'htuTitle': 'Purpose of this App',
      //contact
      'contactBody':
          'You can\n\n- share ideas\n- report bugs\n- request new features\n\nby contacting:',

      //today knowl
      'todayKnowledgeTitle': 'Today\'s Knowledge',
      'todayKnowledgeBody':
          'Long text Long text here which is lonLong text here which is lonLong text here which is lonhere which is longer than the container height Long text here which is lonLong text here which is lonLong text here which is lonLong text here which is lon',
    },
    'my': {
      //drawer
      'drMenu2': 'အရေးပေါ်အ‌ခြေနေ',
      'drMenu3': 'ဗဟုသုတများ',
      'drMenu4': 'ဒီAppရဲ့ရည်ရွယ်ချက်',
      'drMenu5': 'ဆက်သွယ်ရန်',
      //home
      'menu1': 'အရေးပေါ်အ‌ခြေနေ',
      'menu2': 'ဗဟုသုတများ',
      //catalog
      'catInt': 'သင် သို့မဟုတ် တစ်ခြားတစ်ယောက်ယောက်ဒါတွေကြုံတွေ့ ခဲ့လျှင်',
      //htu
      'htuTitle': 'ဒီAppရဲ့ရည်ရွယ်ချက်',
      //contact
      'contactBody':
          '- စိတ်ကူး အမြင်သစ်တွေ ဝေမျှချင်ရင်\n- Appမှာအဆင်မပြေတာတွေရှိခဲ့ရင်\n- လုပ်ဆောင်ချက်အသစ်တွေ ထပ်ဖြည့်ချင်ရင်\n\nဆက်သွယ်နိုင်ပါတယ်',
      //today knowl
      'todayKnowledgeTitle': 'ဒီနေ့အတွက်ဗဟုသုတ',
      'todayKnowledgeBody':
          'လက်ကိုသေချာစွာဆေးပါ မျက်နှာကိုမကိုင်ပါနှင့်သေချာစွာဆေးပါ မျက်နှာကိုမကိုင်ပါနှင့် သေချာစွာဆေးပါ မျက်နှာကိုမကိုင်ပါနှင့်',
    },
  };

  /*String get menu1 {
    return _localizedValues[locale.languageCode]['menu1'];
  }*/

  String getValue(String val) {
    return _localizedValues[locale.languageCode][val];
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
