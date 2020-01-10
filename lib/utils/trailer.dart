import 'dart:async';
import 'package:flutter/material.dart';
import '../homepage.dart';
import '../utils/SharedPreferences.dart';
import 'AuthData.dart';


class TrailerPage extends StatefulWidget {
  @override
  _TrailerPageState createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {

  @override
  void initState() {
    print("****************************************************************************** Trailer page");
    Future.delayed(Duration(milliseconds: 1300),(){
      AuthorizationManager.getPreferences().then((AuthData data){
        print("Trailer page");
        print(data.toString());
        if(!data.isNull){
          if(data.init != null)
            Navigator.of(context).pushReplacementNamed(data.init);

          else
            Navigator.of(context).pushReplacementNamed('/home-page',arguments: "Hello Args");

        }else
          Navigator.of(context).pushReplacementNamed("/landing-page");

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Usta",style: TextStyle(fontSize: 40.0,color: Colors.blueAccent),)
          ],
        ),
      ),
    );
  }
}
