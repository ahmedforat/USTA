import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/ustaAPI/api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widgets/intro.dart';

import './utils/validators.dart' ;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 var newUser = <String,dynamic>{};

  // global keys for scaffold and form
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();


  // controllers to get access to the data from the textFormFields
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneNumberController  = new TextEditingController();


  




  var Gender=['Male','Female',];
  var selectedGender='Male';
  var professionalState=['Employee','Unemployed',];
  var selectedProfessionalState='Employee';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
            child: Form(
              key: formKey,
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
                    controller: firstNameController,
                      decoration: new InputDecoration(
                          labelText: "FirstName",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide())),
                      validator: (input){
                        return Validators.validateFirstAndLastNames(name: firstNameController.text);
                      }),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  new TextFormField(
                    controller: lastNameController,
                      decoration: new InputDecoration(
                          labelText: "LastName",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide())),
                      validator: (val) {
                        return Validators.validateFirstAndLastNames(name: lastNameController.text);
                      }),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  new TextFormField(

                      controller: emailController,
                      decoration: new InputDecoration(
                          labelText: "Email",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide())),
                      validator: (val) {
                        return Validators.validateEmail(email: emailController.text);
                      }),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  new TextFormField(
                    controller: passwordController,
                      obscureText: true,
                      decoration: new InputDecoration(
                          labelText: "Password",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide())),
                      validator: (val) {
                        return Validators.validatePassword(password: passwordController.text);
                      }),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  new TextFormField(
                      maxLength: 11,
                      controller: phoneNumberController,
                      decoration: new InputDecoration(
                          labelText: "PHONE NO.",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          )),
                      validator: (val) {
                        return Validators.validatePhoneNumber(phoneNumber:phoneNumberController.text);
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
                        value: selectedGender,
                      ),
                      DropdownButton<String>(

                        iconSize: 20,
                        style: TextStyle(
                            color: Color(0xFF4527A0),letterSpacing: 2,fontFamily: "Poppins-Bold"
                        ),
                        items: professionalState.map((String dropDownStringItem1){
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
                        value: selectedProfessionalState,
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 40.0),
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
                          onTap: ()async {

                            if(formKey.currentState.validate()){

                              newUser["firstName"] = firstNameController.text;
                              newUser["lastName"] = lastNameController.text;
                              newUser["email"] = emailController.text;
                              newUser["password"] = passwordController.text;
                              newUser["phoneNumber"] = phoneNumberController.text;
                              newUser["gender"] = selectedGender;
                              newUser["isEmployed"] = selectedProfessionalState == professionalState[0];

                              setState(() {
                                isLoading = true;
                              });

                              ConventionResponse res;

                              try{
                                res = await UstaAPI(isConnected: true).signUpNewUser(newUser: newUser);
                                setState(() {
                                  isLoading = false;
                                });
                                if(res.status != 201)
                                    scaffoldKey.currentState.showSnackBar(getSnackBar(content: res.payload));
                                else{
                                  Navigator.of(context).pushNamedAndRemoveUntil("/complete-credentials-page",
                                      ModalRoute.withName(null));
                                }
                              }catch(err){
                                scaffoldKey.currentState.showSnackBar(getSnackBar(content: "Error"));
                                print(err.toString());
                              }


                            }
                          },
                          child: Center(
                            child: isLoading
                                ?getCircularProgress()
                                :getText()
                          ),
                        ),
                      ),
                    ),
                  )

                ],

              ),
            )

        ),



      ),


    );

  }
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this.selectedGender = newValueSelected;
    });
  }
  void _onDropDownItemSelected1(String newValueSelected1){
    setState(() {
      this.selectedProfessionalState = newValueSelected1;
    });
  }

  /// [this function just for testing]
 void printData(){
    print("FirstName : " + firstNameController.text);
    print("LastName : " + lastNameController.text);
    print("Email : " + emailController.text);
    print("Password : " + passwordController.text);
    print("phoneNumber : " + phoneNumberController.text);
    print("gender : " + selectedGender);
    print("isEmployed : " + selectedProfessionalState.toString());

 }

  SnackBar getSnackBar({String content,int status}){
    return new SnackBar(
      content: Text(content),
      action: SnackBarAction(label:"Reload", onPressed: (){}),
    );
 }

 Widget getCircularProgress() => CircularProgressIndicator();

  Widget getText() => Text(
    "SIGNUP",
    style: TextStyle(
        color: Color(0xFF69ff8e),
        fontFamily: "Poppins-Bold",
        fontSize: 18,
        letterSpacing: 1.0),
  );

  bool isLoading = false;
}
