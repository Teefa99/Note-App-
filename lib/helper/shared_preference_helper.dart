import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../manager/app_constants.dart';

class SharedPreferenceHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is double) {
      return sharedPreferences!.setDouble(key, value);
    }
    if (value is int) {
      return sharedPreferences!.setInt(key, value);
    }
    if (value is String) {
      return sharedPreferences!.setString(key, value);
    } else {
      return sharedPreferences!.setBool(key, value);
    }
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return sharedPreferences!.remove(key);
  }

  static Future<bool> clearCache() async {
    return sharedPreferences!.clear();
  }

  // static UserModel? loadUserData() {
  //   UserModel? doctorModel;
  //   var jsonEncode = getData(key: AppConstants.userData);
  //   if (jsonEncode != null) {
  //     Map<String, dynamic> map = json.decode(jsonEncode);
  //     doctorModel = UserModel.fromJson(map);
  //   }
  //   return doctorModel;
  // }
}
