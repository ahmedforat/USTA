class Validators{

  static validateFirstAndLastNames({String name}){
    if(name.length == 0 || name == null){
      return "please this field is required";
    }

    if(name.length < 3){
      return "this field must be not shorter than 3 characters";
    }

    if(name.length > 14){
      return "this field must be not longer than 14 characters";
    }

    List<String> chars = [',','.','/','\\','*','(',')','%','!'];
    bool contains = false;
    for(int i = 0; i < chars.length;i++){
      if(name.contains(chars[i]))
        contains = true;
      break;
    }
    if(contains){
      return "this field must consist of letters numbers and _  only";
    }

    if(name is num){
      return "this field can not an explicit number";
    }

    return null;
  }

  static validateEmail({String email}) {
    if(email.isEmpty){
      return "Please email is required";
    }
    RegExp regExp = new RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$",caseSensitive: true);
    bool isEmail = regExp.hasMatch(email);
    if(!isEmail){
      return "please enter a valid email like example@something.com";
    }
    return null;
  }

  static validatePhoneNumber({phoneNumber}){

    if(phoneNumber.isEmpty){
      return "Please phone number is required";
    }

    String phone = phoneNumber.toString();

    if(phone.length > 11 || phone.length < 11 || !(_validatePhoneNumber(phone))){
        return "Please enter a valid phone number";
    }

    return null;


  }

  static _validatePhoneNumber(number){
    RegExp zainIq = new RegExp(r"079");
    RegExp zainAtheer = new RegExp(r"078");
    RegExp asia = new RegExp(r"077");
    RegExp korek = new RegExp(r"075");

    List<String> phoneNumber = number.toString().split('');

    for(int i = 0; i < phoneNumber.length; i++){

      try{
        int n = int.parse(phoneNumber[i]);
      }catch(err){
        return false;
      }

    }

    if(zainIq.hasMatch(number) || zainAtheer.hasMatch(number) || asia.hasMatch(number) || korek.hasMatch(number)){
      return true;
    }
    return false;

  }

  static validatePassword({password}){
    if(password.isEmpty){
      return "Please password is required";
    }
    if(password.length < 8){
      return "Password must be not shorter than 8 characters";
    }

    if(password.length > 30){
      return "Password should not be longer than 30 characters";
    }

    return null;
  }
}