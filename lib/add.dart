//
// import 'package:eassets/Product_Department_List.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
//
//
// class AddDart extends StatefulWidget {
//   @override
//   State<AddDart> createState() => _AddDartState();
// }
//
// class _AddDartState extends State<AddDart> {
//   String? valueChoose;
//   List<String> listItem = [
//     '002 - Chair',
//     '007 - Computer',
//     '001 - Cabinets and Safes',
//     'PLASMA STERILIZER',
//     'ECG MACHINE'
//   ];
//   TextEditingController dateController = TextEditingController();
//   TextEditingController numberController = TextEditingController();
//   String? _selectedEquipmentType;
//   bool isChecked = false;
//   String? dropdownValue;
//   String result = '';
//
//   Widget defaultHeight= SizedBox(height: 2);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text(
//           "Add Equipment",
//           style: TextStyle(
//               fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.indigo,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//
//         ),
//       body: SafeArea(child:
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Container(color: Color(0xffbf4f6fa),
//             padding: EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Equipment Category",
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black.withOpacity(0.4),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 defaultHeight,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 35,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.black.withOpacity(0.3)),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         child: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 String searchQuery = "";
//                                 List<String> filteredList = listItem;
//
//                                 return StatefulBuilder(
//                                   builder: (BuildContext context, StateSetter setState) {
//                                     return Container(
//                                       padding: EdgeInsets.all(10),
//                                       height: MediaQuery.of(context).size.height * 0.5,
//                                       child: Column(
//                                         children: [
//                                           // Search field
//                                           TextField(
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 searchQuery = value;
//
//                                                 filteredList = listItem.where((item) {
//                                                   return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                 }).toList();
//                                               });
//                                             },
//                                             decoration: InputDecoration(
//                                               labelText: "Search",
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               prefixIcon: Icon(Icons.search),
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Expanded(
//                                             child: ListView.builder(
//                                               itemCount: filteredList.length,
//                                               itemBuilder: (BuildContext context, int index) {
//                                                 return ListTile(
//                                                   title: Text(filteredList[index]),
//                                                   onTap: () {
//                                                     setState(() {
//                                                       valueChoose = filteredList[index];
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 valueChoose ?? 'Pick Equipment Category',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down, size: 36),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 defaultHeight,
//                 Text(
//                   ' Equipment Name',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black.withOpacity(0.4),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black.withOpacity(0.3)),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: TextField(
//                     controller: numberController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                   ),
//                 ),
//
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 Text(
//                   "Barcode",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       height: 40,width: 250,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text("$result")
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25),
//                       child:
//                         IconButton(onPressed: () async {
//                           var res = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const SimpleBarcodeScannerPage(),
//                               ));
//                           setState(() {
//                             if (res is String) {
//                               result = res;
//                               // debugPrint("Scanned result: $result");
//                               // print(result);
//                             }
//                           }
//                           );
//
//                         }, icon: Icon(Icons.qr_code_scanner_outlined,color: Colors.black.withOpacity(0.3),size: 32,)),
//                       ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 defaultHeight,
//                 Text(
//                   "Product Department",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 35,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.black.withOpacity(0.3)),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         child: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 String searchQuery = "";
//                                 List<String> filteredList = listItem;
//
//                                 return StatefulBuilder(
//                                   builder: (BuildContext context, StateSetter setState) {
//                                     return Container(
//                                       padding: EdgeInsets.all(10),
//                                       height: MediaQuery.of(context).size.height * 0.5,
//                                       child: Column(
//                                         children: [
//                                           // Search field
//                                           TextField(
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 searchQuery = value;
//
//                                                 filteredList = listItem.where((item) {
//                                                   return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                 }).toList();
//                                               });
//                                             },
//                                             decoration: InputDecoration(
//                                               labelText: "Search",
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               prefixIcon: Icon(Icons.search),
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Expanded(
//                                             child: ListView.builder(
//                                               itemCount: filteredList.length,
//                                               itemBuilder: (BuildContext context, int index) {
//                                                 return ListTile(
//                                                   title: Text(filteredList[index]),
//                                                   onTap: () {
//                                                     setState(() {
//                                                       valueChoose = filteredList[index];
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 valueChoose ?? 'Pick Equipment Category',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down, size: 36),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 defaultHeight,
//                 Text(
//                   "Product Model",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 35,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.black.withOpacity(0.3)),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         child: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 String searchQuery = "";
//                                 List<String> filteredList = listItem;
//
//                                 return StatefulBuilder(
//                                   builder: (BuildContext context, StateSetter setState) {
//                                     return Container(
//                                       padding: EdgeInsets.all(10),
//                                       height: MediaQuery.of(context).size.height * 0.5,
//                                       child: Column(
//                                         children: [
//                                           // Search field
//                                           TextField(
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 searchQuery = value;
//
//                                                 filteredList = listItem.where((item) {
//                                                   return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                 }).toList();
//                                               });
//                                             },
//                                             decoration: InputDecoration(
//                                               labelText: "Search",
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               prefixIcon: Icon(Icons.search),
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Expanded(
//                                             child: ListView.builder(
//                                               itemCount: filteredList.length,
//                                               itemBuilder: (BuildContext context, int index) {
//                                                 return ListTile(
//                                                   title: Text(filteredList[index]),
//                                                   onTap: () {
//                                                     setState(() {
//                                                       valueChoose = filteredList[index];
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 valueChoose ?? 'Pick Equipment Category',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down, size: 36),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 defaultHeight,
//                 Text(
//                   "Purchase Date",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Equipment Type",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: "Individual",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Individual",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: "Bulk",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Bulk",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Text(
//                   "Purchase Amound",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 35,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.black.withOpacity(0.3)),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 12),
//                         child: GestureDetector(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 String searchQuery = "";
//                                 List<String> filteredList = listItem;
//
//                                 return StatefulBuilder(
//                                   builder: (BuildContext context, StateSetter setState) {
//                                     return Container(
//                                       padding: EdgeInsets.all(10),
//                                       height: MediaQuery.of(context).size.height * 0.5,
//                                       child: Column(
//                                         children: [
//                                           // Search field
//                                           TextField(
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 searchQuery = value;
//
//                                                 filteredList = listItem.where((item) {
//                                                   return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                 }).toList();
//                                               });
//                                             },
//                                             decoration: InputDecoration(
//                                               labelText: "Search",
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               prefixIcon: Icon(Icons.search),
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Expanded(
//                                             child: ListView.builder(
//                                               itemCount: filteredList.length,
//                                               itemBuilder: (BuildContext context, int index) {
//                                                 return ListTile(
//                                                   title: Text(filteredList[index]),
//                                                   onTap: () {
//                                                     setState(() {
//                                                       valueChoose = filteredList[index];
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 valueChoose ?? '',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               Icon(Icons.arrow_drop_down, size: 36),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "From Date",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: CheckboxListTile(
//                     title: Text(
//                       'Location Application',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     value: isChecked,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isChecked = value!;
//                       });
//                     },
//                     controlAffinity: ListTileControlAffinity.leading,
//
//                   ),
//                 ),
//
//                 Visibility(
//                   visible: isChecked,
//                   child: DropdownButton<String>(
//                     hint: Text(
//                       'Building Name',
//                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
//                     ),
//                     dropdownColor: Colors.grey,
//                     icon: Icon(Icons.arrow_drop_down),
//                     iconSize: 36,
//                     isExpanded: true,
//                     style: TextStyle(color: Colors.black, fontSize: 15),
//                     value: dropdownValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue = newValue;
//                       });
//                     },
//                     items: listItem.map((String valueItem) {
//                       return DropdownMenuItem<String>(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 defaultHeight,
//                 Visibility(
//                   visible: isChecked,
//                   child: DropdownButton<String>(
//                     hint: Text(
//                       'Floor Name',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     dropdownColor: Colors.grey,
//                     icon: Icon(Icons.arrow_drop_down),
//                     iconSize: 36,
//                     isExpanded: true,
//                     style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
//                     value: dropdownValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue = newValue;
//                       });
//                     },
//                     items: listItem.map((String valueItem) {
//                       return DropdownMenuItem<String>(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Visibility(
//                   visible: isChecked,
//                   child: DropdownButton<String>(
//                     hint: Text(
//                       'Location',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     dropdownColor: Colors.grey,
//                     icon: Icon(Icons.arrow_drop_down),
//                     iconSize: 36,
//                     isExpanded: true,
//                     style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
//                     value: dropdownValue,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue = newValue;
//                       });
//                     },
//                     items: listItem.map((String valueItem) {
//                       return DropdownMenuItem<String>(
//                         value: valueItem,
//                         child: Text(valueItem),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 Text(
//                   'Identification Number',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black.withOpacity(0.4),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black.withOpacity(0.3)),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: TextField(
//                     controller: numberController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 defaultHeight,
//                 Text(
//                   'Next Service Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w600),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 defaultHeight,
//                 Text(
//                   'Next Calibration Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w600),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 defaultHeight,
//                 Text(
//                   'Serial Number',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black.withOpacity(0.4),
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 40,
//                   child: TextField(
//                     controller: numberController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   'Make',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.4)
//                   ),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 40,
//                   child: TextField(
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Enter text',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     style: TextStyle(
//                       color: Colors.black.withOpacity(0.7),
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 defaultHeight,
//                 Text(
//                   'AMC Expiry Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w600),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 defaultHeight,
//                 Text(
//                   'AMC Value',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 40,
//                   child: TextField(
//                     controller: numberController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                   ),
//                 ),
//
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 Text(
//                   'Warranty Expiry Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 5),
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 Text(
//                   'AMC Renewal Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 Text(
//                   'Install Date',
//                   style:  TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Container(
//                   height: 35,
//                   child: TextFormField(
//                     controller: dateController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       hintText: 'Choose date',
//                       hintStyle: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                       ),
//                       suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                     ),
//                     readOnly: true,
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                         setState(() {
//                           dateController.text = formattedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//                 defaultHeight,
//                 Text(
//                   "Service Type",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: "Technician",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Technician",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: "Department",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Department",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 defaultHeight,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Text(
//                     "Product Department",
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black.withOpacity(0.4),
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 defaultHeight,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 35,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black.withOpacity(0.3)),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 12),
//                           child: GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 builder: (BuildContext context) {
//                                   String searchQuery = "";
//                                   List<String> filteredList = listItem;
//
//                                   return StatefulBuilder(
//                                     builder: (BuildContext context, StateSetter setState) {
//                                       return Container(
//                                         padding: EdgeInsets.all(10),
//                                         height: MediaQuery.of(context).size.height * 0.5, // Set height of the modal
//                                         child: Column(
//                                           children: [
//                                             // Search field
//                                             TextField(
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   searchQuery = value;
//
//                                                   filteredList = listItem.where((item) {
//                                                     return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                   }).toList();
//                                                 });
//                                               },
//                                               decoration: InputDecoration(
//                                                 labelText: "Search",
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                 ),
//                                                 prefixIcon: Icon(Icons.search),
//                                               ),
//                                             ),
//                                             SizedBox(height: 10),
//                                             // Display the filtered list
//                                             Expanded(
//                                               child: ListView.builder(
//                                                 itemCount: filteredList.length,
//                                                 itemBuilder: (BuildContext context, int index) {
//                                                   return ListTile(
//                                                     title: Text(filteredList[index]),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         valueChoose = filteredList[index];
//                                                       });
//                                                       Navigator.pop(context);
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   valueChoose ?? 'Pick Equipment Category',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Icon(Icons.arrow_drop_down, size: 36),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.grey,
//                   thickness: 1,
//                 ),
//
//                 Text(
//                   "Calibration Type",
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black.withOpacity(0.4),
//                       fontWeight: FontWeight.w500),
//                 ),
//                 defaultHeight,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: "Technician",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Technician",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Radio<String>(
//                             value: "Department",
//                             groupValue: _selectedEquipmentType,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 _selectedEquipmentType = value;
//                               });
//                             },
//                           ),
//                           Text("Department",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 defaultHeight,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Text(
//                     "Product Department",
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black.withOpacity(0.4),
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 defaultHeight,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 35,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black.withOpacity(0.3)),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           padding: EdgeInsets.symmetric(horizontal: 12),
//                           child: GestureDetector(
//                             onTap: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 isScrollControlled: true,
//                                 builder: (BuildContext context) {
//                                   String searchQuery = "";
//                                   List<String> filteredList = listItem;
//
//                                   return StatefulBuilder(
//                                     builder: (BuildContext context, StateSetter setState) {
//                                       return Container(
//                                         padding: EdgeInsets.all(10),
//                                         height: MediaQuery.of(context).size.height * 0.5,
//                                         child: Column(
//                                           children: [
//                                             // Search field
//                                             TextField(
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   searchQuery = value;
//
//                                                   filteredList = listItem.where((item) {
//                                                     return item.toLowerCase().contains(searchQuery.toLowerCase());
//                                                   }).toList();
//                                                 });
//                                               },
//                                               decoration: InputDecoration(
//                                                 labelText: "Search",
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                 ),
//                                                 prefixIcon: Icon(Icons.search),
//                                               ),
//                                             ),
//                                             SizedBox(height: 10),
//                                             Expanded(
//                                               child: ListView.builder(
//                                                 itemCount: filteredList.length,
//                                                 itemBuilder: (BuildContext context, int index) {
//                                                   return ListTile(
//                                                     title: Text(filteredList[index]),
//                                                     onTap: () {
//                                                       setState(() {
//                                                         valueChoose = filteredList[index];
//                                                       });
//                                                       Navigator.pop(context);
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   valueChoose ?? 'Pick Equipment Category',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 Icon(Icons.arrow_drop_down, size: 36),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//             ),
//       ),
//         ),
//     );
//   }
// }