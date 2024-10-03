import 'package:flutter/material.dart';

class EquipmentScreen extends StatefulWidget {
  @override
  State<EquipmentScreen> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {
  String? valueChoose;
  List<String> listItem = [
    '002 - Chair',
    '007 - Computer',
    '001 - Cabinets and Safes',
    'PLASMA STERILIZER',
    'ECG MACHINE'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Equipment Transfer",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ),
      body:
      Container(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7),
                Text(
                  "CHOOSE EQUIPMENT",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          hint: Text(
                            'Pick Equipment',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          dropdownColor: Colors.grey[300],
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          value: valueChoose,
                          onChanged: (String? newValue) {
                            setState(() {
                              valueChoose = newValue;
                            });
                          },
                          items: listItem.map((String valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),


                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    hint: Text(
                      'Pick Department',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    dropdownColor: Colors.grey[300],
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    value: valueChoose,
                    onChanged: (String? newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: listItem.map((String valueItem) {
                      return DropdownMenuItem<String>(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height:222,
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),

          child:
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("EQUIPMENT DETAILS",
          style: TextStyle(
              fontSize: 18,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500),
                ),

                Divider(
          color: Colors.grey,
          thickness: 1,
                ),
                Text(
          "Equipment Name",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
                ),
                Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text("ASSET CODE",textAlign: TextAlign.right,
            style: TextStyle(
              color:Colors.black.withOpacity(0.7),
            ),
          ),
                ),

                Row(
          children: [
            Spacer(),
            Text(
              "LOADING",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
                ),
                Row(
          children: [
            Spacer(),
            Text(
              "Not Available",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,fontWeight: FontWeight.bold
              ),
            ),
          ],
                ),

                Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Text("DEPARTMENT",
            style: TextStyle(
              color:Colors.black.withOpacity(0.7),
            ),
          ),
                )
              ],
          ),
          ),
                  ),

                ),
                Container(
                  height:313,
                  width: double.infinity,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child:
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("LOCATION DETAILS",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),

                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Text(
                            "Pick Building",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              'Choose Building',
                              style: TextStyle(color: Colors.black.withOpacity(0.4)),
                            ),
                            dropdownColor: Colors.grey,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            value: valueChoose,
                            onChanged: (String? newValue) {
                              setState(() {
                                valueChoose = newValue;
                              });
                            },
                            items: listItem.map((String valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                          Text(
                            "Pick Floor",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              'Choose Floor',
                              style: TextStyle(color: Colors.black.withOpacity(0.4)),
                            ),
                            dropdownColor: Colors.grey,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            value: valueChoose,
                            onChanged: (String? newValue) {
                              setState(() {
                                valueChoose = newValue;
                              });
                            },
                            items: listItem.map((String valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                          Text(
                            "Pick Location",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              'Choose Location',
                              style: TextStyle(color: Colors.black.withOpacity(0.4)),
                            ),
                            dropdownColor: Colors.grey,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            isExpanded: true,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            value: valueChoose,
                            onChanged: (String? newValue) {
                              setState(() {
                                valueChoose = newValue;
                              });
                            },
                            items: listItem.map((String valueItem) {
                              return DropdownMenuItem<String>(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60.0, // Customize bottom bar height
          padding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:Container(height: 45,width:120,
      child:
      FloatingActionButton(
        onPressed: () {
          // Save action
        },
        child: Text("save",),
        backgroundColor: Colors.green,
      ),
      )
    );
  }
}






