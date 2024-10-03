import 'package:flutter/material.dart';

void ServiceTypePDBottomSheet(BuildContext context, Function(String) onItemSelected) {
  final List<String> dataList = List.generate(17, (index) => 'data $index');
  String searchQuery = '';

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          List<String> filteredItems = dataList
              .where((item) =>
              item.toLowerCase().contains(searchQuery.toLowerCase()))
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
                        "Choose Department",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 6),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
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
                  child: ListView.separated(
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
                          onItemSelected(filteredItems[index]); // Pass selected item back
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
