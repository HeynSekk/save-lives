import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:save_lives/models/themeManager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class contact extends StatelessWidget {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget linkImg(BuildContext context, String path) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return (new Container(
      width: sw * 0.25,
      height: sw * 0.25,
      //alignment: Alignment.center,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(normalFontSize * 0.60),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.fill),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeManager t = context.watch<ThemeManager>();
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(t.bg),
        drawer: DrawerUi(),
        body: Padding(
          padding: EdgeInsets.only(
              top: sw * 0.05, left: sw * 0.05, right: sw * 0.05),
          child: Column(
            children: <Widget>[
              //drawer
              SizedBox(
                width: sw * 0.90,
                child: Padding(
                  padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                  child: DrawerButton(),
                ),
              ),
              SizedBox(
                height: sw * 0.01,
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
                        vspace(normalFontSize),
                        //title
                        LeadingTxt('Contact', true),
                        vspace(normalFontSize * 2),
                        //actions
                        DescTxt(
                            'If you found mistakes in content or want to provide a better content, I will be very glad to see you contact me. You can also suggest for improvements, request new features, report bugs, and discuss the software development by contacting me.',
                            true),

                        vspace(normalFontSize * 2),
                        //description
                        Wrap(
                          spacing: normalFontSize * 0.50,
                          runSpacing: normalFontSize * 0.50,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: <Widget>[
                            //https://github.com/HeynSekk
                            //https://github.com/HeynSekk/save-lives
                            InkWell(
                              onTap: () async {
                                await _makePhoneCall(
                                    'mailto:heinsek@protonmail.com?subject=Contacting from the user of Save Lives&body=Hello Hein Sek,');
                              },
                              child: ActionButton(Icons.email, 'Email'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.facebook.com/HeynSekk');
                              },
                              child: ActionButton(Icons.face, 'Facebook'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://github.com/HeynSekk');
                              },
                              child: ActionButton(Icons.cloud, 'GitHub'),
                            ),
                          ],
                        ),
                        vspace(normalFontSize * 3.3),
                        //section 2
                        LeadingTxt('Contribution', true),

                        vspace(normalFontSize * 2),
                        //desc
                        DescTxt(
                            'This porject is opensource. You can contribute to improve this project.',
                            true),
                        vspace(normalFontSize * 2),
                        //action
                        InkWell(
                          onTap: () async {
                            await _launchInBrowser(
                                'https://github.com/HeynSekk/save-lives');
                          },
                          child: ActionButton(Icons.favorite, 'Contribute'),
                        ),
                        vspace(normalFontSize * 3.3),
                        //section 3
                        LeadingTxt('Credits', true),
                        vspace(normalFontSize * 2),
                        //desc
                        DescTxt(
                            'Images used in this app and its owners. Click the image to go to its source',
                            true),
                        vspace(normalFontSize * 2),
                        //actions
                        Wrap(
                          spacing: sw * 0.05,
                          runSpacing: sw * 0.05,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://raisingchildren.net.au/__data/assets/image/0024/47049/Burns-and-scalds-what-to-do-PIP-9.gif');
                              },
                              child: linkImg(context, 'assets/images/burn.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/adult-choking/');
                              },
                              child:
                                  linkImg(context, 'assets/images/chokAd.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/baby-choking/');
                              },
                              child: linkImg(
                                  context, 'assets/images/chokBaby.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/child-choking/');
                              },
                              child:
                                  linkImg(context, 'assets/images/chokChi.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-cpr-on-an-adult/');
                              },
                              child:
                                  linkImg(context, 'assets/images/cprAd.jpg'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-baby/');
                              },
                              child:
                                  linkImg(context, 'assets/images/cprBaby.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-child/');
                              },
                              child: linkImg(
                                  context, 'assets/images/cprChild.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.familyeducation.com/life/pool-safety/reviving-someone-who-has-drowned-or-swallowed-water');
                              },
                              child: linkImg(
                                  context, 'assets/images/drowning.jpg'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'http://worksafeeyewear.com.au/eye-injuries-happen/');
                              },
                              child: linkImg(context, 'assets/images/eye.jpg'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.firstaidforfree.com/first-aid-tip-fainting/');
                              },
                              child:
                                  linkImg(context, 'assets/images/faint.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/heart-conditions/heart-attack/');
                              },
                              child:
                                  linkImg(context, 'assets/images/heaAtt.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/head-injuries/baby-and-child-head-injury/');
                              },
                              child:
                                  linkImg(context, 'assets/images/heaInj.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://cff2.earth.com/uploads/2017/10/15200729/The-10-worst-fire-disasters-in-U.S.-history.jpg');
                              },
                              child:
                                  linkImg(context, 'assets/images/natural.jpg'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/how-to/how-to-do-the-primary-survey/');
                              },
                              child: linkImg(
                                  context, 'assets/images/priSurAd.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/baby-primary-survey/');
                              },
                              child: linkImg(
                                  context, 'assets/images/priSurBa.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-the-recovery-position/');
                              },
                              child: linkImg(
                                  context, 'assets/images/recPosAd.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-the-recovery-position-baby/');
                              },
                              child: linkImg(
                                  context, 'assets/images/recPosBa.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adult/');
                              },
                              child:
                                  linkImg(context, 'assets/images/seiAd.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/febrile-convulsion-seizures/');
                              },
                              child:
                                  linkImg(context, 'assets/images/seiBa.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/seizures-in-children/');
                              },
                              child:
                                  linkImg(context, 'assets/images/seiChi.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.pinterest.com/pin/689473024182575046/');
                              },
                              child:
                                  linkImg(context, 'assets/images/sevBl.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/baby-bleeding/');
                              },
                              child:
                                  linkImg(context, 'assets/images/sevBlBa.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.wikihow.com/Save-Yourself-from-Drowning-in-a-Shipwreck');
                              },
                              child: linkImg(context, 'assets/images/ship.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/shock/');
                              },
                              child: linkImg(context, 'assets/images/sho.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://illustoon.com/?id=2312');
                              },
                              child: linkImg(context, 'assets/images/snak.png'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://secretsofsurvival.com/wp-content/uploads/2019/08/tornado-b-1200x970.jpg');
                              },
                              child:
                                  linkImg(context, 'assets/images/tornado.jpg'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _launchInBrowser(
                                    'https://brightside.me/inspiration-tips-and-tricks/12-techniques-that-will-help-you-survive-a-deadly-battle-with-an-animal-387910/');
                              },
                              child: linkImg(context, 'assets/images/wild.jpg'),
                            ),
                          ],
                        ),
                        vspace(normalFontSize * 2),
                        //DONT FORGET TO UPDATE VERSION NUMBER
                        Text(
                          'Version 1.2 (1.2.0+2)',
                          textAlign: TextAlign.center,
                        ),
                        vspace(normalFontSize * 0.70),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
