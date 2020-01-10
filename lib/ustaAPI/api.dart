import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_login_page_ui/utils/GlobalVariables.dart';
import 'package:flutter_login_page_ui/utils/SharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

//     [208  ==  username already exist (already reported) ]
///     [206 == Partial content (missing data)]
///      [901  ==  no such username]
///      [902  ==  no internet connection]
///      [111  ==  new bug inside flutter ]

class API {
  String _getUrl({String path}) {
    return "http://192.168.0.106:8000" + path;
    //return 'https://austaproto.herokuapp.com' + path;
  }

  bool isConnected;

  API({this.isConnected});

  final Map<String, String> _signUpLoginHeader = <String, String>{
    "Accept": "application/json",
    "content-type": "application/json"
  };

//method that handle signing up a new user
  Future<ConventionResponse> signUpNewUser(
      {Map<String, dynamic> newUser}) async {
    final String signUpURL = _getUrl(path: "/api/v1/users/signup");
    http.Response response;

    if (!isConnected)
      return ConventionResponse.failedConnection();

    /// status 902
    ConventionResponse result;
    try {
      response = await http
          .post(Uri.encodeFull(signUpURL),
              body: json.encode(newUser), headers: _signUpLoginHeader)
          .timeout(new Duration(milliseconds: 12000));
    } on TimeoutException {
      return ConventionResponse.serverNotResponding(); // status 503
    } catch (err) {
      print("we got a problem");
       result =
          new ConventionResponse.newBugToBeHandled() // status = 111
            ..setPayload(payload: err.toString());
      return result;
    }


    switch (response.statusCode) {
      case 201: // created
        result = new ConventionResponse.success201();

        /// status 201 created ! and a validation mail has been sent
        break;
      case 500: // internal server error
        result = new ConventionResponse.internalServerError();

        /// status 500
        break;
      case 208:
        result = new ConventionResponse
            .usernameAlreadyExist(); // 208  already reported
        break;
      default:
        result = new ConventionResponse.newBugToBeHandled();
        result.setPayload(
            payload:
                '${response.statusCode},this is a status code not implemented by your app');
    }
    return result;
  }

  ///*  [**********************************************************************************************]
  ///*  [method that handle logging in a user already exist in the database (had sigend up previously)]
  ///* [Hello World, This is Karrar the hero of coding and programming]
  ///* [***********************************************************************************************]

  Future<ConventionResponse> login({Map<String, dynamic> user}) async {
    if (!isConnected) {
      return ConventionResponse.failedConnection();
    }

    String loginURL = _getUrl(path: "/api/v1/users/login");
    http.Response response;
    Map recievedData;

    try {
      response = await http
          .post(Uri.encodeFull(loginURL),
              headers: _signUpLoginHeader, body: json.encode(user))
          .timeout(Duration(seconds: 7));
    } on TimeoutException {
      return ConventionResponse.serverNotResponding();
    } catch (err) {
      print(err); // just in case we need debugging
      return ConventionResponse.newBugToBeHandled();
    }

//    print("recieved json ***************");
//    print(recievedData);
//    print("recieved json ***************");

    ConventionResponse result;

    switch (response.statusCode) {
      case 200:
        {
          recievedData = json.decode(response.body);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString(
              "token", "bearer ${recievedData["token"]}");
          await preferences.setString("email", user["email"]);

//        print("jwt token ***************");
//        print(GlobalVariables.authorizationToken);
//        print("jwt token ***************");
          result = new ConventionResponse.success200();

          Map<String, dynamic> userData = {
            "firstName": recievedData["data"]["firstName"],
            "lastName": recievedData["data"]["lastName"],
            "email": recievedData["data"]["email"],
            "phoneNumber": recievedData["data"]["phoneNumber"],
            "gender": recievedData["data"]["gender"],
            "college": recievedData["data"]["college"],
            "university": recievedData["data"]["university"],
            "graduated": recievedData["data"]["graduated"],
            "isEmployed": recievedData["data"]["isEmployed"],
            "isTutor": recievedData["data"]["tutorProfile"]["isTutor"]
          };

          await preferences.setString("userData", json.encode(userData));
          break;
        }
      case 404:
        result = new ConventionResponse.invalidUsernameOrPassword();
        break;
      case 500:
        result = new ConventionResponse.internalServerError();
        break;

      default:
        result = new ConventionResponse.newBugToBeHandled();
    }

    return result;
  }

