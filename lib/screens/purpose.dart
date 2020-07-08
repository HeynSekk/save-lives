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
      body: FutureBuilder<List<String>>(
        future: loadData(this.addr),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? actualUI(snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
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
  final int lineNum = 6;
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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //title
            purposeTitle(),
            normalPara(this.dl[0]),
            colorPara(this.dl[1], 0xff9e4d4d),
            normalPara(this.dl[2]),
            colorPara(this.dl[3], 0xff5EBE73),
            normalPara(this.dl[4]),
            colorPara(this.dl[5], 0xff5EBE73),
            normalPara(this.dl[6]),
          ],
        ),
      ),
    );
  }
}

class purposeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.85;
    //double hTitle=mwid*0.32;
    return Padding(
      padding: EdgeInsets.only(
        top: wRow * 0.15,
        bottom: wRow * 0.07,
        left: wRow * 0.07,
        right: wRow * 0.07,
      ),
      child: Row(
        children: <Widget>[
          //image
          ImageInApp(wRow * 0.15, wRow * 0.15, 'assets/images/heartIcon.png'),
          //space
          SizedBox(
            width: wRow * 0.04,
          ),
          //text
          SizedBox(
            //height: 45,
            width: wRow * 0.76,
            child: Text(
              'ဒီAppရဲ့ရည်ရွယ်ချက်',
              style: TextStyle(
                fontSize: wRow * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class colorPara extends StatelessWidget {
  String data;
  int bgColor;
  colorPara(this.data, this.bgColor);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Color(this.bgColor),
      ),
      padding: EdgeInsets.all(screenWidth * 0.07),
      margin: EdgeInsets.only(
        bottom: screenWidth * 0.05 * 2,
      ),
      child: para((screenWidth * 0.75), this.data, 0xffffffff),
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
        left: sw * 0.1,
        right: sw * 0.1,
        bottom: sw * 0.05 * 2,
      ),
      child: para(sw * 0.80, this.data, 0xff000000),
    );
  }
}

class para extends StatelessWidget {
  double paraWid;
  String data;
  int txtColor;
  para(this.paraWid, this.data, this.txtColor);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.85;
    double paraFontSize = wRow * 0.055; //screenWidth * 0.85 * 0.055
    return SizedBox(
      width: this.paraWid,
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
