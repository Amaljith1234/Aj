import 'package:eassets/add.dart';
import 'package:eassets/complaint.dart';
import 'package:eassets/equipment.dart';
import 'package:eassets/list.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/viewequipment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

