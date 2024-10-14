import 'package:eassets/utility.dart';
import 'package:flutter/material.dart';



class AlertPage extends StatefulWidget {

  String? type;
  String message;

  AlertPage({Key? key , this.type,required this.message}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    Image img =  Image.asset(
      'assets/logo.jpeg',
      height: Utility.logoHeight,
    );

    if(widget.type == "NO_INTERNET"){
      img =  Image.asset(
        'assets/no_internet.jpeg',
        height: Utility.logoHeight,
      );
    }


    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: Utility.logoHeight),
                    img,
                    Text(widget.message, style: headingStyle),
                  ],
                ),
              ),
            ),
          ),
        ));
  }



}
const headingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);