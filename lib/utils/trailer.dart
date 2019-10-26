import 'dart:async';

import 'package:flutter/material.dart';
import '../utils/SharedPreferences.dart';
import 'AuthData.dart';


class TrailerPage extends StatefulWidget {
  @override
  _TrailerPageState createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {

  @override
  void initState() {
    Timer(Duration(milliseconds: 1400),(){

      AuthorizationManager.getPreferences().then((AuthData data){
        if(data.token != null){
          Navigator.of(context).pushNamedAndRemoveUntil("/home-page", ModalRoute.withName(null));
        }
        else if(data.init != null){
          Navigator.of(context).pushNamedAndRemoveUntil(data.init, ModalRoute.withName(null));
        }
        else{
          Navigator.of(context).pushNamedAndRemoveUntil("/landing-page", ModalRoute.withName(null));
        }

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
