import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_login_page_ui/utils/GlobalVariables.dart';
import 'package:http/http.dart' as http;



 //     [208  ==  username already exist (already reported) ]
 ///     [206 == Partial content (missing data)]
///      [901  ==  no such username]
///      [902  ==  no internet connection]
///      [111  ==  new bug inside flutter ]

class UstaAPI{
  bool isConnected ;
  UstaAPI({this.isConnected});
  Map _header = {};
  final Map<String,String> SIGNUP_AND_SIGNIN_Header = <String,String>{
    "Accept":"application/json",
    "content-type":"application/json"
  };
//method that handle signing up a new user
  Future<ConventionResponse> signUpNewUser({Map<String,dynamic> newUser}) async {

    if(!isConnected){
      return ConventionResponse.failedConnection();   /// status 902
    }

    const String SIGN_UP_URL = 'http://10.0.2.2:9000/signup';
    http.Response response;



    try{
      response = await http.post(Uri.encodeFull(SIGN_UP_URL),body:json.encode(newUser) ,headers: SIGNUP_AND_SIGNIN_Header).timeout(new Duration(seconds: 7));
    } on TimeoutException{
      return ConventionResponse.serverNotResponding();  ///status 503
    }catch(err){
      print("yahoo here is the problem");
      print(err.toString());
      return ConventionResponse.newBugToBeHandeled();   /// status 111
    }

//    Map<String,dynamic> recievedData = json.decode(response.body);
    ConventionResponse result = ConventionResponse.newBugToBeHandeled();
//
//    print(recievedData);
//    print("recieved data");

    switch(response.statusCode){
      case 201 :   // created
        result = new ConventionResponse.success201();  /// status 201 created !
        break;
      case 500:    // internal server error
        result = new ConventionResponse.internalServerError();  /// status 500
        break;
      case 208:    // already reported
        result = new ConventionResponse.usernameAlreadyExist();   /// status 900
        break;

      default :print("Hello World new thing has not been handled");
    }
    return result;


  }


  ///*  [**********************************************************************************************]
  ///*  [method that handle logging in a user already exist in the database (had sigend up previously)]
  ///* [Hello World, This is Karrar the hero of coding and programming]
  ///* [***********************************************************************************************]

  Future<ConventionResponse> login({Map<String,dynamic> user}) async{

    if(!isConnected){
      return ConventionResponse.failedConnection();
    }

    String loginURL = "http://10.0.2.2:9000/login";
    http.Response response;
    Map recievedData;


    try{
      response = await http.post(Uri.encodeFull(loginURL),headers: SIGNUP_AND_SIGNIN_Header,body: json.encode(user)).timeout(Duration(seconds: 7));
    } on TimeoutException{
      return ConventionResponse.serverNotResponding();
    }catch(err){
      // print(err);            // just in case we need debugging
      return ConventionResponse.newBugToBeHandeled();
    }

    recievedData = json.decode(response.body);

    print("recieved json ***************");
    print(recievedData);
    print("recieved json ***************");

    ConventionResponse result;

    switch(response.statusCode){

      case 200 :
        GlobalVariables.authorizationToken = recievedData["token"];
        print("jwt token ***************");
        print(GlobalVariables.authorizationToken);
        print("jwt token ***************");
        result = new ConventionResponse.success200();
        break;
      case 404:
        result = new ConventionResponse.invalidUsernameOrPassword();
        break;
      case 500:
        result = new ConventionResponse.internalServerError();
        break;

      case 901:
        result = new ConventionResponse.noSuchUsername();
        break;

      default :
        result = new ConventionResponse.newBugToBeHandeled();
    }

    return result;
  }


  ///* [*******************************************************]
  ///* [method that handle password forgotten]
  ///* [*******************************************************]

  Future<ConventionResponse> handlePasswordForgotten({Map<String,String> user})async{

    Map recievedData;
    http.Response response;
    String forgetPasswordURL = "http://10.0.2.2:4000/forget-password";

    try{
      response = await http.post(Uri.encodeFull(forgetPasswordURL),headers: _header,body: user).timeout(Duration(seconds: 7));
    } on TimeoutException{
      return ConventionResponse.serverNotResponding();
    }catch(err){
      return ConventionResponse.internalServerError();
    }

    ConventionResponse result;
    recievedData = json.decode(response.body);

    switch(recievedData['status']){
      case 200:
        result = new ConventionResponse.success201();
        break;
      case 500:
        result = new ConventionResponse.internalServerError();
        break;

      default:
        print("Hello World");
    }
    return result;
  }

  Future<ConventionResponse> savePostSignupData({Map<String,dynamic> data}) async{
    if(!isConnected){
      return ConventionResponse.failedConnection();
    }
    
    http.Response response;
    String url = "http://10.0.2.2:9000/complete-credentials";
    Duration timeoutDuration = new Duration(seconds: 7);
    ConventionResponse result;
    try{
      response  = await http.post(Uri.encodeFull(url),body: json.encode(data),headers: {"content-type":"application/json"}).timeout(timeoutDuration);
    }
    on TimeoutException {
      return ConventionResponse.serverNotResponding();
     } catch(err){
      print("Here is a problem");
       return ConventionResponse.newBugToBeHandeled();
    }

      print(response.statusCode);

   switch(response.statusCode){
     case 200 : 
          result = ConventionResponse.success200();
          break;
    case 500 :
          result =  ConventionResponse.internalServerError();
          break;
     case 404:
        result = ConventionResponse.noSuchUsername();
        break;
    default:
        result = ConventionResponse.newBugToBeHandeled();
        break;
   }
    return result;
  }
}

class ConventionResponse{
  String _label;
  dynamic _payload;
  int _status;

  String get label => this._label;
  dynamic get payload => this._payload;
  int get status => this._status;

  void  setLabel(String label){
    this._label = label;
  }

  void setPayload(payload){
    this._payload = payload;
  }

  void setStatus(status){
    this._status = status;
  }

  ConventionResponse({String label,String payload,int status}){
    this._label = label;
    this._payload = payload;
    this._status = status;
  }

  factory ConventionResponse.failedConnection(){
    return ConventionResponse(
        label: "failed",
        payload: "No Internet Connection",
        status:  902
    );
  }

  factory ConventionResponse.internalServerError(){
    return new ConventionResponse(
        label: "failed",
        payload: "Something Went Wrong",
      status: 500
    );
  }

  factory ConventionResponse.serverNotResponding(){
    return new ConventionResponse(
        label: "failed",
        payload: "Server is not Responding",
        status: 503
    );
  }

  factory ConventionResponse.success201(){
    return new ConventionResponse(
        label: "success",
        status: 201
    );
  }

  factory ConventionResponse.success200() => new ConventionResponse(
    status: 200,
    label: "success"
  );

  factory ConventionResponse.notValidEmail() => new ConventionResponse(
    status: 422,       // unprocessable entity
    label:"failed"
  );

  factory ConventionResponse.usernameAlreadyExist(){
    return ConventionResponse(
        label: "failed",
        payload: "Email you entered is already exist, try to login in",
      status: 208
    );
  }

  factory ConventionResponse.invalidUsernameOrPassword() => ConventionResponse(
    status: 404,
    label: "failed",
    payload: "Invalid username and/or password"
  );

  factory ConventionResponse.noSuchUsername(){
    return ConventionResponse(
        label: "failed",
        payload: "Username you entered is not registered , Try to sign up",
      status: 404
    );
  }

  factory ConventionResponse.newBugToBeHandeled() => new ConventionResponse(
    status: 111,
    label: "failed",
    payload: "new bug inside flutter has been occured",

  );
}