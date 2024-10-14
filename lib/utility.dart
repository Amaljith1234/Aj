

import 'dart:convert';

import 'package:eassets/User/usermodel.dart';
import 'package:eassets/alert_page.dart';
import 'package:eassets/dio_client.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/urlscreen.dart';
import 'package:eassets/wholesaleUsermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Utility{
  static double logoHeight = 60;
  static double headingSize = 15;


  static UserModel? usermodel;

  static WholesaleUserModel? wholesale_user;


  static void errorAlert(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(msg),
    ));
  }
  static storeSharedPreferences(String key, String value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  static Future<String?> getSharedPreferences(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? val = storage.getString(key);
    return val;
  }
  static Future<UserModel?> getUserSharedPreferences() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? val = storage.getString("USER");
    UserModel user = UserModel.fromJson(jsonDecode(val!));
    return user;
  }
  static storeUserSharedPreferences(UserModel value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String user = jsonEncode(value.toJson()).toString();
    await storage.setString("USER", user);
  }
  static storeWholesaleUserSharedPreferences(WholesaleUserModel value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String data = jsonEncode(value.toJson()).toString();
    await storage.setString("WHOLESALE_USER", data);
  }

  static Future<bool> checkLogin(BuildContext context) async {
    try {
      Map<String, String> data = {};
      String body = json.encode(data);
      final response =
      await DioClient.post(UrlConstantscreen.CHECK_LOGIN_URL, body: body);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result['success'] == true) {
          var data = result['data'];

          Utility.usermodel = UserModel.fromJson(data['user']);
          await Utility.storeUserSharedPreferences(Utility.usermodel!);

          Utility.wholesale_user =
              WholesaleUserModel.fromJson(data['wholesaler_user']);
          await Utility.storeWholesaleUserSharedPreferences(
              Utility.wholesale_user!);
        } else {
          Utility.errorAlert(context, result['message']);
          return false;
        }
      } else if (response.statusCode == 401) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Utility.errorAlert(context, "Login  Error");
        return false;
      }

      return true;
    } catch (e) {
      debugPrint("Error " + e.toString());
      // Utility.errorAlert(context, );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AlertPage(
                message: "Network error, Check your connectivity",
              )));
      return false;
    }
  }
}