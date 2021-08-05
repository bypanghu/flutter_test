import 'package:shared_preferences/shared_preferences.dart';


class HiCache{

  // 保存数据
  Future setUserInfo(String key,String value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  // 获取数据
  Future getUserInfo(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(sp.get(key));
    return sp.get(key);
  }

  // 清除数据
  Future deleteUserInfo(String key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

}