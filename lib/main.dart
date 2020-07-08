import 'package:flutter/foundation.dart' show SynchronousFuture;
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:save_lives/common/theme.dart';
import 'package:save_lives/screens/disastersCatalog.dart';
import 'package:save_lives/screens/home.dart';
import 'package:save_lives/screens/contact.dart';
import 'package:save_lives/screens/purpose.dart';
import 'package:save_lives/screens/catalog.dart';
import 'package:save_lives/common/webViewer.dart';
import 'package:save_lives/screens/refContent.dart';
//normal
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.greenAccent),
  );
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
        //screens
        '/': (context) => home(),
        '/emergencies': (context) => catalog(),
        '/disasters': (context) => disastersCatalog(),
        '/purpose': (context) => purpose('assets/texts/purpose.json'),
        '/contact': (context) => contact(),

        //contents
        //# THE FUNDAMENTAL

        //PRI SUR ADULT
        '/priSurAd': (context) => refContent(
            //title
            'Primary survey (Adult)',
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
                'How to do the primary survey on an adult',
                'www.sja.org.uk',
                '/priSurAdW'
              ],
            ],
            //remember
            '-30 chest compression\n-2 resuce breathe'),
        '/priSurAdW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/how-to/how-to-do-the-primary-survey/'),
        /*
        //
        '/recPosAd':(context)=>
        refContent(
          'Recovery',

          [['https://youtu.be/GmqXqwSV3bo','img',
          '- Youtube','St John Ambulance']],

          [['assets/images/recPosAd.png','Recovery','www.sja.org.uk','/recPosAdW']],

          'NO data'
        ),
        '/recPosAdW':(context)=>webViewer(''),
        */
        //PRI SUR BABY
        '/priSurBa':(context)=>
        refContent(
          'Primary Survey (Baby)',

          [['https://youtu.be/uZYptqxfZ1E','img',
          'How to do primary survey on a baby','St John Ambulance']],

          [['assets/images/priSurBa.png','Baby primary survey','www.sja.org.uk','/priSurBaW']],

          'NO data'
        ),
        '/priSurBaW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/baby-primary-survey/'),
        //REC POS ADULT
        '/recPosAd':(context)=>
        refContent(
          'Recovery position (adult)',

          [['https://youtu.be/GmqXqwSV3bo','img',
          'How to put someone in recovery position - Youtube','St John Ambulance']],

          [['assets/images/recPosAd.png','Recovery position (adult)','www.sja.org.uk','/recPosAdW']],

          'NO data'
        ),
        '/recPosAdW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-the-recovery-position/'),

        //REC POS BABY
        '/recPosBa':(context)=>
        refContent(
          'Recovery Position (Baby)',

          [['https://youtu.be/NupCeGFUuoo','img',
          'How to put a baby in recovery position- Youtube','St John Ambulance']],

          [['assets/images/recPosBa.png','Recovery Position for Baby','www.sja.org.uk','/recPosBaW']],

          'NO data'
        ),
        '/recPosBaW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-the-recovery-position-baby/'),
        
        //# COMMON MFA #

        //CHOKING ADULT
        '/chokAd':(context)=>
        refContent(
          'Choking(Adult)',

          [['https://youtu.be/PA9hpOnvtCk','img',
          'What To Do When Someone Is Choking','St John Ambulance']],

          [['assets/images/chokAd.png','What To Do When Someone Is Choking','www.sja.org.uk','/chokAdW']],

          'NO data'
        ),
        '/chokAdW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/choking/adult-choking/'),

        //CHOKING BABY
        '/chokBaby':(context)=>
        refContent(
          'Choking(Baby)',

          [['https://youtu.be/oswDpwzbAV8','img',
          'What To Do When A Baby Is Choking','St John Ambulance']],

          [['assets/images/chokBaby.png','First aid advices for Choking (Baby)','www.sja.org.uk','/chokBabyW']],

          'NO data'
        ),
        '/chokBabyW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/choking/baby-choking/'),

        //CHOKING CHILD
        '/chokChi':(context)=>
        refContent(
          'Choking(Child)',

          [['https://youtu.be/PA9hpOnvtCk','img',
          'What To Do When A Child Is Choking','St John Ambulance']],

          [['assets/images/chokChi.png','First aid advices for Choking (Child)','www.sja.org.uk','/chokChiW']],

          'NO data'
        ),
        '/chokChiW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/choking/child-choking/'),

        //CPR ADULT
        '/adCpr': (context) => 
        refContent(
            'CPR for adult',
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
                'assets/images/cprAd.png',
                'How to do CPR on an adult - Webpage',
                'www.sja.org.uk',
                '/adCprW'
              ]
            ],
            '-30 chest compression\n-2 resuce breathe'
        ),
        '/adCprW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-cpr-on-an-adult/'),

        //CPR BABY
        '/babyCpr': (context) => 
        refContent(
            'CPR for baby',
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
                'How to do CPR on a baby - Webpage',
                'www.sja.org.uk',
                '/babyCprW'
              ]
            ],
            '-30 chest compression\n-2 resuce breathe'
          ),
        '/babyCprW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-baby/'),

        //CPR CHILD
        '/childCpr': (context) => refContent(
            'CPR for child',
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
                'How to do CPR on children',
                'www.sja.org.uk',
                '/cprChildW'
              ],
            ],
            '''-30 chest compression
-2 resuce breathe '''),
        '/cprChildW': (context) => webViewer(
            'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-child/'),

      //HEART ATTACK
        '/heaAtt':(context)=>
        refContent(
          'Heart Attack',

          [['https://youtu.be/gDwt7dD3awc','img',
          'Heart Attack Symptoms & How to Treat a Heart Attack','St John Ambulance']],

          [['assets/images/heaAtt.png','Heart Attack Symptoms & How to Treat a Heart Attack','www.sja.org.uk','/heaAttW']],

          'NO data'
        ),
        '/heaAttW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/heart-conditions/heart-attack/'),
      //HEAD INJURIES
        '/heaInj':(context)=>
        refContent(
          'Head injuries in children and babies',

          [['https://youtu.be/Yps5NGkCPEk','img',
          'Head injuries in children, babies - Youtube','St John Ambulance']],

          [['assets/images/heaInj.png','First aids - Head injuries in children, baby','www.sja.org.uk','/heaInjW']],

          'NO data'
        ),
        '/heaInjW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/head-injuries/baby-and-child-head-injury/'),
      //SEIZURE ADULT
        '/seiAd':(context)=>
        refContent(
          'Seizure (adults)',

          [['https://youtu.be/Ovsw7tdneqE','img',
          'Seizure in adults - Youtube','St John Ambulance']],

          [['assets/images/seiAd.png','Seizure in Adult - First aid','www.sja.org.uk','/seiAdW']],

          'NO data'
        ),
        '/seiAdW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adults/'),//https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adults/

        //SEIZURE BABY
        '/seiBa':(context)=>
        refContent(
          'Seizure (babies)',

          [['https://youtu.be/CcQZRDcGZpE','img',
          'Seizure in babies- Youtube','St John Ambulance']],

          [['assets/images/seiBa.png','Seizure in babies - First aid','www.sja.org.uk','/seiBaW']],

          'NO data'
        ),
        '/seiBaW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/febrile-convulsion-seizures/'),

        //SEIZURE CHILDREN
        '/seiChi':(context)=>
        refContent(
          'Seizure (children)',

          [['https://youtu.be/yQgih6KAwLU','img',
          'Seizure in children - Youtube','St John Ambulance']],

          [['assets/images/seiChi.png','Seizure in children - First aid','www.sja.org.uk','/seiChiW']],

          'NO data'
        ),
        '/seiChiW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/seizures-in-children/'),

        //SEVERE BLEEDING
        '/sevBl':(context)=>
        refContent(
          'Severe bleeding',

          [['https://youtu.be/NxO5LvgqZe0','img',
          'Severe bleeding - Youtube','St John Ambulance']],

          [['assets/images/sevBl.png','Severe bleeding - First aids','www.sja.org.uk','/sevBlW']],

          'NO data'
        ),
        '/sevBlW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/severe-bleeding/'),
        //SEVERE BLEEDING BABY
        '/sevBlBa':(context)=>
        refContent(
          'Severe bleeding (baby)',

          [['https://youtu.be/RZ6hBvAulpE','img',
          'Severe bleeding for babies - Youtube','St John Ambulance']],

          [['assets/images/sevBlBa.png','Severe bleeding in babies - First aids','www.sja.org.uk','/sevBlBaW']],

          'NO data'
        ),
        '/sevBlBaW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/baby-bleeding/'),
        //SHOCK
        '/sho':(context)=>
        refContent(
          'Shock',

          [['https://youtu.be/61urGQrmeNM','img',
          'First aids for Shock - Youtube','St John Ambulance']],

          [['assets/images/sho.png','Shock - First aids','www.sja.org.uk','/shoW']],

          'NO data'
        ),
        '/shoW':(context)=>webViewer('https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/shock/'),
        //SNAKE BITE
        '/snak':(context)=>
        refContent(
          'Snake bite',

          [['https://youtu.be/5k8nDlfaA9E','img',
          'First aids for snake bites - Youtube','St John Ambulance']],

          [['assets/images/snak.png','Snake bite - First aids','www.paradisefirstaid.com.au','/snakW']],

          'NO data'
        ),
        '/snakW':(context)=>webViewer('https://www.paradisefirstaid.com.au/snake-bite-first-aid/'),
        
        
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
