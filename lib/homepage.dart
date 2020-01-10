import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_page_ui/Widgets/Schedule.dart';
import 'package:flutter_login_page_ui/utils/AuthData.dart';
import 'package:flutter_login_page_ui/utils/SharedPreferences.dart';
import 'package:flutter_login_page_ui/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/Courses attended.dart';
import 'Widgets/Notification.dart';
import 'Widgets/Special request.dart';
import 'ustaAPI/model.dart';
bool isExpanded = false;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  RegisteredUser registeredUser;
  TabController tabController;

  @override
  void initState() {
    super.initState();
//    AuthorizationManager.getPreferences().then((AuthData data){
//      if(data.isNull){
//        Navigator.of(context).pushNamedAndRemoveUntil("/landing-page", ModalRoute.withName(null));
//        return;
//      }
//       if( data.init != null){
//        Navigator.of(context).pushNamedAndRemoveUntil(data.init, ModalRoute.withName(null));
//        return;
//      }
//
//
//    });
    print("********************************* building home page");
    tabController = TabController(length: 3, vsync: this);

//    SharedPreferences.getInstance().then((val){
//      print(json.decode(val.get("userData")));
//      registeredUser = RegisteredUser.fromJson(json.decode(val.get("userData")));
//      setState(() {
//
//      });
//    });
  }

  @override
  void dispose() {
    tabController.dispose();
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state){
//    if(state == AppLifecycleState.paused)
//        print("GoodBy from inside home page";
//    if(state == AppLifecycleState.resumed)
//      print("welcome back to home page");
//  }

  List companyname = [
    "The station",
    "the bridge ",
    "Baghdad ",
    "The Waves",
    "Ibtikar for  ",
    "Ibtikar for  ",
    "The station",
    "the bridge ",
    "Baghdad ",
    "The Waves",
    "Ibtikar for ",
    "Ibtikar for "
  ];
  List field = [
    "programming",
    "Design",
    "Human Development",
    "arduino",
    "mobile app",
    "programming",
    "Design",
    "Human Development",
    "arduino",
    "mobile app"
  ];

  void updateState(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    print(" ********************************************* inside scaffold");
    print(ModalRoute.of(context).settings.arguments);
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF4527A0),
          title: Text("Usta",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Poppins-Bold",
              )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
          bottom: TabBar(controller: tabController, tabs: [
            new Tab(
              text: ("Free"),
              icon: new Icon(
                Icons.mood,
                color: Color(0xFF69ff8e),
              ),
            ),
            new Tab(
              text: "Paid",
              icon: new Icon(
                Icons.hdr_strong,
                color: Color(0xFF8cffa9),
              ),
            ),
            new Tab(
              text: "Special",
              icon: new Icon(
                Icons.star,
                color: Color(0xFF8cffa9),
              ),
            ),
          ]),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text('Username'),
                accountEmail: Text('ANYEMAIL@gmail.comm'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Color(0xFF4527A0),
                ),
              ),
             InkWell(
                      onTap: () {
                        // todo: implement later on
                      },
                      child: ListTile(
                        title: Text('add new course'),
                        leading: Icon(Icons.add),
                      ),
                    ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Coursesattended()));
                },
                child: ListTile(
                  title: Text('Courses attended'),
                  leading: Icon(Icons.school),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FancyAppbarAnimation()));
                },
                child: ListTile(
                  title: Text('Notification'),
                  leading: Icon(Icons.notifications_active),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Specialrequest()));
                },
                child: ListTile(
                  title: Text('Special request'),
                  leading: Icon(Icons.stars),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TodoTwoPage()));
                },
                child: ListTile(
                  title: Text('Schedule'),
                  leading: Icon(Icons.date_range),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("Version"),
                            content: Text("v0.0.1"),
                          ));
                },
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help),
                ),
              ),
              IconButton(
                icon: ListTile(
                  leading: Icon(Icons.time_to_leave),
                  title: Text("Log out"),
                ),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.remove("token");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/landing-page', ModalRoute.withName(null));
                },
              )
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          ListView.separated(
            separatorBuilder: (context, pos) => Container(
              height: MediaQuery.of(context).size.width * 0.013,
              width: MediaQuery.of(context).size.width,
              color: Colors.black26,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return courseWidget(context: context,callback:updateState);
            },
          ),
          new ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.5),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 55.0,
                              height: 55.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.red,
                                backgroundImage: AssetImage("assets/a2.jpg"),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  companyname[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  field[index],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Card(
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Descreption:',
                                        style:
                                            TextStyle(color: Color(0xFFA9D0D9)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: FlatButton(
                            onPressed: () {},
                            color: Color(0xFF4527A0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "BOOK",
                              style: TextStyle(color: Color(0xFF8cffa9)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          new ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.5),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 55.0,
                              height: 55.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.red,
                                backgroundImage: AssetImage("assets/a2.jpg"),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  companyname[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  field[index],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Card(
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Descreption:',
                                        style:
                                            TextStyle(color: Color(0xFFA9D0D9)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: FlatButton(
                            onPressed: () {},
                            color: Color(0xFF4527A0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "BOOK",
                              style: TextStyle(color: Color(0xFF8cffa9)),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ]));
  }





}

String details = "this is the first usta tutorial on usta app \n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app \n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app \n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n"
    "this is the first usta tutorial on usta app\n";

Widget courseWidget({BuildContext context,callback,bool tutorProfile}) {
  return GestureDetector(
    onTap: () {
      // todo:implement later on
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.width * 0.7,
      // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4,minHeight: MediaQuery.of(context).size.height * 0.2),
      child: Column(
        children: <Widget>[
          if(!tutorProfile)
          courseUpperPart(context: context),
          courseBriefInfoPart(context: context),
          courseDetailsPart(context: context,callback:callback ),
          courseImageSlider(context: context),
          Text("20 photos")
        ],
      ),
    ),
  );
}




// ***** upper part of the course widget
Widget courseUpperPart({BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            /// profile circular picture
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.15 * 0.5),
                image: DecorationImage(
                    image: AssetImage("assets/1.jpg"), fit: BoxFit.fill)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.008,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    "Ahmed AbdulKareem Qasim\n\n Qasim",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "3 mins ago",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.23,
        height: MediaQuery.of(context).size.height * 0.045,
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            "سجل الان",
            textDirection: TextDirection.rtl,
            style: TextStyle(),
          ),
          color: Colors.amber,
        ),
      )
    ],
  );
}

