import 'package:shared_preferences/shared_preferences.dart';

import '../consetennts/const.dart';

class CacheNetwork{
   static late SharedPreferences sharedPref;
  static cachInstialization()async{
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCashe({required String key , required String value})async{
    // token=value;
    return await sharedPref.setString(key, value);
  }

  static String getCacheData({required String key}){
    return sharedPref.getString(key)??"Null";
  }

  static Future<bool> deleteCacheData({required String key})async{
    return await sharedPref.remove(key);
  }
}