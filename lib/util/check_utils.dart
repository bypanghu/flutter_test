class CheckUtils {

  static bool checkPhone (String input) {
     if (input == null || input.isEmpty){
       return false;
     }
     return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(input);
  }


}