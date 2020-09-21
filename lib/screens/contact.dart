import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';
import 'package:url_launcher/url_launcher.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Widget actionBtn(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Container(
      padding: EdgeInsets.all(normalFontSize),
      decoration: BoxDecoration(
        color: Color(0xff6BCF63),
        borderRadius: BorderRadius.circular(normalFontSize * 1.2),
      ),
      child: Text(
        txt,
        style: TextStyle(color: Colors.white, fontSize: normalFontSize * 1.2),
      ),
    );
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

  Widget secTitle(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Text(
      txt,
      style: TextStyle(color: Color(0xff6B6B6B), fontSize: normalFontSize * 3),
    );
  }

  Widget description(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        txt,
        style:
            TextStyle(color: Color(0xff494949), fontSize: normalFontSize * 1.1),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return SafeArea(
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
              SizedBox(
                height: sw * 0.05,
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
                        secTitle(context, 'Contact'),
                        vspace(normalFontSize * 2),
                        //actions
                        description(context,
                            'You can\nSuggest improvements\nReport bugs\nRequest new features\nDiscuss new project ideas to work with me'),

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
                              onTap: () => setState(() {
                                _launched = _makePhoneCall(
                                    'mailto:heynxsehhz@gmail.com?subject=Contacting from the user of Save Lives&body=Hello Hein Sek,');
                              }),
                              child: actionBtn(context, 'Email'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _makePhoneCall('tel:09256832552');
                              }),
                              child: actionBtn(context, 'Phone call'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.facebook.com/HeynSekk');
                              }),
                              child: actionBtn(context, 'Facebook'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://github.com/HeynSekk');
                              }),
                              child: actionBtn(context, 'GitHub link'),
                            ),
                          ],
                        ),
                        vspace(normalFontSize * 3.3),
                        //section 2
                        secTitle(context, 'Contribution'),
                        vspace(normalFontSize * 2),
                        //desc
                        description(context,
                            'You can also contribute this project by\n\nMaking UI improvements, code refactoring, technical improvements, if you are a Flutter developer, and\n\nDrawing illustrations for first aids items and survival tips, if you are an artist\n\nEvery PR is warmly appreciated.'),
                        vspace(normalFontSize * 2),
                        //action
                        InkWell(
                          onTap: () => setState(() {
                            _launched = _launchInBrowser(
                                'https://github.com/HeynSekk/save-lives');
                          }),
                          child: actionBtn(context, 'Contribute this project'),
                        ),
                        vspace(normalFontSize * 3.3),
                        //section 3
                        secTitle(context, 'Credits'),
                        vspace(normalFontSize * 2),
                        //desc
                        description(context,
                            'Images used in this app and its owners. Click the image to go to its source'),
                        vspace(normalFontSize * 2),
                        //actions
                        Wrap(
                          spacing: sw * 0.05,
                          runSpacing: sw * 0.05,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://raisingchildren.net.au/__data/assets/image/0024/47049/Burns-and-scalds-what-to-do-PIP-9.gif');
                              }),
                              child: linkImg(context, 'assets/images/burn.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/adult-choking/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/chokAd.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/baby-choking/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/chokBaby.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/choking/child-choking/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/chokChi.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-cpr-on-an-adult/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/cprAd.jpg'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-baby/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/cprBaby.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-cpr-on-a-child/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/cprChild.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.familyeducation.com/life/pool-safety/reviving-someone-who-has-drowned-or-swallowed-water');
                              }),
                              child: linkImg(
                                  context, 'assets/images/drowning.jpg'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'http://worksafeeyewear.com.au/eye-injuries-happen/');
                              }),
                              child: linkImg(context, 'assets/images/eye.jpg'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.firstaidforfree.com/first-aid-tip-fainting/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/faint.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/heart-conditions/heart-attack/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/heaAtt.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/head-injuries/baby-and-child-head-injury/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/heaInj.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://cff2.earth.com/uploads/2017/10/15200729/The-10-worst-fire-disasters-in-U.S.-history.jpg');
                              }),
                              child:
                                  linkImg(context, 'assets/images/natural.jpg'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/how-to/how-to-do-the-primary-survey/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/priSurAd.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/baby-primary-survey/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/priSurBa.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/unresponsive-casualty/how-to-do-the-recovery-position/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/recPosAd.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/how-to-do-the-recovery-position-baby/');
                              }),
                              child: linkImg(
                                  context, 'assets/images/recPosBa.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/seizures/seizures-in-adult/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/seiAd.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/febrile-convulsion-seizures/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/seiBa.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/paediatric-first-aid/seizures-in-children/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/seiChi.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.pinterest.com/pin/689473024182575046/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/sevBl.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/baby-bleeding/');
                              }),
                              child:
                                  linkImg(context, 'assets/images/sevBlBa.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.wikihow.com/Save-Yourself-from-Drowning-in-a-Shipwreck');
                              }),
                              child: linkImg(context, 'assets/images/ship.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.sja.org.uk/get-advice/first-aid-advice/bleeding/shock/');
                              }),
                              child: linkImg(context, 'assets/images/sho.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://illustoon.com/?id=2312');
                              }),
                              child: linkImg(context, 'assets/images/snak.png'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://secretsofsurvival.com/wp-content/uploads/2019/08/tornado-b-1200x970.jpg');
                              }),
                              child:
                                  linkImg(context, 'assets/images/tornado.jpg'),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://brightside.me/inspiration-tips-and-tricks/12-techniques-that-will-help-you-survive-a-deadly-battle-with-an-animal-387910/');
                              }),
                              child: linkImg(context, 'assets/images/wild.jpg'),
                            ),
                          ],
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
