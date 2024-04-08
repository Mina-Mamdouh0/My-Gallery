


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices{
  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences= await SharedPreferences.getInstance();
  }
  static Future<bool> setDate({
    required String key,
    required dynamic value,
  })async{
    if(value is bool)return await sharedPreferences!.setBool(key, value);
    if(value is int)return await sharedPreferences!.setInt(key, value);
    if(value is String)return await sharedPreferences!.setString(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }
  static Future<bool> setListDate({
    required String key,
    required List<String> value,
  })async{
    return await sharedPreferences!.setStringList(key, value);
  }

  static dynamic getDate({required String key}){
    return sharedPreferences!.get(key);
  }
  static Future<bool> removeDate({required String key})async{
    return await sharedPreferences!.remove(key);
  }

}
