import 'dart:io';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_login_page_ui/SignUp.dart';
import 'package:flutter_login_page_ui/homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widgets/FormCard.dart';
import 'Widgets/SocialIcons.dart';
import 'CustomIcons.dart';
import 'Widgets/intro.dart';
import './utils/GlobalVariables.dart';
import 'ustaAPI/api.dart';



void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{
        "/signup-page":(context) => SignUp(),
        "/landing-page":(context) => MyApp(),
        "/home-page":(context) => HomePage(),
        "/complete-credentials-page":(context) => IntroFourPage(),
      },
    ));
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  TextEditingController usernameController ;
  TextEditingController passwordController ;

  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  Map<String,dynamic> user;



  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );


  @override
  void initState() {
    super.initState();
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    formKey = new GlobalKey<FormState>();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    user = <String,dynamic>{};
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new WillPopScope(
      onWillPop: (){
        if(Navigator.of(context).canPop()){
         
        }
          return Future.value(false);
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF4527A0),
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Column(

              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 20.0,),

                  child: Image.asset(

                      "assets/logo1.png",
                      fit: BoxFit.contain

                  ),
                ),
                Expanded(
                  child: Container(),
                ),

              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/222.png",
                          width: ScreenUtil.getInstance().setWidth(110),
                          height: ScreenUtil.getInstance().setHeight(110),
                        ),
                        Text("",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(46),
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(170),
                    ),
                    Wrap(
                        children: <Widget>[
                          /// Form that hold the username and password
                          FormCard(
                            formKey: formKey,
                            usernameController: usernameController,
                            passwordController: passwordController,
                          ),
                        ]
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setSp(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        InkWell(

                          child: Container(

                            width: ScreenUtil.getInstance().setWidth(300),
                            height: ScreenUtil.getInstance().setHeight(90),

                            decoration: BoxDecoration(
                                color: Color(0xFF69ff8e),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(0.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0),
                                ]),
                            child: Material(

                              color: Color(0xFF36213e).withOpacity(0)
                              ,child: InkWell(
                              onTap: () async{
                                bool isValid = formKey.currentState.validate();

                                if(!isValid){
                                  // do nothing until the user enter valid credentials
                                }
                                else{
                                  user["username"] = usernameController.text;
                                  user["password"] = passwordController.text;
                                  user["rememberMe"] = GlobalVariables.remeberMe;
                                  ConventionResponse res;
                                  try{
                                    res = await new UstaAPI(isConnected: true).logIn(user: user);
                                    if(res.status != 200)
                                        scaffoldKey.currentState.showSnackBar(getSnackBar(content: res.payload));
                                    else
                                        Navigator.of(context).pushReplacementNamed("/home-page");
                                  }catch(err){
                                    print(err.toString());
                                    scaffoldKey.currentState.showSnackBar(getSnackBar(content: "Error inside Catch statemetn"));
                                  }
                                }

//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            HomePage()));
                              },
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color(0xFF4527A0),
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0),
                                ),
                              ),
                            ),
                            ),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                      width: ScreenUtil.getInstance().setWidth(60),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text("Social Media",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "Poppins-Medium"
                                ,letterSpacing: 2.0)),


                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center


                      ,children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF9a85cc),
                          Color(0xFF9a85cc),
                          Color(0xFF9a85cc),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: (){},
                      )
                      ,SocialIcon(
                        colors: [
                          Color(0xFF9a85cc),
                          Color(0xFF9a85cc),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF9a85cc),
                          Color(0xFF9a85cc),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        Text(
                          "New User? ",
                          style: TextStyle(color: Colors.white,  fontFamily: "Poppins-Medium"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("/signup-page");
                          },
                          child: Text("SignUp",
                              style: TextStyle(
                                  color:  Color(0xFF69ff8e),
                                  fontFamily: "Poppins-Bold")),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSnackBar({String content}) => SnackBar(
    content: Text(content),
  );
}
