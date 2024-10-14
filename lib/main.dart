import 'dart:async';

import 'package:eassets/User/users_provider.dart';
import 'package:eassets/add.dart';
import 'package:eassets/complaint.dart';
import 'package:eassets/equipment.dart';
import 'package:eassets/list.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/utility.dart';
import 'package:eassets/viewequipment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp( MultiProvider(providers: providers, child: const MyApp()),);
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home:LoginScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // getTocken();


    Timer(const Duration(seconds: 3), () async {
      String? token = await Utility.getSharedPreferences(API_TOKEN);
      if (token == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Utility.usermodel = await Utility.getUserSharedPreferences();
        bool val = await Utility.checkLogin(context);
        if (val == false) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }else{
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ComplaintScreen1()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
