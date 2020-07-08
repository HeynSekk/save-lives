import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';
//import 'package:save_lives/screens/home_play.dart';
//import 'package:save_lives/screens/home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: catalogPlay(),
    );
  }
}

class catalogPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      //drawer: drawerUI(),
      //content
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          sideStick(), //wid=sw*0.
          //this.displayScroll(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  catalogTitle(), //f
                  SizedBox(
                    height: 25,
                  ),
                  //Choking(baby), Choking(adult), CPR(adult), CPR(baby), Severe Bleeding
                  //1.CHOK
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/chok');
                    },
                    child: menuCatalog(
                        'assets/images/chokThrust.png', 'Choking(adult)'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //2.CPR ADULT
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/cpr');
                    },
                    child:
                        menuCatalog('assets/images/cprImg.jpeg', 'CPR(Adult)'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/snakeBite');
                    },
                    child: menuCatalog('assets/images/cprImg.jpeg', 'Bite'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class catalogTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //image
        ImageInApp(40, 40, 'assets/images/heartIcon.png'),
        //space
        SizedBox(
          width: 5,
        ),
        //text
        SizedBox(
          height: 45,
          width: 200,
          child: Text(
            'When you or someone else encounter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class menuCatalog extends StatelessWidget {
  String iconPicPath;
  //double iconHei, iconWid;
  String eName;
  menuCatalog(this.iconPicPath, this.eName);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: 4 / 1,
      child: Container(
        height: 70,
        width: screenWidth * 0.7,
        decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                //img
                Container(
                  
                ),
                //imgs(60, 60, this.iconPicPath),
                //space 1/10
                SizedBox(
                  width: 20,
                ),
                //text 9/10
                Text(
                  this.eName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class imgs extends StatelessWidget {
  //attri
  double height, width;
  String path;
  //constructor
  imgs(this.height, this.width, this.path);

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: this.width,
      height: this.height, //30.0
      //alignment: Alignment.center,
      decoration: new BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.fill),
      ),
    ));
  }
}

//SIDE STICK
class sideStick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //tight, flex 1/15
        //flex 2/15
        //12/15

        //first
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            //height: 4,
            width: 15,
            color: Colors.green,
          ),
        ),
        //second
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: InkWell(
            child: Container(
              //height: 4,
              width: 40,
              child: Center(
                child: SizedBox(
                    width: 33,
                    height: 33,
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        //third
        Flexible(
          fit: FlexFit.tight,
          flex: 12,
          child: Container(
            width: 15,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class ImageInApp extends StatelessWidget {
  //attri
  double height, width;
  String path;
  //constructor
  ImageInApp(this.height, this.width, this.path);

  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: this.height,
      height: this.width, //30.0
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        //color: Colors.green,
        image: DecorationImage(image: AssetImage(this.path), fit: BoxFit.fill),
      ),
    ));
  }
}
