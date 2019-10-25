import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Widgets/Schedule.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widgets/Courses attended.dart';
import 'Widgets/Notification.dart';
import 'Widgets/Special request.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin,WidgetsBindingObserver {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state == AppLifecycleState.paused)
        print("GoodBy from inside home page");
    if(state == AppLifecycleState.resumed)
      print("welcome back to home page");
  }

  List companyname = [
    "The station",
    "the bridge ",
    "Baghdad ",
    "The Waves",
    "Ibtikar for  ",
    "Ibtikar for  ","The station",
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
    "mobile app","programming",
    "Design",
    "Human Development",
    "arduino",
    "mobile app"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomPadding: true,
        appBar: AppBar(

              backgroundColor: Color(0xFF4527A0),
              title: Text("USTA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.getInstance().setSp(35),
                    fontFamily: "Poppins-Bold",
                  )),

          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {

              },
            )
          ],

          bottom: TabBar(controller: tabController, tabs: [
            new Tab(
              text: ("Free")
              ,icon: new Icon(Icons.mood,color: Color(0xFF69ff8e),),
            ),
            new Tab(
              text: "paid",
              icon: new Icon(Icons.hdr_strong,color: Color(0xFF8cffa9),),
            ),
            new Tab(
              text: "spical",
              icon: new Icon(Icons.star,color: Color(0xFF8cffa9),),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Coursesattended()));
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
                          builder: (context) =>
                              FancyAppbarAnimation()));
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
                      builder: (context) =>
                      Specialrequest()));
                },
                child: ListTile(
                  title: Text('Special request'),
                  leading: Icon(Icons.stars),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TodoTwoPage()));
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
                  showDialog(context: context,
                  builder: (BuildContext context)=>AlertDialog(
                    title: const Text("Version"),
                    content: Text("v0.0.1"),
                  ));
                },
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(controller: tabController,

            children: [

              ListView.builder(itemCount: 10,shrinkWrap: true,
                itemBuilder: (BuildContext context,int index)=>Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 0.5),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Container(

                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                        child:  Row(
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
                                    SizedBox(width: 5.0,),
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(companyname[index],style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),) ,
                                        Text(field[index],style: TextStyle(color: Colors.grey),) ,

                                        Card(

                                          elevation: 0.5,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,

                                            children: <Widget>[

                                              Text('Descreption:',style: TextStyle(color: Color(0xFFA9D0D9)),)

                                            ],
                                          ),
                                        )

                                      ],

                                    ),

                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                  child: FlatButton(onPressed: (){},
                                    color: Color(0xFF4527A0)
                                    ,shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text("BOOK",style: TextStyle(color: Color(0xFF69ff8e)),),
                                  ),
                                )

                          ],
                        )
                    ),
                  ),
                ),),

          new ListView.builder(itemCount: 10,shrinkWrap: true,
          itemBuilder: (BuildContext context,int index)=>Container(
              width: MediaQuery.of(context).size.width,
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 0.5),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
            child:  Row(

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
                    SizedBox(width: 5.0,),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(companyname[index],style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),) ,
                        Text(field[index],style: TextStyle(color: Colors.grey),) ,

                        Card(

                          elevation: 0.5,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[

                              Text('Descreption:',style: TextStyle(color: Color(0xFFA9D0D9)),)

                            ],
                          ),
                        )

                      ],

                    ),

                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                  child: FlatButton(onPressed: (){},
                    color: Color(0xFF4527A0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("BOOK",style: TextStyle(color: Color(0xFF8cffa9)),),
                  ),
                )
              ],
            )
        ),
      ),
    ),),

          new ListView.builder(itemCount: 10,shrinkWrap: true,
            itemBuilder: (BuildContext context,int index)=>Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 1.0,vertical: 0.5),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Container(

                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                    child:  Row(

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
                            SizedBox(width: 5.0,),
                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(companyname[index],style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),) ,
                                Text(field[index],style: TextStyle(color: Colors.grey),) ,

                                Card(

                                  elevation: 0.5,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: <Widget>[

                                      Text('Descreption:',style: TextStyle(color: Color(0xFFA9D0D9)),)

                                    ],
                                  ),
                                )

                              ],

                            ),

                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          child: FlatButton(onPressed: (){},
                            color: Color(0xFF4527A0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("BOOK",style: TextStyle(color: Color(0xFF8cffa9)),),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),),
        ]
        )
    );
  }
}


