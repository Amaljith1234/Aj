import 'dart:convert';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void EquipmentCategoryBottomSheet(BuildContext context, Function(String categoryName, String categoryId) onItemSelected) {
  //final String url = 'https://logicoman.hexalinks.in/api/major_categories';

  final List<String> dataList = [];
  String searchQuery = '';
  bool _isLoading = true; // Loading flag

  Map<String, String> categoryMap = {}; // key: name, value: id

  // Fetch categories function
  Future<void> fetchCategoriesWithToken(Function(void Function()) localSetState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(API_TOKEN);

    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request with the headers
      final response = await http.get(Uri.parse(UrlConstantscreen.BASE_URL + UrlConstantscreen.MAJOR_CATAGORY_URL), headers: headers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          localSetState(() {
            dataList.clear();
            categoryMap.clear();
            for (var item in jsonResponse['data']) {
              String categoryName = item['major_category_name'] as String;
              String categoryId = item['major_category_id'].toString();

              dataList.add(categoryName); // For displaying category names
              categoryMap[categoryName] = categoryId; // Storing category id by name
            }
            _isLoading = false; // Stop loading once data is fetched
          });
        } else {
          print('API returned an error: ${jsonResponse['message']}');
          _isLoading = false; // Stop loading even on error
        }
      } else {
        print('Failed to load categories. Status code: ${response.statusCode}');
        _isLoading = false; // Stop loading on failure
      }
    } catch (e) {
      print('Error: $e');
      _isLoading = false; // Stop loading on exception
    }
  }

  // Call the fetchCategoriesWithToken function only once when the modal is shown
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, localSetState) {
          // Call fetchCategories only once
          if (_isLoading) {
            fetchCategoriesWithToken(localSetState);
          }

          List<String> filteredItems = dataList
              .where((item) => item.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();

          return SizedBox(
            height: 600,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffbf4f7fc),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Select Major Category",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 6),
                  child: TextField(
                    onChanged: (value) {
                      localSetState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffbcbd4dd)),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.20),
                        size: 30,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator()) // Show loading spinner
                      : ListView.separated(
                    itemCount: filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(
                          Icons.arrow_right,
                          color: Color(0xffba989c9).withOpacity(0.35),
                        ),
                        title: Text(
                          filteredItems[index],
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          String selectedCategoryName = filteredItems[index];
                          String selectedCategoryId = categoryMap[selectedCategoryName]!;

                          onItemSelected(selectedCategoryName, selectedCategoryId); // Pass selected item back
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (context, int index) {
                      return Divider();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
