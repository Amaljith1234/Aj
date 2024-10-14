import 'dart:convert';
import 'package:eassets/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:eassets/addEquipment.dart';
import 'package:eassets/dio_client.dart';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<Asset> _filteredEquipmentList = [];
  List<Asset> _assets = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAssets();
  }

  // Function to fetch asset data from the API
  Future<void> fetchAssets() async {
    setState(() {
      _isLoading = true; // Show loading spinner
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(API_TOKEN);

    if (token == null || token.isEmpty) {
      setState(() {
        _errorMessage = 'Token not found. Please log in again.';
      });
      print('Token not found or is empty');
      return;
    }

    print('Token: $token');

    try {
      // Define the API URL
      final String url = '${UrlConstantscreen.BASE_URL + UrlConstantscreen.ASSET_DATA_URL}';
      print('API URL: $url');

      // Set headers including the token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request
      final response = await http.get(Uri.parse(url), headers: headers);

      print("Response Status Code: ${response.statusCode}"); // Print the status code
      print("Response Body: ${response.body}"); // Print the response body
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          setState(() {
            _assets = (jsonResponse['data'] as List)
                .map((asset) => Asset.fromJson(asset))
                .toList();
            _filteredEquipmentList = _assets;
          });
        } else {
          setState(() {
            _errorMessage = 'Failed to load assets: ${jsonResponse['message']}';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode} - ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching assets: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Hide loading spinner
      });
    }
  }

  // Function to filter assets based on the search input
  void _filterAssets(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredEquipmentList = _assets;
      });
    } else {
      setState(() {
        _filteredEquipmentList = _assets.where((asset) {
          return asset.tagNo.toLowerCase().contains(query.toLowerCase()) ||
              asset.assetId.toString().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search Equipment...",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
          onChanged: (value) {
            _filterAssets(value);
          },
        )
            : Text(
          "Equipments List",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          _isSearching
              ? IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _isSearching = false;
                _searchController.clear();
                _filterAssets(''); // Reset filter
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
          IconButton(
              onPressed: () {
                // Add your filter logic here
              },
              icon: Icon(Icons.filter_alt_outlined, color: Colors.white))
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Loading spinner
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage)) // Show error message
          : _filteredEquipmentList.isEmpty
          ? Center(child: Text('No assets found.'))
          : ListView.builder(
        itemCount: _filteredEquipmentList.length,
        itemBuilder: (context, index) {
          final asset = _filteredEquipmentList[index];
          return ListTile(
            title: Text('Asset ID: ${asset.assetId}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tag No: ${asset.tagNo}'),
                Text('Service Date: ${asset.serviceDate}'),
                Text('Opening Cost: ${asset.openingCost.toStringAsFixed(2)}'),
                Text('Closing Cost: ${asset.closingCost.toStringAsFixed(2)}'),
              ],
            ),
            isThreeLine: true,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDart())); // Replace with your add page
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}

class Asset {
  final int assetId;
  final String tagNo;
  final String serviceDate;
  final double openingCost;
  final double closingCost;

  Asset({
    required this.assetId,
    required this.tagNo,
    required this.serviceDate,
    required this.openingCost,
    required this.closingCost,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      assetId: json['asset_id'],
      tagNo: json['tag_no'],
      serviceDate: json['service_date'],
      openingCost: json['opening_cost'].toDouble(),
      closingCost: json['closing_cost'].toDouble(),
    );
  }
}
