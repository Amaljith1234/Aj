import 'package:eassets/Edit_Equipment.dart';
import 'package:eassets/add.dart';
import 'package:eassets/addEquipment.dart';
import 'package:eassets/complaint.dart';
import 'package:eassets/listscreen2.dart';
import 'package:eassets/viewpage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class ViewEquipment extends StatefulWidget {
  @override
  State<ViewEquipment > createState() => _ViewEquipmentState();
}
class _ViewEquipmentState extends State<ViewEquipment > {
  Widget defaultHeight= SizedBox(height: 2);
  Widget Heightdefault= SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "View Equipment Details",
          style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w900),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar_outlined, color: Colors.white),
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditEquipment()));},
          ),
          IconButton(
            onPressed: () {
              {}
            },
            icon: Icon(Icons.delete, color: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.topLeft,
                        child: Text(
                          " Equipment Details",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Align(alignment: Alignment.topLeft,
                            child: Text(
                              "ASSET / EQUIPMENT NAME",
                              style: TextStyle(fontSize: 12,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                     defaultHeight,
                          Align(alignment: Alignment.topLeft,
                            child: Text(
                              "036384 DELL",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Heightdefault,
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ASSET CODE",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  defaultHeight,
                                  Text(
                                    "/0001",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                Text(
                                  "EQUIPMENT CATEGORY",
                                  style: TextStyle(fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                ),
                                defaultHeight,
                                Text(
                                  "007 - Computers",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PURCHASE DATE",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  defaultHeight,
                                  Text(
                                    "08-09-2024",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "PURCHASE AMOUNT",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  defaultHeight,
                                  Text(
                                    "₹0",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Align(alignment: Alignment.topLeft,
                                child: Text(
                                  "LOCATION",
                                  style: TextStyle(fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              defaultHeight,
                              Align(alignment: Alignment.topLeft,
                                child: Text(
                                  "Not Available",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Heightdefault,
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "NEXT SERVICE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "NEXT CALIBRATION",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AMC EXPIRY DATE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "AMC DATA EXPIRED",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "AMC RENEWAL DATE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => AddDart()));
                                        },
                                        child: Text(
                                          "Renewal",
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
                                        ),
                                        color: Colors.indigo,
                                        textColor: Colors.black,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AMC VALUE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "Not Available",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "INSTALL DATE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "WARRENTY EXPIRY DATE",
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      defaultHeight,
                                      Text(
                                        "N08-09-2024",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "COMPLAINTS",
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                        ],
                      )
                    ],
                  ),
                ]
                  ),
              ),
                      ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.white,
                  border:
                  Border.all(color: Colors.black.withOpacity(0.1)
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),),
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SERVICE DETAILS", style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                fontSize:15),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ]
                      ),
                    ),

                    Expanded(
                      child: Align(alignment:Alignment.topRight ,
                        child: IconButton(onPressed:() {

                        },
                          icon:Icon(Icons.arrow_circle_down),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.white,
                    border:
                    Border.all(color: Colors.black.withOpacity(0.1)
                    ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),),
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SERVICE DETAILS", style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                                fontSize:15),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ]
                      ),
                    ),

                    Expanded(
                      child: Align(alignment:Alignment.topRight ,
                        child: IconButton(onPressed:() {

                        },
                          icon:Icon(Icons.arrow_circle_down),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
