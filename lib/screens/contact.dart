import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:save_lives/common/common.dart';
//import 'package:url_launcher/url_launcher.dart';



class contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    
    return Scaffold(
      drawer: drawerUI(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          sideStick(),
          Padding(
            padding: EdgeInsets.only(
              top: sh * 0.11,
              bottom: sh * 0.11 * (1 / 5),
              left: sh * 0.11 * (1 / 5),
              right: sh * 0.11 * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                body_content(),
                SizedBox(
                  height: sw * 0.80 * 0.07 * 2,
                ),
                addr('assets/images/gmailIcon.png', 'heynxsehhz@gmail.com'),
                
                
                SizedBox(
                  height: sw * 0.80 * 0.07,
                ),
                /*InkWell(
                  onTap: ()=> ul.launch('https://m.me/HeynSekk'),
                  child: addr('assets/images/msgrIcon.png', 'Heyn Sekk'),
                ),*/
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class addr extends StatelessWidget {
  String iconImg, txt;
  addr(this.iconImg, this.txt);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //icon
        ImageInApp(sw * 0.80 * 0.09, sw * 0.80 * 0.09, this.iconImg),
        SizedBox(width: sw * 0.80 * 0.07),
        //addr text
        SizedBox(
          width: sw * 0.70,
          child: Text(this.txt,
              style: TextStyle(
                //color: Colors.black,
                fontSize: sw * 0.80 * 0.07,
                decoration: TextDecoration.underline,
              )),
        ),
      ],
    );
  }
}

class body_content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Consumer<LanguageChanger>(
        builder: (context, LanguageChanger, child) => SizedBox(
              width: sw * 0.80,
              child: Text(
                LanguageChanger.contactBody,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sw * 0.80 * 0.07,
                ),
              ),
            ));
  }
}

//STICK
class sideStick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //comp1(),
        //tight, flex 1/15
        //flex 2/15
        //12/15
        //first
        Flexible(
          fit: FlexFit.tight,
          flex: 7,
          child: Container(
            //height: 4,
            width: 15,
            color: Colors.green,
          ),
        ),
        //second
        Flexible(
          fit: FlexFit.tight,
          flex: 8,
          child: Container(
            //height: 4,
            width: 35,
            child: Center(
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(
                    width: 33,
                    height: 33,
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
              //child: Icon(Icons.menu),
            ),
            //color: Colors.green,
            decoration: BoxDecoration(
              color: Colors.green,
              //border: Border.all(),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        //third
        Flexible(
          fit: FlexFit.tight,
          flex: 7,
          child: Container(
            //height: 4,
            width: 15,
            color: Colors.green,
          ),
        ),

        //comp2(),
        //comp3(),
      ],
    );
  }
}
