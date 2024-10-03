import 'package:eassets/addEquipment.dart';
import 'package:eassets/viewequipment.dart';
import 'package:flutter/material.dart';

class EquipmentCard extends StatelessWidget {
  final String name;
  final String category;
  final String fromDate;
  final String identification;
  final Color cardColor;

  const EquipmentCard({
    required this.name,
    required this.category,
    required this.fromDate,
    required this.identification,
    this.cardColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  ViewEquipment()));
    },
      child: Container(
        width: double.infinity,
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Equipment Name",
                      style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                          ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Identification Number",
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ),
                      SizedBox(height: 4),
                      Text(
                        identification,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )

                ],
              ),


                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipment Category",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            category,
                            style: TextStyle(fontSize: 15, color: Colors.black87),
                          ),

                          Text(
                            "From Date",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              fromDate,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
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
                            color: Colors.redAccent,
                            textColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 25,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}