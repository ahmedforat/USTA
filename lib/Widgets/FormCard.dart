import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/validators.dart';
import '../utils/GlobalVariables.dart';

class FormCard extends StatefulWidget {

  TextEditingController usernameController ;
  TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  FormCard({this.usernameController,this.passwordController,this.formKey});

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {

  // handle when the user hit the remeberme radioButton
  void radio() {
    setState(() {
      GlobalVariables.remeberMe = !GlobalVariables.remeberMe;
    });
  }

  // remeberMe widget
  Widget radioButton() => Container(
    width: 16.0,
    height: 16.0,
    padding: EdgeInsets.all(2.0),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2.0, color: Color(0xFF69ff8e))),
    child: GlobalVariables.remeberMe
        ? Container(

      width: double.infinity,
      height: double.infinity,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Color(0xFF69ff8e)),
    )
        : Container(),
  );



 /// build method
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Opacity(
        opacity: 1,
        child: new Container(

          width: double.infinity,
          height: ScreenUtil.getInstance().setHeight(510),
          decoration: BoxDecoration(

            color: Colors.black.withOpacity(0.45),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    Text("Login",

                        style: TextStyle(
                            color: Color(0xFF69ff8e),
                            fontSize: ScreenUtil.getInstance().setSp(45),
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .6)),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),

                    TextFormField(
                      controller: widget.usernameController,
                      style: new TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.grey, fontSize: 17.0)),
                      validator: (val){
                        return Validators.validateEmail(email: widget.usernameController.text);
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),

                    TextFormField(
                      controller: widget.passwordController,
                      style: new TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey, fontSize: 17.0)),
                      validator: (val) {
                        return Validators.validatePassword(password: widget.passwordController.text);
                      }
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[

                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Medium",
                              fontSize: ScreenUtil.getInstance().setSp(28)),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(

                          onTap: radio,
                          child: radioButton(),

                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Poppins-Bold",
                              color: Colors.white),
                        )
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );



  }
}



