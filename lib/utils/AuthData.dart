class AuthData{
  String init; // hold the init page just in case the user did not complete the signUp process;
  String token; // hold the token for Authentication
  bool isNull;
AuthData({this.init,this.token,this.isNull});
@override
  String toString() {
    // TODO: implement toString
    return "token: ${this.token} \n init: ${this.init}";
  }
}