// ********************************* done

// ***** brief info part of the course widget
Widget courseBriefInfoPart({BuildContext context}) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
    width: MediaQuery.of(context).size.width,
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "موضوع الدورة: Microsoft Excel tutorial",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              "تاريخ البدء: 1/1/2020",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              "وقت المحاضرة: 10 am ",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              "مدة الدورة : 10 محاضرات",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              "السعر: Free",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ],
        ),
      ),
    ),
  );
}

// **********************************done

// ****** details part of the course widget
Widget courseDetailsPart({BuildContext context,Function callback}) {
  return ConstrainedBox(
    constraints: isExpanded
        ? BoxConstraints()
        : BoxConstraints(
      maxHeight: MediaQuery.of(context).size.width * 0.42,
    ),
    child: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Container(
            // constraints: BoxConstraints(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(isExpanded
                        ? details
                        : details.substring(
                        0,
                        UstaFunctions.parseIntFrom(
                            MediaQuery.of(context).size.width * 0.5)) +
                        '  . . . . '),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          isExpanded ? "show less" : "show more",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: MediaQuery.of(context).size.width * 0.03),
                        ),
                        onPressed: () {
                          isExpanded = !isExpanded;
                          callback();
                        },
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    ),
  );
}

// ********************************************************************************************done

// ******** image slider of the course widget
Widget courseImageSlider({BuildContext context}) {
  return Container(
    constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.21,
        maxHeight: MediaQuery.of(context).size.height * 0.21),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.1,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, pos) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.02),
                image: DecorationImage(
                    image: AssetImage(
                        pos % 2 == 0 ? "assets/2.jpg" : "assets/1.jpg"),
                    fit: BoxFit.fill)),
          );
        }),
  );
}