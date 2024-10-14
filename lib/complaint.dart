import 'package:eassets/User/user_page.dart';
import 'package:eassets/add.dart';
import 'package:eassets/equipment.dart';
import 'package:eassets/list.dart';
import 'package:eassets/loginscreen.dart';
import  'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintScreen1 extends StatefulWidget {

  @override
  State<ComplaintScreen1> createState() => _ComplaintScreen1State();
}

class _ComplaintScreen1State extends State<ComplaintScreen1> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title":'Track Assets',
      'number':" 115",
      "icon": Icons.biotech,
      "Navigation" : ListScreen()
    },
    {
      "title":'Track Technician',
      'number':"115",
      "icon": Icons.group,
      "Navigation" : CreateAssetScreen()
    },
    {
      "title":'Track Assset',
      'number':"115",
      "icon": Icons.account_tree
    },
    {
      "title":'Delivery Notes',
      'number':"115",
      "icon": Icons.biotech
    },
    {
      "title":'Receipts Notes',
      'number':"115",
      "icon": Icons.biotech
    },
    {
      "title":'Equipment Transfer',
      'number':"115",
      "icon": Icons.biotech
    },
];

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');  // Only remove the login status
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Redirect to login screen
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
            Container(
        height: 420,
        width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo,
          ),
            ),
                Positioned(
                  top: 30,
                  left: 35,
                  child: IconButton(onPressed: ()=> logout(context), icon:Icon(Icons.logout_sharp,color: Colors.white,))
                ),
                Positioned(
                  top: 30,
                  right: 35,
                  child: Icon(
                    Icons.notification_add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),


                Positioned(
                  top:35,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "eAssets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(top:140,left: 0,
                  right: 0,
                  child:Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                )
                ),
                Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1 Complaint Found !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(width: 250,height: 45,
                        child:
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(status: '1',),));
                          },
                          child: Text("RAISED A COMPLAINT",style: TextStyle(fontSize: 18),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              ),
              Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: gridMap.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>gridMap[index]['Navigation']));
                              },
                              icon: Icon(gridMap[index]['icon']),
                              iconSize: 47,
                              color: Colors.black,
                            ),
                            Text(
                              gridMap[index]['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              gridMap[index]['number'],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
        ),
        ),
      bottomNavigationBar: BottomNavigationBar(
          items:<BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label:"Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label:"Scan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label:"Report"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label:"Account")
          ]
      ),
    );
  }
}
