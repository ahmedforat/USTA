class UstaFunctions{
  static int parseIntFrom(double num) {
    String numStr = num.toString();
    String number = '';
    for (int i = 0; i < numStr.length; i++) {
      if (numStr[i] == '.')
        break;
      else
        number += numStr[i];
    }
    if (number.length == 0)
      return null;
    else
      return int.parse(number);
  }
}