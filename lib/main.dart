import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:save_lives/screens/disastersCatalog.dart';
import 'package:save_lives/screens/home.dart';
import 'package:save_lives/screens/contact.dart';
import 'package:save_lives/screens/purpose.dart';
import 'package:save_lives/screens/catalog.dart';
import 'package:save_lives/screens/refContent.dart';

import 'models/themeManager.dart';

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
  await Firebase.initializeApp();

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
      create: (context) => ThemeManager(),
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
      initialRoute: '/',
      routes: {
        //SCREENS
        '/': (context) => home(),
        '/emergencies': (context) => catalog(),
        '/disasters': (context) => disastersCatalog(),
        '/purpose': (context) => Purpose(),
        '/contact': (context) => contact(),

        // ***CONTENTS***
        //NOSE BLEED
        '/nose': (context) => refContent(
            'Nose bleeding',
            [
              [
                'https://youtu.be/PmmhxW0vVXA',
                'img',
                'How to treat nose bleed - First aid training - St John Ambulance',
                'St John Ambulance'
              ]
            ],
            [
              [
                'assets/images/nose.jpeg',
                'First aid advice for nose bleed',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/nosebleeds/'
              ]
            ],
            'no'),
        //ASTHMA ATTACK
        '/asthma': (context) => refContent(
              'Asthma attack',
              [
                [
                  'https://youtu.be/hdVKpUR513M',
                  'img',
                  'How to Treat an Asthma Attack - First Aid Training - St John Ambulance',
                  'St John Ambulance'
                ]
              ],
              [
                [
                  'assets/images/asthma.jpg',
                  'Performing first aid for asthma attack',
                  'www.sja.org.uk',
                  'https://www.sja.org.uk/get-advice/first-aid-advice/breathing-difficulties/asthma-attack/'
                ],
                [
                  'assets/images/asthma.jpg',
                  'First aids for asthma attacks',
                  'www.cprcertified.com',
                  'https://www.cprcertified.com/blog/first-aid-for-asthma-attacks'
                ]
              ],
              '''
Sign and symptoms)
- shortness of breath, 
- wheezing
- coughing 
- In severe cases, fingernails and lips can turn blue and the victim may have difficulty walking or talking.

How to help a casuality)
- Help the person sit in an upright position.
- If the person is wearing tight clothing, especially around the neck, loosen it.
- Help the person use their own inhaler or administer medication, if they have it.
- If they don’t, administer an inhaler from a first aid kit.

How to help an asthma victim use an inhaler?)

1- Have the victim inhale slowly through their mouth, then hold their breath for ten seconds.
2- If the victim don’t improve within a few minutes, ask them to take a puff every 30 to 60 seconds, until they have had 10 puffs.
3- If the victim is getting worse, or if this is his/her first attack, call for emergency help.
4- If the ambulance hasn't arrived within 15 minutes, repeat step 2.
5- If the victim become unresponsive at any point prepare to give CPR. 
''',
            ),
        //ELETRIC SHOCK
        '/elec': (context) => refContent(
              'First aid for electric shock',
              [
                [
                  'https://youtu.be/Qld84UtmFpE',
                  'img',
                  'What To Do If Your Baby Had an Electric Shock - First Aid Training - St John Ambulance',
                  'St John Ambulance'
                ]
              ],
              [
                [
                  'assets/images/elec.jpeg',
                  'Electrical shock: First aid',
                  'www.mayoclinic.org',
                  'https://www.mayoclinic.org/first-aid/first-aid-electrical-shock/basics/art-20056695'
                ]
              ],
              '''- if the casuality is breathing, put him into recovery position
- if the casualty has stopped breathing, start CPR. 
- do CPR until the casualty breathe normally or emergency help arrive
- if the casualty got a burn, flood the burn area with cool running water for at least 10 minutes
- cover any burned areas with a sterile gauze bandage, if available, or a clean cloth''',
            ),

        //CHOKING ALONE
        '/chokAl': (context) => refContent(
            'Choking when you\'re alone',
            [
              [
                'https://youtu.be/FEr9jjZ6fi8',
                'img',
                'What To Do When you are Choking alone',
                'Howcast'
              ],
              [
                'https://youtu.be/ljL9JcK6RnM',
                'img',
                'How to perform Heimlinch Manuever on yourself',
                'The List Show TV'
              ]
            ],
            [
              [
                'assets/images/chokMayo.png',
                'Choking - First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637'
              ],
              [
                'assets/images/chokAl.png',
                'Choking alone | Heimlinch Manuever | First aid',
                'www.emergencyphysicians.org',
                'https://www.emergencyphysicians.org/article/know-when-to-go/choking--heimlich-manuever'
              ]
            ],
            'no'),
        //FRACTURE
        '/fra': (context) => refContent('Fracture', [
              [
                'https://youtu.be/2v8vlXgGXwE',
                'img',
                'How To Treat A Fracture & Fracture Types - First Aid Training - St John Ambulance',
                'St John Ambulance'
              ],
              [
                'https://youtu.be/NoPgd1XXkSo',
                'img',
                'Emergency Medical Care : How to Splint a Fracture of the Lower Leg',
                'ehowhealth'
              ]
            ], [
              [
                'assets/images/fra.jpeg',
                'Fractures (broken bones)',
                'www.emergencyphysicians.org',
                'https://www.mayoclinic.org/first-aid/first-aid-fractures/basics/art-20056641'
              ]
            ], '''- Call for emergency help
- Stop any bleeding. Apply pressure to the wound with a sterile bandage, a clean cloth or a clean piece of clothing.
- Immobilize the injured area. Don't try to realign the bone or push a bone that's sticking out back in. Apply a splint to the area above and below the fracture sites. Padding the splints can help reduce discomfort.
- Apply ice packs to limit swelling and help relieve pain
- Treat for shock. If the person feels faint or is breathing in short, rapid breaths, lay the person down with the head slightly lower than the trunk and, if possible, elevate the legs.'''),

        //POISONING
        '/poi': (context) => refContent(
            'Poisoning',
            [
              [
                'https://youtu.be/b2ieb8BZJuY',
                'assets/images/cpr.png',
                'How to treat poisoning: signs and symptoms',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/poi.png',
                'Poisoning : First Aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-poisoning/basics/art-20056657'
              ]
            ],
            'no'),

        //FOREIGN IN BODY
        '/foreign': (context) => refContent('Foreign object in the body', [
              [
                'https://youtu.be/8FK8w6HFdcw',
                'assets/images/cpr.png',
                'If your Baby has a Foreign Object in the Nose or Ear - First Aid Training - St John Ambulance',
                'St John Ambulance'
              ],
            ], [
              [
                'assets/images/foreign.jpeg',
                'Foreign object in the nose: First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid/basics/art-20056610'
              ],
              [
                'assets/images/foreign.jpeg',
                'Foreign object in the ear: First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid/basics/art-20056709'
              ]
            ], '''For foreign object in the nose,
- keep clam, don't probe at the object
- don't try to inhale the object by forcefully breathing in. Breathe through your mouth until the object is removed.
- blow out of your nose gently to try to free the object, but don't blow hard or repeatedly.
- gently remove the object if it's visible and you can easily grasp it with tweezers. Don't try to remove an object that isn't visible or easily grasped.
- call for emergency medical assistance

For foreign object in the ear,
- Don't probe the ear with a tool such as a cotton swab or matchstick.
- Try using gravity
- Try washing the object out. Use a rubber-bulb ear syringe and warm water to irrigate the object out of the canal, provided no ear tubes are in place and you don't suspect the eardrum is perforated.
- Try using oil or warm water for an insect. If the foreign object is an insect, tilt the person's head so that the ear with the insect is upward. Try to float the insect out by pouring mineral oil, olive oil or baby oil into the ear. The oil should be warm, but not hot. Don't use oil to remove an object other than an insect'''),

        //STROKE
        '/stro': (context) => refContent(
            'Stroke signs and symptoms',
            [
              [
                'https://youtu.be/PhH9a0kIwmk',
                'assets/images/cpr.png',
                'What To Do If Someone Has A Stroke, Signs & Symptoms - First Aid Training - St John Ambulance',
                'St John Ambulance'
              ],
            ],
            [
              [
                'assets/images/stro.jpeg',
                'Stroke: First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-stroke/basics/art-20056602'
              ]
            ],
            'no'),

        //CPR ADULT
        '/adCpr': (context) => refContent('CPR for adults', [
              [
                'https://youtu.be/f4ZI1PAsmks',
                'assets/images/cpr.png',
                'How to do CPR on an adult - YouTube',
                'St John Ambulance'
              ],
            ], [
              [
                'assets/images/cprAd.jpg',
                'How to do CPR on an adult - first aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-cpr-on-an-adult/'
              ]
            ], '''
Do CPR when someone is unresponsive or not breathing.
Perform primary survey first.
Call for emergency help.

- Put the heel of your hand on the middle of their chest.
- Keep your arms straight and lean over the casualty.
- Press down hard, to a depth of about 5-6cm as shown in the video.
- If you become tired, ask someone else to do.
- Do this until they become responsive.
- When they become responsive, put them in recovery position.
'''),

        //CPR BABY
        '/babyCpr': (context) => refContent('CPR for babies', [
              [
                'https://youtu.be/avYRvVHAvfM',
                'assets/images/cpr.png',
                'How to do CPR on a baby - YouTube',
                'St John Ambulance'
              ],
            ], [
              [
                'assets/images/cprBaby.png',
                'How to do CPR on a baby - first aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-baby/'
              ]
            ], '''
If a baby is not responding to you and not breathing normally, you will need to call for emergency help and start CPR straight away.

- Open their airway
- 5 initial puffs: Take a breath and put your mouth around the baby’s mouth and nose to make a seal, and blow gently and steadily for up to one second. The chest should rise.
- 30 pumps: Put two fingers in the centre of the baby’s chest and push down a third of the depth of the chest
- 2 puffs: open the airway again and give 2 puffs
- Keep alternating 30 pumps with two puffs
- If the baby shows signs of becoming responsive, such as, coughing, opening their eyes, making a noise, or starts to breathe normally, put them in the recovery position.
'''),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-child/'
              ],
            ],
            'no'),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/how-to/how-to-do-the-primary-survey/'
              ],
            ],
            //remember
            'no'),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/baby-primary-survey/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-the-recovery-position/'
              ]
            ],
            'no'),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-the-recovery-position-baby/'
              ]
            ],
            'no'),

        //# COMMON MFA #
        //BURN AND SCALDS
        '/burn': (context) => refContent('How to treat burn and scalds', [
              [
                'https://youtu.be/EaJmzB8YgS0',
                'assets/images/cpr.png',
                'How to treat burn and scalds - First aid training',
                'St John Ambulance'
              ],
            ], [
              [
                'assets/images/burn.png',
                'Burn and scalds - signs and first aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/burns-and-scalds/'
              ],
              [
                'assets/images/burn.png',
                'First aids for chemical burns',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/chemical-burns/'
              ]
            ], '''
For minor burns,
- place burned area under cool water for at least 10 minutes
- don't break blisters.
- if they do break, clean with a mild soap and water and apply antibiotics ointments and cover it with a nonstick gauze bandage
- if a rash develops, stop using the ointment
- you may use moisturizer or aloe vera lotion to soothe the burn
- if blisters larger than little fingernails, see your doctor
- if pain, use over-the-counter pain relievers
            '''),
        //CHEMICAL BURN
        '/burnCh': (context) => refContent('Chemical burns', [
              [
                'https://youtu.be/eNvXrSf3Cww',
                'assets/images/cpr.png',
                'Chemical Burn Standard First Aid',
                'SOLO MEDICINE'
              ],
            ], [
              [
                'assets/images/chemBurn.jpeg',
                'How to perform first aid for chemical burns',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/chemical-burns/'
              ],
              [
                'assets/images/chemBurn.jpeg',
                'First aids for chemical burns in eye',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/eye-injuries---chemical-burns/'
              ]
            ], '''
- Wear protective gloves
- Flood the burn with cool running water for at least 20 minutes  
- When cooling, pour the water away from yourself to avoid being hit by any chemical splashes. 
- Ensure any contaminated water does not collect near the casualty.
- Call for emergency help. Pass on any details you may have of the chemical to ambulance control.

For chemical burns in eyes)
- Wear protective gloves
- Hold the casualty’s eye under gently running water for at least 20 minutes and make sure the outside and inside of the eyelid is washed.
- If the casualty’s eye is shut due to pain, gently but firmly open it so it can be washed out.
            '''),
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
                'assets/images/chokMayo.png',
                'Choking - First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637'
              ],
              [
                'assets/images/chokAd.png',
                'What To Do When Someone Is Choking - first aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/choking/adult-choking/'
              ]
            ],
            'no'),

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
                'assets/images/chokMayo.png',
                'Choking - First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637'
              ],
              [
                'assets/images/chokBaby.png',
                'First aid advices for Choking (babies)',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/choking/baby-choking/'
              ]
            ],
            'no'),

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
                'assets/images/chokMayo.png',
                'Choking - First aid',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-choking/basics/art-20056637'
              ],
              [
                'assets/images/chokChi.png',
                'First aid advices for Choking (children)',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/choking/child-choking/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/minor-illnesses-and-injuries/eye-injuries/'
              ],
              [
                'assets/images/eye.jpg',
                'Eye wound and injuries - First aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/minor-illnesses-and-injuries/eye-injuries---eye-wounds/'
              ],
              [
                'assets/images/eye.jpg',
                'Eye injuried by chemicals - First aid',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/effects-of-heat-and-cold/eye-injuries---chemical-burns/'
              ]
            ],
            'no'),
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
                'https://www.mayoclinic.org/first-aid/first-aid-fainting/basics/art-20056606'
              ],
              [
                'assets/images/faint.png',
                'First aid for fainting - St John Ambulance',
                'www.sja.org.uk',
                'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/fainting/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/heart-conditions/heart-attack/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/head-injuries/baby-and-child-head-injury/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adults/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/febrile-convulsion-seizures/'
              ]
            ],
            'no'),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/seizures-in-children/'
              ]
            ],
            'no'),

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
                'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/severe-bleeding/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/baby-bleeding/'
              ]
            ],
            'no'),
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
                'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/shock/'
              ]
            ],
            'no'),
        //SNAKE BITE
        '/snak': (context) => refContent('Snake bite', [
              [
                'https://youtu.be/nH8o-bgwo_g',
                'img',
                'First aids for snake bites',
                'HCI Health Tips'
              ]
            ], [
              [
                'assets/images/snak.png',
                'Snake bite - First aids',
                'www.mayoclinic.org',
                'https://www.mayoclinic.org/first-aid/first-aid-snake-bites/basics/art-20056681'
              ],
              [
                'assets/images/snak.png',
                'VENOMOUS SNAKES | Symptoms and First Aid',
                'www.cdc.gov',
                'https://www.cdc.gov/niosh/topics/snakes/symptoms.html'
              ]
            ], '''
- Seek medical attention as soon as possible
- Move beyond the snake's striking distance.
- Remain still and calm to help slow the spread of venom.
- Remove jewelry and tight clothing before you start to swell.
- Position yourself, if possible, so that the bite is at or below the level of your heart.
- Clean the wound with soap and water. Cover it with a clean, dry dressing.
'''),

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
              ['no']
            ],
            'no'),
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
                'https://www.wikihow.com/Survive-a-Tornado'
              ]
            ],
            'no'),
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
                'https://brightside.me/inspiration-tips-and-tricks/12-techniques-that-will-help-you-survive-a-deadly-battle-with-an-animal-387910/'
              ]
            ],
            'no'),
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
