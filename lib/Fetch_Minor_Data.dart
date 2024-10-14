import 'dart:convert';

import 'package:eassets/Bottom_Sheet_list/Major_category_List.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddDart extends StatefulWidget {
  @override
  State<AddDart> createState() => _AddDartState();
}

class _AddDartState extends State<AddDart> {
  String selectedItem = "Pick Equipment Category";
  String selectedCategoryId = "";
  List<dynamic> relatedData = []; // To store related data fetched from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Equipment"),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Equipment Category"),
                GestureDetector(
                  onTap: () {
                    EquipmentCategoryBottomSheet(context, (categoryName, categoryId) {
                      setState(() {
                        selectedItem = categoryName;
                        selectedCategoryId = categoryId;
                      });

                      // Fetch related data based on selected categoryId
                      fetchRelatedData(categoryId);
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        selectedItem,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),

                // Display the related data here
                if (relatedData.isNotEmpty)
                  Column(
                    children: relatedData.map((item) {
                      return Text(item['name']); // Replace with your data model
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchRelatedData(String categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(API_TOKEN);

    try {
      // Define the API URL
      final String url = '${UrlConstantscreen.BASE_URL}${UrlConstantscreen.MINOR_CATAGORY_URL}/$categoryId';

      // Set headers including the token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request
      final response = await http.get(Uri.parse(url), headers: headers);
      print("Response : ${response.statusCode}");
      print("Response Body : ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          setState(() {
            relatedData = jsonResponse['data'];
          });
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
