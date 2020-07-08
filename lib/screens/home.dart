import 'package:flutter/material.dart';
import 'package:save_lives/common/common.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: drawerUI(), //from common.dart
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          sideStick(), 
          Padding(
            padding: EdgeInsets.only(
              top: sh * 0.11,
              bottom: sh * 0.11 * (1 / 5),
              left: sh * 0.11 * (1 / 5),
              right: sh * 0.11 * (1 / 5),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  home_title(),
                  SizedBox(
                    height: sh * 0.09,
                  ),
                  homeMenu(
                        Icon(
                          Icons.add_box,
                          color: Colors.white,
                        ),
                        Text(
                          'Health Emergencies',
                          style: TextStyle(
                            fontSize: screenWidth * 0.75 * (1 / 4) * 0.28,
                            color: Colors.white,
                          ),
                        ),
                        '/emergencies'),
                  
                  SizedBox(
                    height: screenWidth * 0.75 * (1 / 4) * 0.35,
                  ),
                  homeMenu(
                        Icon(
                          Icons.nature_people,
                          color: Colors.white,
                        ),
                        Text(
                          'Disasters',
                          style: TextStyle(
                            fontSize: screenWidth * 0.75 * (1 / 4) * 0.28,
                            color: Colors.white,
                          ),
                        ),
                        '/disasters'),
                  //blank
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  //benefits
                  //benefits(),
                ],
              ),
            
          ),
          
          
        ],
      ),
    );
  }
}

//HOME SCREEN

class home_title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double wRow = screenWidth * 0.75;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //heart
        ImageInApp(wRow * 0.15, wRow * 0.15, 'assets/images/heartIcon.png'),
        SizedBox(
          width: wRow * 0.04,
        ),
        Text(
          'Save Lives',
          style: TextStyle(
            color: Colors.black,
            fontSize: wRow * 0.07 * 1.9,
          ),
        ),
      ],
    );
  }
}

/*
Container
padding 15
Row
icon 30 30,space 15,text 30
*/
class homeMenu extends StatelessWidget {
  Icon iconPic;
  Text nameText;
  String onTapDest;
  homeMenu(this.iconPic, this.nameText, this.onTapDest);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, this.onTapDest),
      child: Container(
        //height: screenWidth * 0.75 * 0.30,
        width: screenWidth * 0.75,
        decoration: BoxDecoration(
          color: Color(0xff6BCF63),
          //border: Border.all(),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.only(
            top: screenWidth * 0.75 * (1 / 4) * 0.30,
            bottom: screenWidth * 0.75 * (1 / 4) * 0.30,
            left: screenWidth * 0.75 * (1 / 4) * 0.25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //ICON
            SizedBox(
              height: screenWidth * 0.75 * (1 / 4) * 0.35,
              width: screenWidth * 0.75 * (1 / 4) * 0.35,
              child: this.iconPic,
            ),
            //SPACE
            SizedBox(
              width: screenWidth * 0.75 * (1 / 4) * 0.20,
            ),
            //TEXT
            this.nameText,
          ],
        ),
      ),
    );
  }
}

class benefits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String benefitTitle='ဒီ App ရဲ့ရည်ရွယ်ချက်ကဘာလဲ?';
    final String benefitContent='ကျန်းမာရေးအရေးပေါ်အခြေနေတွေ၊ သဘာ၀ဘေးအန္တရာယ်တွေကြုံတွေ့လာရင်အသက်ရှင်နိုင်ဖို့ဘာလုပ်ရမယ်မှန်းသိမယ်။\n\nတကယ်ကြုံတွေ့လာရင် အသက်ကယ်နိုင်မယ်။ အသက်ရှင်နိုင်မယ်။\n\nရှေးဉီးသူနာပြုစုနည်း လေ့လာချင်သူတွေအတွက် ပြန့်ကြဲပီးလျှောက်ရှာစရာမလိုပဲ တစ်နေရာတည်းမှာ တစ်စုတစ်စည်းတည်းလေ့လာနိုင်မယ်။\n\nမေ့သွားခဲ့ရင်လည်း internet connection မလိုပဲ ပြန်ကြည့်နိုင်မယ်။ စာအုပ်တစ်အုပ်သဖွယ် ဖုန်းထဲမှာသိမ်းထားတော့ နေရာမရွေး internet မလိုပဲသွား‌လေရာထုတ်ဖတ်လို့ရမယ်။\n\nဒီအကျိုးကျေးဇူးတွေပေးနိုင်ဖို့ကဒီappရဲ့ရည်ရွယ်ချက်ပါပဲ။';
    double sw=MediaQuery.of(context).size.width;
    double fontSizeBenefit=sw * 0.80 * 0.055;
    return Container(
      //DL container
      height: sw*0.80*0.70,
      width: sw*0.79,
      decoration: BoxDecoration(
        color: Color(0xffE5E5E5),
        //bord5r: Border.all(),
        borderRadius: BorderRadius.circular(fontSizeBenefit*0.80),
      ),
      padding: EdgeInsets.all(fontSizeBenefit),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //title
            Text(
              benefitTitle,
              style: TextStyle(
                //color:Colors.black,
                fontSize: fontSizeBenefit,
              ),
              
            ),
            SizedBox(height: fontSizeBenefit,),
            //content
            Text(
              benefitContent,
              style: TextStyle(
                //color: Colors.black,
                fontSize: fontSizeBenefit,
                height: 1.9,
              ),
            ),
            SizedBox(height: fontSizeBenefit,),
            //more button
            moreButton(),
          ],
        ),
      ),
      
      
    );
  }
}


class moreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw=MediaQuery.of(context).size.width;
    double fontSizeBenefit=sw * 0.85 * 0.055;
    return InkWell(
      onTap: () {
        
        Navigator.pushNamed(context, '/purpose');
      },
      child: Container(
      width: sw*0.80,
      height: sw*0.80*(1/6),
      decoration: BoxDecoration(
        color: Color(0xff6BCF63),
        borderRadius: BorderRadius.circular(fontSizeBenefit*0.70),
      ),
      child: Center(
        child: Text(
          'အပြည့်အစုံဖတ်ရန်',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSizeBenefit*0.80,
          ),
        ),
      ),
    ),
    );
    
    
  }
}
