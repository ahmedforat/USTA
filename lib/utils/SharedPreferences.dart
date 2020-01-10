import 'package:shared_preferences/shared_preferences.dart';

import 'AuthData.dart';

class AuthorizationManager{

  static SharedPreferences _preferences ;

  static Future<bool> saveToken({String token})async{
   _preferences = await SharedPreferences.getInstance();
  return await _preferences.setString("token", "bearer $token");
  }

  static Future<bool>specifyInit({String init})async{
    _preferences = await SharedPreferences.getInstance();
   return await _preferences.setString("init", init);
  }


  static Future<AuthData> getPreferences()async{
    AuthData authData = new AuthData();
    _preferences = await SharedPreferences.getInstance();
    if(_preferences.containsKey("token"))
        authData.token = _preferences.get("token");

    if(_preferences.containsKey("init"))
        authData.init = _preferences.get("init");

    if(authData.init == null && authData.token == null){
      authData.isNull = true;
    }else{
      authData.isNull = false;
    }
    return authData;
  }

  static Future<String> getToken() async {
    _preferences = await SharedPreferences.getInstance();

    if(_preferences.containsKey("token"))

      return _preferences.get("token");

   return null;

  }

  static Future<String> getInit() async{
    _preferences =await SharedPreferences.getInstance();

    if(_preferences.containsKey("init"))

      return _preferences.get("init");

    return null;
  }

}