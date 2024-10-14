import 'dart:convert';
import 'dart:developer';
import 'package:eassets/User/user_wholesaler_model.dart';
import 'package:eassets/dio_client.dart';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool is_loading = true;

  List<UserWholesaler> listOfUser = [];
  List<UserWholesaler> listOfSearchUser = [];

  Future<void> getUserList(String status) async {
    listOfUser.clear();
    is_loading = true;
    try {
      Map<String, String> data = {
        'status': status,
      };
      String body = json.encode(data);
      final response = await DioClient.post(
          UrlConstantscreen.USER_LIST_with_status_URL,
          body: body);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var data = result['data'];
        listOfUser = data.map<UserWholesaler>((json) {
          return UserWholesaler.fromJson(json);
        }).toList();
        listOfSearchUser.clear();
        listOfSearchUser.addAll(listOfUser);
      }
    } catch (e) {
      log("ERROR  " + e.toString());
    }
    is_loading = false;
    notifyListeners();
  }

  search(String searchText) {
    listOfSearchUser.clear();
    if (searchText.isEmpty) {
      listOfSearchUser.addAll(listOfUser);
    } else {
      listOfUser.forEach((item) {
        if (item.name!.toLowerCase().contains(searchText.toLowerCase())) {
          listOfSearchUser.add(item);
        }else if (item.contactNo!.toLowerCase().contains(searchText.toLowerCase())) {
          listOfSearchUser.add(item);
        }
      });
    }
    notifyListeners();
  }
}