  ///* [*******************************************************]
  ///* [method that handle password forgotten]
  ///* [*******************************************************]

//  Future<ConventionResponse> handlePasswordForgotten(
//      {Map<String, String> user}) async {
//    Map recievedData;
//    http.Response response;
//    String forgetPasswordURL = _getUrl(path: "/api/v1/users/forget-password");
//
//    try {
//      response = await http
//          .post(Uri.encodeFull(forgetPasswordURL), headers: _header, body: user)
//          .timeout(Duration(seconds: 7));
//    } on TimeoutException {
//      return ConventionResponse.serverNotResponding();
//    } catch (err) {
//      return ConventionResponse.internalServerError();
//    }
//
//    ConventionResponse result;
//    recievedData = json.decode(response.body);
//
//    switch (recievedData['status']) {
//      case 200:
//        result = new ConventionResponse.success201();
//        break;
//      case 500:
//        result = new ConventionResponse.internalServerError();
//        break;
//
//      default:
//        print("Hello World");
//    }
//    return result;
//  }

  Future<ConventionResponse> savePostSignUpData(
      {Map<String, dynamic> data}) async {
    if (!isConnected) {
      return ConventionResponse.failedConnection();
    }

    http.Response response;
    String url = _getUrl(path: "/api/v1/users/complete-credentials");
    Duration timeoutDuration = new Duration(seconds: 7);
    Map<String, dynamic> recievedData = {};
    ConventionResponse result;
    try {
      response = await http
          .post(Uri.encodeFull(url),
              body: json.encode(data), headers: _signUpLoginHeader)
          .timeout(timeoutDuration);

      switch (response.statusCode) {
        case 200:
          {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.remove("init");
            await preferences.setString("init", "/verify-your-email");
            result = ConventionResponse.success200();
            break;
          }
        case 500:
          result = ConventionResponse.internalServerError();
          break;
        case 404:
          {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.remove("init");
            result = ConventionResponse.noSuchUsername();
            break;
          }
        default:
          result = ConventionResponse.newBugToBeHandled();
          break;
      }

      return result;
    } on TimeoutException {
      return ConventionResponse.serverNotResponding();
    } catch (err) {
      print(err);
      print("Here is a problem");
      return ConventionResponse.newBugToBeHandled();
    }
  }

  Future<ConventionResponse> askForAnotherValidationMail() async {
    if (!isConnected) return ConventionResponse.failedConnection();

    http.Response response;
    ConventionResponse result;
    String url = _getUrl(path: "/api/v1/users/get-another-validation-mail");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey("email")) {
      return ConventionResponse.noSuchUsername();
    }
    String _email = preferences.get("email");
    Map<String, String> _body = {"email": _email};

    try {
      response = await http.post(Uri.encodeFull(url),
          body: json.encode(_body),
          headers: {
            "content-type": "application/json"
          }).timeout(Duration(seconds: 7));
    } on TimeoutException {
      return ConventionResponse.serverNotResponding(); // 503
    } catch (err) {
      print(err.toString());
      return ConventionResponse.newBugToBeHandled(); // 111
    }

