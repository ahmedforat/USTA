import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widgets/intro.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var Gender=['Male','Female',];
  var GenderItemSelected='Male';
  var State=['Employee','Unemployed',];
  var EducationItemSelected='Employee';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF554971)
      ,resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        title: Text("USTA",
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil.getInstance().setSp(35),
              fontFamily: "Poppins-Bold",
            )),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Registration",
                    style: TextStyle(
                      color: Color(0xFF4527A0),
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "FirstName",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide())),
                    validator: (val) {
                      if (val.length == 0) {
                        return "FirstName cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "LastName",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide())),
                    validator: (val) {
                      if (val.length == 0) {
                        return "LastName cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide())),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Email cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                new TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                        labelText: "PassWord",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide())),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Password cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(10),
                ),
                new TextFormField(
                    maxLength: 11,
                    decoration: new InputDecoration(
                        labelText: "PHONE NO.",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        )),
                    validator: (val) {
                      if (val.length == 0) {
                        return "PHONE NO. cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number),
                

                SizedBox(

                  height: ScreenUtil.getInstance().setHeight(30),
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget>[

                    DropdownButton<String>(

                    iconSize: 20,
                    style: TextStyle(
                        color: Color(0xFF4527A0),letterSpacing: 2,fontFamily: "Poppins-Bold"
                    ),
                    items: Gender.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.verified_user,),
                              Text(dropDownStringItem)

                            ],
                          )
                      ,


                      );
                    }).toList(),
                    onChanged: (String newValueSelected){
                      _onDropDownItemSelected(newValueSelected);

                    },
                    value: GenderItemSelected,
                  ),
                  DropdownButton<String>(

                    iconSize: 20,
                    style: TextStyle(
                        color: Color(0xFF4527A0),letterSpacing: 2,fontFamily: "Poppins-Bold"
                    ),
                    items: State.map((String dropDownStringItem1){
                      return DropdownMenuItem<String>(
                          value: dropDownStringItem1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.verified_user),
                              Text(dropDownStringItem1)
                            ],
                          ));
                    }).toList(),
                    onChanged: (String newValueSelected1){
                      _onDropDownItemSelected1(newValueSelected1);
                     
                    },
                    value: EducationItemSelected,
                  ),
                  ],
                ),
                InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(330),
                    height: ScreenUtil.getInstance().setHeight(100),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xFF290f7a),
                          Color(0xFF4527A0)
                        ]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF4527A0).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0),
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      IntroFourPage()));
                        },
                        child: Center(
                          child: Text(
                            "SIGNUP",
                            style: TextStyle(
                                color: Color(0xFF69ff8e),
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                letterSpacing: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                )

              ],

            ),

        ),



      ),


    );

  }
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {

      this.GenderItemSelected= newValueSelected;


    });
  }
  void _onDropDownItemSelected1(String newValueSelected1){
    setState(() {

      this.EducationItemSelected= newValueSelected1;


    });
  }
  
}
