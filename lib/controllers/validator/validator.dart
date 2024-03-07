class Validator{
  // private constructor to avoid create class object
  Validator._();

  // check if string not empty and has value
  static bool hasValue(String string){
    if (string == null || string.isEmpty)
      return false;
    return true;
  }

  // Return true if email is valid. Otherwise, return false
  static bool isEmail(String email){
    RegExp exp = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(exp.hasMatch(email))
      return true;
    return false;
  }

  // Return true if phone number is valid. Otherwise, return false
  static bool isPhoneNumber(String phoneNumber){

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return false;
    }

    final pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (regExp.hasMatch(phoneNumber))
      return true;
    return false;

    RegExp exp = new RegExp(r"[0-9]{10}");
    if(exp.hasMatch(phoneNumber))
      return true;
    return false;
  }

  // Return true if password is valid. Otherwise, return false
  static bool isValidPassword(String password){
    if(password == null)
      return false;
    if(password.length <6)
      return false;
    return true;
  }

  // Return true if String is valid Numeric. Otherwise, return false
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static isYear(String s){
    if(Validator.isNumeric(s))
      return int.parse(s) <= (DateTime.now().year+1) && int.parse(s) > 1950 ? true :false;
    return false;
  }

}