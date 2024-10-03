
import 'package:eassets/addEquipment.dart';
import 'package:eassets/complaint.dart';
import 'package:eassets/listscreen2.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredEquipmentList = [];


  final List<Map<String, String>> equipmentList = [
    {
      "name": "036384 DELL",
      "category": "007-Computers",
      "date": "2024-09-08",
      "id": "036384",

    },
    {
      "name": "042591 HP",
      "category": "010-Laptops",
      "date": "2024-07-12",
      "id": "042591",

    },
    {
      "name": "052468 Lenovo",
      "category": "012-Desktops",
      "date": "2024-08-15",
      "id": "052468",

    },
    {
      "name": "0234067 Acer",
      "category": "012-Desktops",
      "date": "2024-08-15",
      "id": "052468",

    },
    {
      "name": "090876 Mac",
      "category": "012-Desktops",
      "date": "2024-08-15",
      "id": "052468",

    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredEquipmentList = List.from(equipmentList);
  }

  void _filterEquipmentList(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredEquipmentList = equipmentList
            .where((equipment) =>
            equipment['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredEquipmentList = List.from(equipmentList);
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
            _filterEquipmentList(value);
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
                _filteredEquipmentList = List.from(equipmentList);
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          ),
          IconButton(onPressed: () {
            {}
          }, icon:Icon(Icons.filter_alt_outlined,color: Colors.white,) )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 38,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Equipments",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${_filteredEquipmentList.length}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: _filteredEquipmentList.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> equipment = entry.value;

                  return EquipmentCard(
                    name: equipment['name']!,
                    category: equipment['category']!,
                    fromDate: equipment['date']!,
                    identification: equipment['id']!,
                    cardColor: (index == 1 || index ==3)? Colors.white : Colors.white70,
                  );
                }).toList(),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddDart()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.indigo,

      ),
    );
  }
}
