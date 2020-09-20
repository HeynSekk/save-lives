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
      padding: EdgeInsets.all(normalFontSize * 0.50),
      decoration: BoxDecoration(
        color: Color(0xff6BCF63),
        borderRadius: BorderRadius.circular(normalFontSize * 0.20),
      ),
      child: Text(
        txt,
        style: TextStyle(color: Colors.white, fontSize: normalFontSize),
      ),
    );
  }

  Widget imgLink(BuildContext context, String path, String url) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return InkWell(
      onTap: () => setState(() {
        _launched = _launchInBrowser(url);
      }),
      child: imgs(sw * 0.25, sw * 0.25, normalFontSize * 0.10, path),
    );
  }

  Widget secTitle(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Text(
      txt,
      style: TextStyle(color: Color(0xff6B6B6B), fontSize: normalFontSize * 2),
    );
  }

  Widget description(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Text(
      txt,
      style: TextStyle(color: Color(0xff494949), fontSize: normalFontSize),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    //github link, email
    //https://www.facebook.com/HeynSekk
    const String toLaunch = 'https://www.cylog.org/headers/';
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(sw * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //drawer
                drawerButton(),
                vspace(normalFontSize),
                //title
                secTitle(context, 'Contact'),
                vspace(normalFontSize * 0.70),
                //actions
                Wrap(
                  spacing: normalFontSize,
                  children: <Widget>[
                    //https://github.com/HeynSekk
                    //https://github.com/HeynSekk/save-lives
                    InkWell(
                      onTap: () => setState(() {
                        _launched = _makePhoneCall('tel:09256832552');
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
                        _launched =
                            _launchInBrowser('https://github.com/HeynSekk');
                      }),
                      child: actionBtn(context, 'GitHub link'),
                    ),
                  ],
                ),
                vspace(normalFontSize * 0.70),
                //description
                description(context,
                    'You can\nSuggest improvements\nReport bugs\nRequest new features\nDiscuss new project ideas to work with me'),
                vspace(normalFontSize * 0.70),
                //section 2
                secTitle(context, 'Contribution'),
                vspace(normalFontSize * 0.70),
                //actions
                InkWell(
                  onTap: () => setState(() {
                    _launched = _launchInBrowser(
                        'https://github.com/HeynSekk/save-lives');
                  }),
                  child: actionBtn(context, 'Contribute this project'),
                ),

                vspace(normalFontSize * 0.70),
                //description
                description(context,
                    'You can also contribute this project by\n\nMaking UI improvements, code refactoring, technical improvements, if you are a Flutter developer, and\n\nDrawing illustrations for first aids items and survival tips, if you are an artist\n\nEvery PR is warmly appreciated.'),
                vspace(normalFontSize * 0.70),
                //section 3
                secTitle(context, 'Credits'),
                vspace(normalFontSize * 0.70),
                //desc
                description(context,
                    'Images used in this app and its owners. Click the image to go to its source'),
                vspace(normalFontSize * 0.70),
                //actions
                Wrap(
                  spacing: sw * 0.05,
                  children: <Widget>[
                    InkWell(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.facebook.com/HeynSekk');
                      }),
                      child: imgs(sw * 0.25, sw * 0.25, normalFontSize * 0.10,
                          'assets/images/cprBaby.png'),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.facebook.com/HeynSekk');
                      }),
                      child: imgs(sw * 0.25, sw * 0.25, normalFontSize * 0.10,
                          'assets/images/cprBaby.png'),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.facebook.com/HeynSekk');
                      }),
                      child: imgs(sw * 0.25, sw * 0.25, normalFontSize * 0.10,
                          'assets/images/cprBaby.png'),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(
                            'https://www.facebook.com/HeynSekk');
                      }),
                      child: imgs(sw * 0.25, sw * 0.25, normalFontSize * 0.10,
                          'assets/images/cprBaby.png'),
                    ),

                    /*imgLink(context, 'assets/images/cprBaby.png',
                      'https://github.com/HeynSekk'),
                  imgLink(
                      context, 'assets/images/faint.png', 'https://github.com'),
                  imgLink(context, 'assets/images/cprBaby.png',
                      'https://github.com/HeynSekk'),
                  imgLink(context, 'assets/images/cprBaby.png',
                      'https://github.com/HeynSekk'),
                  imgLink(context, 'assets/images/cprBaby.png',
                      'https://github.com/HeynSekk'),
                  imgLink(context, 'assets/images/cprBaby.png',
                      'https://github.com/HeynSekk'),*/
                  ],
                ),
                vspace(normalFontSize * 0.70),
              ],
            ),
          ),
        ),

        /*ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    onChanged: (String text) => _phone = text,
                    decoration: const InputDecoration(
                        hintText: 'Input the phone number to launch')),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                  _launched = _makePhoneCall('tel:$_phone');
                }),
                child: const Text('Make phone call'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(toLaunch),
              ),
              RaisedButton(
                onPressed: () => setState(() {
                  _launched =
                      _launchInBrowser('https://www.facebook.com/HeynSekk');
                }),
                child: const Text('my fb'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder<void>(future: _launched, builder: _launchStatus),
            ],
          ),
        ],
      ),*/
      ),
    );
  }
}