    switch (response.statusCode) {
      case 200:
        result = ConventionResponse.success200();
        break;

      case 500:
        result = ConventionResponse.internalServerError();
        break;

      case 404:
        result = ConventionResponse.noSuchUsername();
        break;

      default:
        result = ConventionResponse.unhandledStatusCode(
            statusCode: response.statusCode ?? 0);
    }
    return result;
  }

  Future<ConventionResponse> checkVerification() async {
    if (!isConnected) {
      return ConventionResponse.failedConnection();
    }

    http.Response response;
    ConventionResponse result;
    var receivedData;
    String url = _getUrl(path: "/api/v1/users/check-verification");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _email = preferences.get("email");
    Map<String, dynamic> _body = <String, dynamic>{"email": _email};

    try {
      response = await http
          .post(Uri.encodeFull(url),
              body: json.encode(_body), headers: _signUpLoginHeader)
          .timeout(Duration(seconds: 12));
      receivedData = json.decode(response.body);
      switch (response.statusCode) {
        case 200: // ok
          {
            await preferences.setString(
                "token", "bearer ${receivedData["token"]}");
            await preferences.remove("init");
            await preferences.remove("email");
            await preferences.setString('init', "/complete-credentials-page");
            result = ConventionResponse.success200();
            break;
          }

        case 500: // internal server error
          result = ConventionResponse.internalServerError();
          break;

        case 401: // unauthorized
          result = ConventionResponse.notAuthorized();
          break;

        case 404: // not found
          await preferences.remove('init');
          await preferences.remove('email');
          result = ConventionResponse.noSuchUsername();
          break;

        default: // new bug to be handled
          result = ConventionResponse.unhandledStatusCode(
              statusCode: response.statusCode);
      }
      return result;
    } on TimeoutException {
      return ConventionResponse
          .serverNotResponding(); // 503  service unavailable
    } catch (err) {
      return ConventionResponse.newBugToBeHandled()
        ..setPayload(payload: err.toString()); // 111  new bug to be handled
    }
  }

  Future<ConventionResponse> fetchUniversitiesList() async {
    if (!isConnected) {
      return ConventionResponse.failedConnection();
    }
    try {
      http.Response response = await http
          .get(_getUrl(path: '/api/v1/users/get-uni'), headers: {
        "Accept": "application/json"
      }).timeout(Duration(milliseconds: 12000));


      if (response.statusCode == 200)
        return ConventionResponse.success200()
          ..setPayload(payload: json.decode(response.body));
      else
        return ConventionResponse.internalServerError();
    } on TimeoutException {
      return ConventionResponse.serverNotResponding();
    } catch (err) {
      return ConventionResponse.newBugToBeHandled();
    }
  }

  Future<ConventionResponse> uploadNewCourse({Course course}) async {
    http.Response response;
    // get token
    String token = await AuthorizationManager.getToken();
    if (token == null) {
      return ConventionResponse(
        label: "no token",
      );
    }

    http.MultipartRequest request =
        new http.MultipartRequest("POST", Uri.parse("/api/v1/courses"));
    request.fields["title"] = course.title;
    request.fields["date"] = course.date.toIso8601String();
    request.fields["time"] = course.time.toString();
    request.fields["price"] = course.price;
    request.fields["typeOfPayment"] = course.typeOfPayment;
    request.fields["duration"] = course.duration;
    request.fields["addressDescription"] = course.addressDescription;
    request.fields["courseDescription"] = course.description;
    request.fields["phone"] = course.phone;
    request.fields["location"] = course.location.toString();

    if (course.images != null) {
      for (int i = 0; i < course.images.length; i++) {
        File imageFile = course.images[i];
        Stream<List<int>> stream = imageFile.openRead();
        int length = await imageFile.length();
        http.MultipartFile file =
            new http.MultipartFile("thumbnail", stream, length);
        request.files.add(file);
      }
    }

    int status = json.decode(response.body);
    switch (response.statusCode) {
      case HttpStatus.created:
        return ConventionResponse.success201();
        break;
      case HttpStatus.internalServerError:
        return ConventionResponse.internalServerError();
        break;

      default:
        return ConventionResponse.newBugToBeHandled();
    }
  }
}

class ConventionResponse {
  String _label;
  dynamic _payload;
  int _status;
  RegisteredUser data;

  String get label => this._label;

  dynamic get payload => this._payload;

  int get status => this._status;

  void setLabel(String label) {
    this._label = label;
  }

  void setPayload({payload}) {
    this._payload = payload;
  }

  void setStatus({status}) {
    this._status = status;
  }

  ConventionResponse({String label, String payload, int status}) {
    this._label = label;
    this._payload = payload;
    this._status = status;
  }

  factory ConventionResponse.failedConnection() {
    return ConventionResponse(
        label: "failed",
        payload:
            "No Internet Connection\ncheck your internet connection and try again",
        status: 902);
  }

  factory ConventionResponse.internalServerError() {
    return new ConventionResponse(
        label: "failed", payload: "Something Went Wrong", status: 500);
  }

  factory ConventionResponse.serverNotResponding() {
    return new ConventionResponse(
        label: "failed", payload: "Something went wrong,\nServer is not Responding, try again", status: 503);
  }

  factory ConventionResponse.success201() {
    return new ConventionResponse(
        label: "success", status: 201, payload: "Created");
  }

  factory ConventionResponse.success200() =>
      new ConventionResponse(status: 200, label: "success", payload: "OK");

  factory ConventionResponse.notValidEmail() => new ConventionResponse(
      status: 422, // unprocessable entity
      label: "failed",
      payload: "Unprocessable entity");

  factory ConventionResponse.usernameAlreadyExist() {
    return ConventionResponse(
        label: "failed",
        payload: "Email you entered is already registered",
        status: 208 //already reported
        );
  }

  factory ConventionResponse.invalidUsernameOrPassword() => ConventionResponse(
      status: 404, // not Found
      label: "failed",
      payload: "Invalid username and/or password");

  factory ConventionResponse.noSuchUsername() {
    return ConventionResponse(
        label: "failed",
        payload: "Invalid username ,please do signup again",
        status: 404);
  }

  factory ConventionResponse.newBugToBeHandled() => new ConventionResponse(
        status: 111,
        label: "failed",
        payload: "new bug inside flutter has been occured",
      );

  factory ConventionResponse.notAuthorized() => new ConventionResponse(
      status: 401,
      label: "Not Authorized",
      payload: "Make sure you've verified your email and try again");

  factory ConventionResponse.unhandledStatusCode({statusCode}) =>
      new ConventionResponse(
          status: 111,
          payload:
              "the server sent a response with a status code ($statusCode) that has not been handled inside your app");
}
