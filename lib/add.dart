import 'dart:convert';
import 'package:eassets/urlscreen.dart';
import 'package:flutter/material.dart';
import 'package:eassets/dio_client.dart';
import 'package:intl/intl.dart';

class CreateAssetScreen extends StatefulWidget {
  @override
  _CreateAssetScreenState createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for all required fields
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

  // Function to create asset
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Asset")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Asset Type Field
              TextFormField(
                controller: assetTypeController,
                decoration: InputDecoration(labelText: 'Asset Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter asset type';
                  }
                  return null;
                },
              ),
              // Location Field
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              // Department Field
              TextFormField(
                controller: departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter department';
                  }
                  return null;
                },
              ),
              // Major Category Field
              TextFormField(
                controller: majorCategoryController,
                decoration: InputDecoration(labelText: 'Major Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter major category';
                  }
                  return null;
                },
              ),
              // Minor Category Field
              TextFormField(
                controller: minorCategoryController,
                decoration: InputDecoration(labelText: 'Minor Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter minor category';
                  }
                  return null;
                },
              ),
              // Supplier Field
              TextFormField(
                controller: supplierController,
                decoration: InputDecoration(labelText: 'Supplier'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter supplier';
                  }
                  return null;
                },
              ),
              // Account No Field
              TextFormField(
                controller: accountNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Account No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account number';
                  }
                  return null;
                },
              ),
              // Tag No Field
              TextFormField(
                controller: tagNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tag No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter tag number';
                  }
                  return null;
                },
              ),
              // Opening Cost Field
              TextFormField(
                controller: openingCostController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Opening Cost'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter opening cost';
                  }
                  return null;
                },
              ),
              // Closing Cost Field
              TextFormField(
                controller: closingCostController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Closing Cost'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter closing cost';
                  }
                  return null;
                },
              ),
              // Net Book Value Field
              TextFormField(
                controller: netBookValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Net Book Value'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter net book value';
                  }
                  return null;
                },
              ),
              // Application Name Field
              TextFormField(
                controller: applicationNameController,
                decoration: InputDecoration(labelText: 'Application Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter application name';
                  }
                  return null;
                },
              ),
              // PO No Field
              TextFormField(
                controller: poNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'PO No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PO number';
                  }
                  return null;
                },
              ),
              // Invoice No Field
              TextFormField(
                controller: invoiceNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Invoice No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter invoice number';
                  }
                  return null;
                },
              ),
              // Service Date Field
              TextFormField(
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
                  suffixIcon: Icon(Icons.calendar_today, color: Color(0xffb233765).withOpacity(0.60)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service date';
                  }
                  return null;
                },
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
                      serviceDateController.text = formattedDate;
                    });
                  }
                },
              ),
              // TextFormField(
              //   controller: serviceDateController,
              //   keyboardType: TextInputType.datetime,
              //   decoration: InputDecoration(labelText: 'Service Date'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter service date';
              //     }
              //     return null;
              //   },
              // ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _createAsset,
                child: Text("Create Asset"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


