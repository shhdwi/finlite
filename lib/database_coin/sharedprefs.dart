import 'dart:convert';

import 'package:finlite/models/coindata_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String emailIdKey = "EMAILKEY";
  static String portfolioKey = "PORTFOLIO";
  static String coinKey = "COINKEY";


   Future<bool> saveCoinInfo(Map<String, dynamic> coinValues) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setString(coinKey, jsonEncode(coinValues));
  }

   Future<bool> saveusermail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setString(emailIdKey, email);
  }

   Future<bool> saveportfolio(double portfolio) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setString(portfolioKey, portfolio.toString());
  }


  getUserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String emailValue = prefs.getString(emailIdKey)!;
    String portfolio = prefs.getString(portfolioKey)!;
    // String coinValue = prefs.getString(coinKey)!;
    // var map = json.decode(coinValue);


    Map<String, dynamic> userInfoMap = {
      "email": emailValue,
      "portfolio": portfolio,
      // "coin": map,
    };
    return userInfoMap;
  }
}