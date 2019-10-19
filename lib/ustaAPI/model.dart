
class User{
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  String _password;
  String _gender;
  bool _isEmployed;
  String _dateOfRegistration;


  User({String firstName,String lastName,String email,String phoneNumber,String password,String gender,bool isEmployed = false,String dateOfRegistration}){
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
    this._phoneNumber = phoneNumber;
    this._password = password;
    this._gender = gender;
    this._isEmployed = isEmployed;
    this._dateOfRegistration = dateOfRegistration;
  }

  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get email => this._email;
  String get phoneNumber => this._phoneNumber;
  String get password => this._password;
  String get gender => this._gender;
  bool get isEmployed => this._isEmployed;
}

var shcema = {

};