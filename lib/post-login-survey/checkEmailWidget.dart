import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/ustaAPI/api.dart';


class CheckForValidationWidget extends StatefulWidget {
  @override
  _CheckForValidationWidgetState createState() => _CheckForValidationWidgetState();
}

class _CheckForValidationWidgetState extends State<CheckForValidationWidget> {
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isLoadingDone;
  bool isLoadingSendMe ;
  Widget _getSnackBar({String content}) => new SnackBar(content: Text(content));
  Widget _getCircularProgressIndicator() => CircularProgressIndicator(strokeWidth: 2.0,);
  @override
  void initState() {
    super.initState();
    isLoadingSendMe = false;
    isLoadingDone = false;
    scaffoldKey = new GlobalKey<ScaffoldState>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Registeration Complete"),
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
                child: Text("Thanks for signing up",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
              )
            ),

            Positioned(
              top: MediaQuery.of(context).size.height*0.19,
              child: Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),
                  width: MediaQuery.of(context).size.width,
                child: Text("Within minutes or less, Usta app will send you a mail that you will use "
                    "to verify your email\n\n\nPlease Check your Email",textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 17.0,),),
              )
            ),

            Positioned(
             top: MediaQuery.of(context).size.height*0.44,
              left: MediaQuery.of(context).size.width*0.23,
              child: Text(
                  "Didn't recieve a validation mail ?",
                  style: TextStyle(fontSize: 15.0)
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height*0.47,
              left: isLoadingSendMe ? MediaQuery.of(context).size.width * 0.445 : MediaQuery.of(context).size.width *0.34,
                child: isLoadingSendMe
                    ?_getCircularProgressIndicator()
                    :Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  child: RaisedButton(

                    onPressed:isLoadingDone?null: ()async{
                      setState(() {
                        isLoadingSendMe = true;
                      });
                      ConventionResponse response = await UstaAPI(isConnected:true).askForAnotherValidationMail();
                      setState(() {
                        isLoadingSendMe = false;
                      });
                      if(response.status == 404){
                        Navigator.of(context).pushNamedAndRemoveUntil("/signup-page", ModalRoute.withName(null));
                      }
                      if(response.status == 200)
                        scaffoldKey.currentState.showSnackBar(_getSnackBar(content: "Done !, Check your email"));
                      else
                        scaffoldKey.currentState.showSnackBar(_getSnackBar(content: response.payload));
                    },

                    child: Text("Send Me again",style: TextStyle(color: Colors.white),),
                    color:  Colors.blueAccent,

                    disabledColor: Colors.grey,
                  ),
                ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height*0.69,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Text(
                  "If you complete the verification process\nhit the button below",
              style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            Positioned(
              top: MediaQuery.of(context).size.height * 0.74,
              left: isLoadingDone?MediaQuery.of(context).size.width*0.7:MediaQuery.of(context).size.width * 0.59999,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.055,
                child: isLoadingDone?_getCircularProgressIndicator():RaisedButton(
                  disabledColor: Colors.grey,
                  onPressed:isLoadingSendMe?null: ()async{
                    setState(() {
                      isLoadingDone = true;
                    });
                    ConventionResponse res ;

                    try{
                      res = await UstaAPI(isConnected: true).checkVerification();

                      setState(() {
                        isLoadingDone = false;
                      });

                      if(res.status == 200)
                        Navigator.of(context).pushNamedAndRemoveUntil("/landing-page", ModalRoute.withName(null));
                      else
                      scaffoldKey.currentState.showSnackBar(_getSnackBar(content: res.payload));
                    }catch(err){
                      scaffoldKey.currentState.showSnackBar(_getSnackBar(content: "Error inside Catch"));
                    }

                  },
                  child:Text("Done",style: TextStyle(color: Colors.white),),
                  color: Colors.green,),
              ),
            )

          ],
        ),
      )
    );
  }
}
