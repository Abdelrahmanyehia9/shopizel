import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {


  static const String isLoggingIn = "is_logging_in" ;
  static const String isNotFirstTime = "is_first_time" ;


  /// set Values
static Future<void> setBool(String name  , bool value)async{
  SharedPreferences preferences =await SharedPreferences.getInstance() ;
  preferences.setBool(name, value) ;
}


 /// get values
static Future<bool>getBool(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance() ;
  bool? value =  preferences.getBool(name) ;
  return value??false  ;


}



}