import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_page_ui/ustaAPI/api.dart';
import 'package:flutter_login_page_ui/ustaAPI/model.dart';
import 'package:flutter_login_page_ui/utils/global_widget.dart';
import 'package:flutter_login_page_ui/utils/responsive_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './utils/validators.dart';


var newUser = <String, dynamic>{};
String selectedUni;
String selectedCollege;

// global keys for scaffold and form
GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
GlobalKey<FormState> formKey = new GlobalKey<FormState>();

// controllers to get access to the data from the textFormFields
TextEditingController firstNameController = new TextEditingController();
TextEditingController lastNameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
TextEditingController phoneNumberController = new TextEditingController();
bool graduated = false;

FocusNode firstNameFocusNode;
FocusNode lastnameFocusNode;
FocusNode emailFocusNode;
FocusNode passwordFocusNode;
FocusNode phoneFocusNode;

SharedPreferences preferences;

var Gender = [
  'male',
  'female',
];
String selectedGender = 'male';

var professionalState = [
  'employed',
  'unEmployed',
];
var selectedProfessionalState = 'employed';

List<Feed> feed;
bool isFetching = true;
Connectivity connectivity;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;

  static SnackBar getSnackBar({String content, int status}) {
    return new SnackBar(
      content: Text(content),
      action: SnackBarAction(label: "Reload", onPressed: () {}),
    );
  }

  void printData() {
    print("FirstName : " + firstNameController.text);
    print("LastName : " + lastNameController.text);
    print("Email : " + emailController.text);
    print("Password : " + passwordController.text);
    print("phoneNumber : " + phoneNumberController.text);
    print("gender : " + selectedGender);
    print("isEmployed : " + selectedProfessionalState.toString());
    print("university " + selectedUni);
    print("college " + selectedCollege);
  }

  Widget getCircularProgress() => CircularProgressIndicator();

  int firstIndexOf(String text) {
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '\\') return i;
    }
    return 0;
  }

  Widget failedLoadingMessage() => Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height:ResponsiveDesign.justify(context: context,dimension: 10.0),),
          Icon(Icons.error,size: ResponsiveDesign.justify(context: context,dimension: 80.0),color: Colors.grey,),
          SizedBox(height:ResponsiveDesign.justify(context: context,dimension: 10.0),),
          Text(
              'Oops! Something went\n wrong',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ResponsiveDesign.justify(context: context,dimension: 20.0)),),
          SizedBox(height:ResponsiveDesign.justify(context: context,dimension: 50.0),),
          Text(
            'It might be the server is not responding\nor there is no internet connection\n\n'
            'make sure your device is connected\n to the internet and try again',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: ResponsiveDesign.justify(context: context,dimension: 14.0)),),
          SizedBox(
            height: ResponsiveDesign.justify(context: context, dimension: 80.0),
          ),
          RaisedButton(
            child: Text("Relaod"),
            onPressed: () {
              setState(() {
                isFetching = true;
              });

              checkConnection().then((bool connectionState) {
                if (!connectionState) {
                  setState(() {
                    isFetching = true;
                    Future.delayed(Duration(milliseconds: 2500), () {
                      setState(() {
                        isFetching = false;
                      });
                    });
                  });
                } else
                  API(isConnected: connectionState)
                      .fetchUniversitiesList()
                      .then((ConventionResponse res) {
                    List data = res.status == 200 ? res.payload : null;
                    setState(() {
                      initialFetchingRes = res;
                      isFetching = false;
                      if(data == null || data.length == 0)
                          feed = null;
                      else {
                        feed = data.map((f) => Feed.fromJson(json: f)).toList();
                        feed.forEach((f) {
                          f.sub.add("اخرى");
                        });
                      }
                    });
                  }).catchError((err) {
                    setState(() {
                      isFetching = false;
                    });
                    showDialog(
                        context: context,
                        builder: (context) => debugMessageDialog(
                            context: context, error: err.toString()));
                  });
              });
            },
          )
        ],
      ));

  /// the border radius of the text Fields
  double textFieldRadius;
  double textFieldsSeparator;
  ConventionResponse initialFetchingRes;

  Future<bool> checkConnection() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  void initState() {
    connectivity = new Connectivity();
    firstNameFocusNode = new FocusNode();
    lastnameFocusNode = new FocusNode();
    emailFocusNode = new FocusNode();
    passwordFocusNode = new FocusNode();
    phoneFocusNode = new FocusNode();

    checkConnection().then((bool connectionState) {
      API(isConnected: connectionState)
          .fetchUniversitiesList()
          .then((ConventionResponse res) {
        List data = res.status == 200 ? res.payload : null;
        print(data);
        setState(() {
          initialFetchingRes = res;
          isFetching = false;
          if(data == null || data.length == 0)
            feed = null;
          else {
            print('inside else statement');
            feed = data.map((f) => Feed.fromJson(json: f)).toList();
            feed.forEach((f) {
              f.sub.add("اخرى");
            });
          }
        });

      }).catchError((err) {
        print('line 167');
        print("We've got an error");
        print(err);
        setState(() {
          isFetching = false;
          feed = null;
        });
        showDialog(
            context: context,
            builder: (context) =>
                debugMessageDialog(context: context, error: err.toString()));
      });

    });

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      setState(() {
        textFieldRadius =
            ResponsiveDesign.justify(context: context, dimension: 14.0);
        textFieldsSeparator =
            ResponsiveDesign.justify(context: context, dimension: 20.0);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastnameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF4527A0),
          title: Text("USTA",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: isFetching
            ? Center(child: getCircularProgress())
            : feed == null
                ? failedLoadingMessage()
                : Container(
                    padding: EdgeInsets.all(ResponsiveDesign.setWidth(
                        context: context, width: 13.0)),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: ResponsiveDesign.justify(
                                  context: context, dimension: 20.0),
                            ),
                            new TextFormField(
                                focusNode: firstNameFocusNode,
                                controller: firstNameController,
                                decoration: new InputDecoration(
                                    labelText: "FirstName",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            textFieldRadius ?? 14.0),
                                        borderSide: new BorderSide())),
                                validator: (input) {
                                  return Validators.validateFirstAndLastNames(
                                      name: firstNameController.text.trim());
                                }),
                            SizedBox(
                              height: textFieldsSeparator ?? 20.0,
                            ),
                            GestureDetector(
                              child: new TextFormField(
                                  focusNode: lastnameFocusNode,
                                  controller: lastNameController,
                                  decoration: new InputDecoration(
                                      labelText: "Lastname",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                          borderRadius:
                                              new BorderRadius.circular(
                                                  textFieldRadius ?? 14.0),
                                          borderSide: new BorderSide())),
                                  validator: (val) {
                                    return Validators.validateFirstAndLastNames(
                                        name: lastNameController.text.trim());
                                  }),
                            ),
                            SizedBox(
                              height: textFieldsSeparator ?? 20.0,
                            ),
                            new TextFormField(
                                focusNode: emailFocusNode,
                                controller: emailController,
                                decoration: new InputDecoration(
                                    labelText: "Email",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            textFieldRadius ?? 14.0),
                                        borderSide: new BorderSide())),
                                validator: (val) {
                                  return Validators.validateEmail(
                                      email: emailController.text.trim());
                                }),
                            SizedBox(
                              height: textFieldsSeparator ?? 20,
                            ),
                            new TextFormField(
                                focusNode: passwordFocusNode,
                                controller: passwordController,
                                obscureText: true,
                                decoration: new InputDecoration(
                                    labelText: "Password",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(
                                            textFieldRadius ?? 14.0),
                                        borderSide: new BorderSide())),
                                validator: (val) {
                                  return Validators.validatePassword(
                                      password: passwordController.text);
                                }),
                            SizedBox(
                              height: textFieldsSeparator ?? 20,
                            ),
                            new TextFormField(
                                focusNode: phoneFocusNode,
                                maxLength: 11,
                                controller: phoneNumberController,
                                decoration: new InputDecoration(
                                    labelText: "PHONE NO.",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(
                                          textFieldRadius ?? 14.0),
                                      borderSide: new BorderSide(),
                                    )),
                                validator: (val) {
                                  return Validators.validatePhoneNumber(
                                      phoneNumber:
                                          phoneNumberController.text.trim());
                                },
                                keyboardType: TextInputType.number),
                            SizedBox(
                              height: textFieldsSeparator ?? 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                DropdownButton<String>(
                                  iconSize: textFieldsSeparator ?? 20.0,
                                  style: TextStyle(
                                    color: Color(0xFF4527A0),
                                    letterSpacing: 2,
                                  ),
                                  items: Gender.map((String gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(gender),
                                          SizedBox(
                                              width: ResponsiveDesign.setWidth(
                                                  context: context,
                                                  width: 10.0))
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String val) {
                                    setState(() => selectedGender = val);
                                  },
                                  value: selectedGender,
                                ),
                                DropdownButton<String>(
                                  iconSize: textFieldsSeparator ?? 20,
                                  style: TextStyle(
                                    color: Color(0xFF4527A0),
                                    letterSpacing: 2,
                                  ),
                                  items: professionalState
                                      .map((String profession) {
                                    return DropdownMenuItem<String>(
                                        value: profession,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(profession),
                                            SizedBox(
                                              width: ResponsiveDesign.setWidth(
                                                  context: context,
                                                  width: 10.0),
                                            )
                                          ],
                                        ));
                                  }).toList(),
                                  onChanged: (String val) {
                                    setState(() {
                                      selectedProfessionalState = val;
                                    });
                                  },
                                  value: selectedProfessionalState,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ResponsiveDesign.setHeight(
                                  context: context, height: 30.0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ResponsiveDesign.setWidth(
                                      context: context, width: 10.0)),
                              child: Text(
                                "graduated ?",
                                style: TextStyle(
                                    fontSize: ResponsiveDesign.justify(
                                        context: context, dimension: 20.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ResponsiveDesign.setWidth(
                                      width: 40.0, context: context)),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: ResponsiveDesign.setWidth(
                                        context: context, width: 130.0),
                                    height: ResponsiveDesign.setHeight(
                                        context: context, height: 50.0),
                                    child: Center(
                                      child: RadioListTile(
                                        activeColor: Colors.blueAccent,
                                        title: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize:
                                                  ResponsiveDesign.justify(
                                                      context: context,
                                                      dimension: 15.0)),
                                        ),
                                        value: false,
                                        groupValue: graduated,
                                        onChanged: (val) {
                                          setState(() {
                                            graduated = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ResponsiveDesign.setWidth(
                                        context: context, width: 130.0),
                                    height: ResponsiveDesign.setHeight(
                                        context: context, height: 50.0),
                                    child: Center(
                                      child: RadioListTile(
                                        title: Text("Yes"),
                                        value: true,
                                        groupValue: graduated,
                                        onChanged: (val) {
                                          setState(() {
                                            graduated = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveDesign.justify(
                                  context: context, dimension: 60.0),
                            ),
                            if (feed != null)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: ResponsiveDesign.setHeight(
                                    context: context, height: 60.0),
                                child: Center(
                                  child: DropdownButton(
                                    items: feed.map((Feed f) {
                                      return new DropdownMenuItem<String>(
                                        child: Text("${f.name}"),
                                        value: f.name,
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedCollege = null;
                                        selectedUni = val;
                                      });
                                    },
                                    value: selectedUni,
                                    hint: Text("اختر الجامعة"),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: ResponsiveDesign.setHeight(
                                  context: context, height: 30.0),
                            ),
                            if (feed != null)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: ResponsiveDesign.setHeight(
                                    context: context, height: 60.0),
                                //alignment: Alignment.center,
                                child: Center(
                                  child: DropdownButton(
//                    selectedItemBuilder: selectedUni == null?null: (context){
//                      return feed.firstWhere((Feed item){
//                        return item.name == selectedUni;
//                      }).sub.map<Widget>((college){
//                        return Text(
//                          college.length > 40
//                              ? college.trim().substring(0,firstIndexOf(college)) + '\n' + college.substring(firstIndexOf(college)+1)
//                              : college.trim(),
//                          style: TextStyle(fontSize: 10),
//                          textAlign: TextAlign.center,
//                        );
//                      }).toList();
//                    },
                                    onChanged: selectedUni == null
                                        ? null
                                        : (val) {
                                            setState(() {
                                              selectedCollege = val;
                                            });
                                          },
                                    items: selectedUni == null
                                        ? []
                                        : feed
                                            .firstWhere((Feed item) {
                                              return item.name == selectedUni;
                                            })
                                            .sub
                                            .map((college) {
                                              return new DropdownMenuItem(
                                                child: Text(
                                                  "${college.trim()[0] == '/' ? college.trim().substring(1) : college.trim()}",
                                                  style: TextStyle(
                                                      fontSize: ResponsiveDesign
                                                          .setFontSize(
                                                              context: context,
                                                              fontSize: 10.0)),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                value: college.trim()[0] == '/'
                                                    ? college
                                                        .trim()
                                                        .substring(1)
                                                    : college.trim(),
                                              );
                                            })
                                            .toList(),
                                    value: selectedCollege,
                                    hint: Text("اختر الكلية او المعهد"),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: ResponsiveDesign.setHeight(
                                  height: 40, context: context),
                            ),
                            Container(
                              width: ResponsiveDesign.screenWidth(context),
                              alignment: Alignment.center,
                              child: Container(
                                width:
                                    ResponsiveDesign.screenWidth(context) * 0.9,
                                height: ResponsiveDesign.screenHeight(context) *
                                    0.07,
                                child: RaisedButton(
                                    color: Color(0xFF4527A0),
                                    child: isLoading
                                        ? getCircularProgress()
                                        : Text(
                                            "Done",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize:
                                                  ResponsiveDesign.setFontSize(
                                                      fontSize: 18,
                                                      context: context),
                                            ),
                                          ),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        newUser["firstName"] =
                                            firstNameController.text.trim();
                                        newUser["lastName"] =
                                            lastNameController.text.trim();
                                        newUser["email"] =
                                            emailController.text.trim();
                                        newUser["password"] =
                                            passwordController.text;
                                        newUser["phoneNumber"] =
                                            phoneNumberController.text.trim();
                                        newUser["gender"] = selectedGender;
                                        newUser["isEmployed"] =
                                            selectedProfessionalState ==
                                                professionalState[0];
                                        newUser["graduated"] = graduated;
                                        newUser["university"] = selectedUni;
                                        newUser["college"] = selectedCollege;
                                        print(newUser);
                                        setState(() {
                                          isLoading = true;
                                        });

                                        ConventionResponse res;
                                        try {
                                          bool isConnected = await checkConnection();
                                          res = await API(isConnected: isConnected)
                                              .signUpNewUser(
                                              newUser: newUser);
                                          print(res.status);
                                          setState(() {
                                            isLoading = false;
                                          });

                                          if (res.status != 201 &&
                                              res.status !=
                                                  111) // production errors
                                            scaffoldKey.currentState
                                                .showSnackBar(getSnackBar(
                                                    content: res.payload));

                                          /// for unhandled errors
                                          else if (res.status == 111) {
                                            // unhandled errors
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    debugMessageDialog(
                                                        context: context,
                                                        error: res.payload));
                                          } else {
                                            preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            await preferences.setString(
                                                "init", "/verify-your-email");
                                            await preferences.setString(
                                                "email", newUser["email"]);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    "/verify-your-email",
                                                    ModalRoute.withName(null));
                                          }
                                        } catch (err) {
                                          print("Hello Error");
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  debugMessageDialog(
                                                      error: err.toString(),
                                                      context: context));
                                        }
                                      }
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
      ),
    );
  }
}
