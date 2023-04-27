

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

  static const String keyemail = 'email';
  static const String keypassword = 'password';



  Future<void> setEmail(String email)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
  preferences.setString(keyemail, email);
  }

  Future<String> getEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email =  await preferences.getString(keyemail);
    return email ?? '';
  }

  Future<void> setPassword(String password)async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    preferences.setString(keypassword, password);
  }

  Future<String> getPassword()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var password =  await preferences.getString(keypassword);
    return password ?? '';
  }

}