class Validation {


 static bool passwordValidation (String password){
      const String pattern = r'^(?=.*[A-Za-z]).{8,}$';
      final regExp = RegExp(pattern);
      return regExp.hasMatch(password);
  }


static bool emailValidation (String email){
   const String pattern  =  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
   final reqExp = RegExp(pattern) ;
   return reqExp.hasMatch(email) ;
}
static bool validationNotNull(String value){
if (value == ""){
  return true ;
}   else{
  return false ;
}
}





}

