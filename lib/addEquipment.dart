import 'dart:convert';
import 'package:eassets/dio_client.dart';
import 'package:http/http.dart' as http;
import 'package:eassets/Bottom_Sheet_list/Department_List.dart';
import 'package:eassets/Bottom_Sheet_list/Major_category_List.dart';
import 'package:eassets/Bottom_Sheet_list/Minor_Category_List.dart';
import 'package:eassets/Bottom_Sheet_list/Asset_Type_List.dart';
import 'package:eassets/Bottom_Sheet_list/Location_List.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';


class AddDart extends StatefulWidget {
  @override
  State<AddDart> createState() => _AddDartState();
}

class _AddDartState extends State<AddDart> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController assetTypeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController majorCategoryController = TextEditingController();
  TextEditingController minorCategoryController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController tagNoController = TextEditingController();
  TextEditingController openingCostController = TextEditingController();
  TextEditingController closingCostController = TextEditingController();
  TextEditingController netBookValueController = TextEditingController();
  TextEditingController applicationNameController = TextEditingController();
  TextEditingController poNoController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();

  Future<void> _createAsset() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> assetData = {
        'asset_type': assetTypeController.text,
        'location': locationController.text,
        'department': departmentController.text,
        'major_category': majorCategoryController.text,
        'minor_category': minorCategoryController.text,
        'supplier': supplierController.text,
        'account_no': accountNoController.text,
        'tag_no': tagNoController.text,
        'opening_cost': openingCostController.text,
        'closing_cost': closingCostController.text,
        'net_book_value': netBookValueController.text,
        'application_name': applicationNameController.text,
        'po_no': poNoController.text,
        'invoice_no': invoiceNoController.text,
        'service_date': serviceDateController.text,
      };

      try {
        final response = await DioClient.post(UrlConstantscreen.CREATE_ASSET_URL, body: json.encode(assetData));
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Asset created successfully"),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to create asset: ${response.body}"),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  String? valueChoose;

  TextEditingController dateController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool isChecked = false;
  String? dropdownValue;
  String result = '';

  Widget defaultHeight= SizedBox(height: 2);

  String selectedItem = "Select Major Category";
  String selectedCategoryId = "";

  String selectedItem1 = "Select Minor Category";
  String selectedItem2 = "Select Asset Type";
  String selectedItem3 = "Choose Department";
  String selectedItem4 = "Choose Location";

  List<dynamic> relatedData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Add Equipment",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),

        ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(color: Color(0xffbf4f6fa),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Major Category",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),//Equipment Category
                defaultHeight,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          EquipmentCategoryBottomSheet(context, (categoryName, categoryId) {
                            setState(() {
                              selectedItem = categoryName;
                              selectedCategoryId = categoryId;

                              print('Selected Category Name: $selectedItem');
                              print("Selected Category ID: $selectedCategoryId");
                              fetchRelatedData(categoryId);
                              fetchAssetData(categoryId);
                              fetchAssetUrlData();
                            });
                          });
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedItem,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60),),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),//Equipment Category selection
                SizedBox(height: 5,),
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),

                // Text(
                //   "Barcode",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//barcode
                // Row(
                //   children: [
                //     Container(
                //       height: 40,width: 250,
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         border: Border.all(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       child: Text("$result")
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 25),
                //       child:
                //         IconButton(onPressed: () async {
                //           var res = await Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => const SimpleBarcodeScannerPage(),
                //               ));
                //           setState(() {
                //             if (res is String) {
                //               result = res;
                //               // debugPrint("Scanned result: $result");
                //               // print(result);
                //             }
                //           }
                //           );
                //
                //         }, icon: Icon(Icons.qr_code_scanner_outlined,color: Colors.black.withOpacity(0.3),size: 32,)),
                //       ),
                //   ],
                // ),//barcode field and barcode scanner
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  "Minor Category",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//product department
                defaultHeight,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          MinorCategoryBottomSheet(context, (item) {
                            setState(() {
                              selectedItem1 = item;
                            });
                          });
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedItem1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                // defaultHeight,
                // Text(
                //   "Purchase Date",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Purchase date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black ),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                // Divider(
                //   color: Colors.grey,
                //   endIndent: 0,
                // ),
                // SizedBox(height: 5),
                // Text(
                //   "Equipment Type",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Equipment type
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Row(
                //         children: [
                //           Radio<String>(
                //             value: "Individual",
                //             groupValue: _selectedEquipmentType,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentType = value;
                //               });
                //             },
                //           ),
                //           Text("Individual",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70))),
                //         ],
                //       ),
                //     ),
                //
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Radio<String>(
                //             value: "Bulk",
                //             groupValue: _selectedEquipmentType,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentType = value;
                //               });
                //             },
                //           ),
                //           Text("Bulk",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70))),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // if(_selectedEquipmentType == 'Bulk')
                //   Text(
                //     'Enter Quantity',
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // if(_selectedEquipmentType == 'Bulk')
                // Container(
                //   height: 40,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border.all(color: Colors.black.withOpacity(0.3)),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: TextField(
                //     controller: numberController,
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //   ),
                // ),//check box's
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                // Text(
                //   "Locations",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//purchase amount
                // defaultHeight,
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 35,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           border: Border.all(color: Colors.black.withOpacity(0.3)),
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         padding: EdgeInsets.symmetric(horizontal: 12),
                //         child: GestureDetector(
                //           onTap: () {
                //             showModalBottomSheet(
                //               context: context,
                //               isScrollControlled: true,
                //               builder: (BuildContext context) {
                //                 String searchQuery = "";
                //                 List<String> filteredList = listItem;
                //
                //                 return StatefulBuilder(
                //                   builder: (BuildContext context, StateSetter setState) {
                //                     return Container(
                //                       padding: EdgeInsets.all(10),
                //                       height: MediaQuery.of(context).size.height * 0.5,
                //                       child: Column(
                //                         children: [
                //                           // Search field
                //                           TextField(
                //                             onChanged: (value) {
                //                               setState(() {
                //                                 searchQuery = value;
                //
                //                                 filteredList = listItem.where((item) {
                //                                   return item.toLowerCase().contains(searchQuery.toLowerCase());
                //                                 }).toList();
                //                               });
                //                             },
                //                             decoration: InputDecoration(
                //                               labelText: "Search",
                //                               border: OutlineInputBorder(
                //                                 borderRadius: BorderRadius.circular(10),
                //                               ),
                //                               prefixIcon: Icon(Icons.search),
                //                             ),
                //                           ),
                //                           SizedBox(height: 10),
                //                           Expanded(
                //                             child: ListView.builder(
                //                               itemCount: filteredList.length,
                //                               itemBuilder: (BuildContext context, int index) {
                //                                 return ListTile(
                //                                   title: Text(filteredList[index]),
                //                                   onTap: () {
                //                                     setState(() {
                //                                       valueChoose = filteredList[index];
                //                                     });
                //                                     Navigator.pop(context);
                //                                   },
                //                                 );
                //                               },
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     );
                //                   },
                //                 );
                //               },
                //             );
                //           },
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 valueChoose ?? '',
                //                 style: TextStyle(
                //                   color: Colors.black,
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //               Icon(Icons.arrow_drop_down, size: 36, color: Color(0xffb233765).withOpacity(0.60),),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  "Asset Type",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),
                defaultHeight,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          AssetTypeBottomSheet(context, (item) {
                            setState(() {
                              selectedItem2 = item;
                            });
                          });
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  "Department",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),
                defaultHeight,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          DepartmentBottomSheet(context, (item) {
                            setState(() {
                              selectedItem3 = item;
                            });
                          });
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem3,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),
                defaultHeight,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          LocationBottomSheet(context, (item) {
                            setState(() {
                              selectedItem4 = item;
                            });
                          });
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedItem4,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Supplier',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),//Equipment Name
                defaultHeight,
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: supplierController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                // SizedBox(height: 5),
                // Text(
                //   "From Date",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//from date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black ),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                // SizedBox(height: 5),
                // Padding(
                //   padding: const EdgeInsets.only(right: 12),
                //   child: CheckboxListTile(
                //     title: Text(
                //       'Location Application',
                //       style: TextStyle(
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     value: isChecked,
                //     onChanged: (bool? value) {
                //       setState(() {
                //         isChecked = value!;
                //       });
                //     },
                //     controlAffinity: ListTileControlAffinity.leading,
                //
                //   ),
                // ),//Location Applicable
                // Visibility(
                //   visible: isChecked,
                //   child: DropdownButton<String>(
                //     hint: Text(
                //       'Building Name',
                //       style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                //     ),
                //     dropdownColor: Colors.grey,
                //     icon: Icon(Icons.arrow_drop_down),
                //     iconSize: 36,
                //     isExpanded: true,
                //     style: TextStyle(color: Colors.black, fontSize: 15),
                //     value: dropdownValue,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         dropdownValue = newValue;
                //       });
                //     },
                //     items: listItem.map((String valueItem) {
                //       return DropdownMenuItem<String>(
                //         value: valueItem,
                //         child: Text(valueItem),
                //       );
                //     }).toList(),
                //   ),
                // ),//if checked Building Name
                // defaultHeight,
                // Visibility(
                //   visible: isChecked,
                //   child: DropdownButton<String>(
                //     hint: Text(
                //       'Floor Name',
                //       style: TextStyle(color: Colors.black),
                //     ),
                //     dropdownColor: Colors.grey,
                //     icon: Icon(Icons.arrow_drop_down),
                //     iconSize: 36,
                //     isExpanded: true,
                //     style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w600),
                //     value: dropdownValue,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         dropdownValue = newValue;
                //       });
                //     },
                //     items: listItem.map((String valueItem) {
                //       return DropdownMenuItem<String>(
                //         value: valueItem,
                //         child: Text(valueItem),
                //       );
                //     }).toList(),
                //   ),
                // ),//if checked Floor Name
                // SizedBox(height: 5),
                // Visibility(
                //   visible: isChecked,
                //   child: DropdownButton<String>(
                //     hint: Text(
                //       'Location',
                //       style: TextStyle(color: Colors.black),
                //     ),
                //     dropdownColor: Colors.grey,
                //     icon: Icon(Icons.arrow_drop_down),
                //     iconSize: 36,
                //     isExpanded: true,
                //     style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w600),
                //     value: dropdownValue,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         dropdownValue = newValue;
                //       });
                //     },
                //     items: listItem.map((String valueItem) {
                //       return DropdownMenuItem<String>(
                //         value: valueItem,
                //         child: Text(valueItem),
                //       );
                //     }).toList(),
                //   ),
                // ),//location
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Account Number',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),//Identification number
                SizedBox(height: 5),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: accountNoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                // defaultHeight,
                // Text(
                //   'Next Service Date',
                //   style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Next Service Date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       hintText: 'choose date',
                //       hintStyle: TextStyle(
                //         color: Color(0xffb233765),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field

                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),

                // defaultHeight,
                // Text(
                //   'Next Calibration Date',
                //   style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Next Calibration Date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       hintText: 'choose date',
                //       hintStyle: TextStyle(
                //         color: Color(0xffb233765),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Tag Number',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),//serial Number
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: tagNoController ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(height: 2),
                Text(
                  'Opening Cost',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.4)
                  ),
                ),//make
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: openingCostController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ),//make field
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                // defaultHeight,
                // Text(
                //   'Closing Cost',
                //   style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//AMC expiry date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black ),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       hintText: 'choose date',
                //       hintStyle: TextStyle(
                //         color: Color(0xffb233765),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                //
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                defaultHeight,
                Text(
                  'Closing Cost',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//AMC value
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: closingCostController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Net Book value',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//AMC value
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: netBookValueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Application Name',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//AMC value
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: applicationNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'PO Number',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//AMC value
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: poNoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                defaultHeight,
                Text(
                  'Invoice Number',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//AMC value
                defaultHeight,
                Container(
                  height: 40,
                  child: TextField(
                    controller: invoiceNoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                  ),
                ),

                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                //
                // Text(
                //   'Warranty Expiry Date',
                //   style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Warranty Expiry Date
                // SizedBox(height: 5),
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       hintText: 'choose date',
                //       hintStyle: TextStyle(
                //         color: Color(0xffb233765),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                //
                // Text(
                //   'AMC Renewal Date',
                //   style:  TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//AMC Renewal Date
                // defaultHeight,
                // Container(
                //   height: 35,
                //   child: TextFormField(
                //     controller: dateController,
                //     decoration: InputDecoration(
                //       fillColor: Colors.white,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black),
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       hintText: 'choose date',
                //       hintStyle: TextStyle(
                //         color: Color(0xffb233765),
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600
                //       ),
                //       suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //     ),
                //     readOnly: true,
                //     onTap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(2000),
                //         lastDate: DateTime(2100),
                //       );
                //       if (pickedDate != null) {
                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                //         setState(() {
                //           dateController.text = formattedDate;
                //         });
                //       }
                //     },
                //   ),
                // ),//date field
                defaultHeight,
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Text(
                  'Service Date',
                  style:  TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w600),
                ),//Install Date
                defaultHeight,
                Container(
                  height: 35,
                  child: TextFormField(
                    controller: serviceDateController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Choose Date',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600
                      ),
                      suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                // defaultHeight,
                // Text(
                //   "Service Type",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Service Type
                // defaultHeight,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Row(
                //         children: [
                //           Radio<String>(
                //             value: "Technician",
                //             groupValue: _selectedEquipmentTypeServiece,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentTypeServiece = value;
                //               });
                //             },
                //           ),
                //           Text("Technician",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70))),
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Radio<String>(
                //             value: "Department",
                //             groupValue: _selectedEquipmentTypeServiece,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentTypeServiece = value;
                //               });
                //             },
                //           ),
                //           Text("Department",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70)),),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),//check box's
                // defaultHeight,
                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Text(
                //     "Product Department",
                //     style: TextStyle(
                //         fontSize: 12,
                //         color: Colors.black.withOpacity(0.4),
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),//Product Department
                // defaultHeight,
                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () {
                //             ServiceTypePDBottomSheet(context, (item) {
                //               setState(() {
                //                 selectedItem3 = item;
                //               });
                //             });
                //           },
                //           child: Container(
                //             height: 35,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               border: Border.all(color: Colors.black.withOpacity(0.3)),
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //             padding: EdgeInsets.symmetric(horizontal: 12),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   if(_selectedEquipmentTypeServiece == 'Technician')
                //                   Text(
                //                     selectedItem4,
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                   if(_selectedEquipmentTypeServiece == 'Department')
                //                   Text(
                //                     selectedItem3,
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                   Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                //                 ],
                //               ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),//choose department
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
                // Text(
                //   "Calibration Type",
                //   style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black.withOpacity(0.4),
                //       fontWeight: FontWeight.w600),
                // ),//Calibration Type
                // defaultHeight,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: Row(
                //         children: [
                //           Radio<String>(
                //             value: "Technician",
                //             groupValue: _selectedEquipmentTypeCalibration,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentTypeCalibration = value;
                //               });
                //             },
                //           ),
                //           Text("Technician",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70))),
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Radio<String>(
                //             value: "Department",
                //             groupValue: _selectedEquipmentTypeCalibration,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedEquipmentTypeCalibration = value;
                //               });
                //             },
                //           ),
                //           Text("Department",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.70))),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),//check box's
                // defaultHeight,
                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Text(
                //     "Product Department",
                //     style: TextStyle(
                //         fontSize: 12,
                //         color: Colors.black.withOpacity(0.4),
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),//Product Department
                // defaultHeight,
                // Padding(
                //   padding: const EdgeInsets.only(left: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: GestureDetector(
                //           onTap: () {
                //             CalibrationTypePDBottomSheet(context, (item) {
                //               setState(() {
                //                 selectedItem4 = item;
                //               });
                //             });
                //           },
                //           child: Container(
                //             height: 35,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               border: Border.all(color: Colors.black.withOpacity(0.3)),
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //             padding: EdgeInsets.symmetric(horizontal: 12),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   if(_selectedEquipmentTypeCalibration == 'Technician')
                //                   Text(
                //                     selectedItem4,
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                   if(_selectedEquipmentTypeCalibration == 'Department')
                //                   Text(
                //                     selectedItem3,
                //                     style: TextStyle(
                //                       color: Colors.black,
                //                       fontSize: 13,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                   Icon(Icons.arrow_drop_down, size: 36,color: Color(0xffb233765).withOpacity(0.60)),
                //                 ],
                //               ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),//Product Department Input Field
                // Divider(
                //   color: Colors.grey,
                //   thickness: 1,
                // ),
              ],
            ),
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

      Map<String, dynamic>? data = {
        'major_category_id' :  categoryId
      };

    String getData = Uri(queryParameters: data).query;

    debugPrint(getData.toString());

      // Define the API URL
      final String url = '${UrlConstantscreen.BASE_URL + UrlConstantscreen.MINOR_CATAGORY_URL}' + '?' +  getData;
debugPrint(url);
      // Set headers including the token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request
      final response = await http.get(Uri.parse(url), headers: headers, );
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

  Future<void> fetchAssetUrlData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(API_TOKEN);

    try {

      // Map<String, dynamic>? data = {
      //   'major_category_id' :  categoryId
      // };

      //String getData =   Uri(queryParameters: data).query;

      //debugPrint(getData.toString());

      // Define the API URL
      final String url = '${UrlConstantscreen.BASE_URL + UrlConstantscreen.ASSET_TYPES_URL}';
      debugPrint(url);
      // Set headers including the token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request
      final response = await http.get(Uri.parse(url), headers: headers, );
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

  Future<void> fetchAssetData(String categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(API_TOKEN);

    try {

      Map<String, dynamic>? data = {
        'major_category_id' :  categoryId
      };

      String getData =   Uri(queryParameters: data).query;

      debugPrint(getData.toString());

      // Define the API URL
      final String url = '${UrlConstantscreen.BASE_URL + UrlConstantscreen.ASSET_DATA_URL}';
      debugPrint(url);
      // Set headers including the token
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Make the GET request
      final response = await http.get(Uri.parse(url), headers: headers, );
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