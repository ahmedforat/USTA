import 'package:flutter/material.dart';


class CheckForValidationWidget extends StatefulWidget {
  @override
  _CheckForValidationWidgetState createState() => _CheckForValidationWidgetState();
}

class _CheckForValidationWidgetState extends State<CheckForValidationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify your Registeration"),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(

          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.width*0.05,
              left: MediaQuery.of(context).size.width*0.05,
              child: Text("Verify Your Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),
            ),

            Positioned(
              top:MediaQuery.of(context).size.height*0.14,
              left:MediaQuery.of(context).size.width * 0.05 ,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Text("Thanks for signing up",style: TextStyle(fontSize: 16),),
              )
            ),

            Positioned(
              top: MediaQuery.of(context).size.height*0.25,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01),
                  width: MediaQuery.of(context).size.width,
                child: Text("Usta app will send you a mail that you will use "
                    "to verify your email",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),),
              )
            ),
          ],
        ),
      )
    );
  }
}
