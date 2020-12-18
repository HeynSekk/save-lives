import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_lives/common/common.dart';
//load assest
//parse
//build with parsed data

class purpose extends StatelessWidget {
  String addr;
  purpose(this.addr);

  @override
  Widget build(BuildContext context) {
    //double sw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<String>>(
          future: loadData(this.addr),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? actualUI(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

//LOAD
Future<List<String>> loadData(String jsonAddr) async {
  String data = await rootBundle.loadString(jsonAddr);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseData, data);
}

// parse
List<String> parseData(String data) {
  var dl = new List<String>();
  final int lineNum = 5;
  int lineCtr = 0;
  Map<String, dynamic> parsed = jsonDecode(data) as Map<String, dynamic>;
  String str;
  //adding
  //Rhythmic flow
  while (lineCtr <= lineNum) {
    str = parsed['$lineCtr'] as String;
    dl.add(str);
    lineCtr++;
  }
  return dl;
}

// MAIN UI
class actualUI extends StatelessWidget {
  List<String> dl;
  actualUI(this.dl);
  Widget secTitle(BuildContext context, String txt) {
    double sw = MediaQuery.of(context).size.width;
    double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.35;
    return Text(
      txt,
      style: TextStyle(
          color: Color(0xff4c7031),
          fontSize: normalFontSize * 3,
          fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    //double normalFontSize = sw * 0.8 * 0.07 * 1.5 * 0.48;
    return Scaffold(
      drawer: drawerUI(),
      body: Padding(
        padding: EdgeInsets.all(sw * 0.05),
        child: Column(
          children: <Widget>[
            //dr button
            SizedBox(
              width: sw * 0.90,
              child: Padding(
                padding: EdgeInsets.only(right: sw * 0.90 * 0.85),
                child: drawerButton(),
              ),
            ),
            SizedBox(
              height: sw * 0.1,
            ),
            //scroll view
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //title
                      secTitle(context, 'Purpose of this app'),
                      SizedBox(
                        height: sw * 0.089,
                      ),
                      normalPara(this.dl[0]),
                      normalPara(this.dl[1]),
                      normalPara(this.dl[2]),
                      normalPara(this.dl[3]),
                      normalPara(this.dl[4]),
                      normalPara(this.dl[5]),
                      //to olen
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class normalPara extends StatelessWidget {
  String data;
  normalPara(this.data);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: sw * 0.05 * 2,
      ),
      child: para(this.data, 0xff000000),
    );
  }
}

class para extends StatelessWidget {
  String data;
  int txtColor;
  para(this.data, this.txtColor);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double paraFontSize = sw * 0.85 * 0.055; //screenWidth * 0.85 * 0.055
    return SizedBox(
      width: sw * 0.80,
      child: Text(
        this.data,
        style: TextStyle(
          fontSize: paraFontSize,
          color: Color(this.txtColor),
          height: 1.9,
        ),
      ),
    );
  }
}
