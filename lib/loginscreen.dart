import 'dart:convert';
import 'package:eassets/dio_client.dart';
import 'package:eassets/urlscreen.dart';
import 'package:eassets/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:eassets/complaint.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginLoading= false;

  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
  }

  // Future<void> _checkLoginStatus() async {
  //   final String username =_userController.text;
  //   final String password =_passwordController.text;
  //   var response =await http.post(Uri.parse('https://example.com/api/login'),
  //   body: {"username" : username, "password":password}
  //   );
  //   if (response.statusCode==200) {
  //     var data=jsonDecode(response.body);
  //     String token =data["token"];
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString("token", token);
  //     // If the user is already logged in, navigate to the next screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ComplaintScreen1(),
  //       ),
  //     );
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("invalid  user or password !"))
  //     );
  //   }
  // }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required';
    }else
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }



  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Image.asset(
                    "image/wheelchair.png",
                    height: 110,
                    width: 100,
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'eAssets',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _userController,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "UserName",
                                  labelStyle: TextStyle(
                                    color: Colors.black87.withOpacity(0.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: validateUserName,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: "PASSWORD",
                                  labelStyle: TextStyle(
                                    color: Colors.black87.withOpacity(0.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: Icon(Icons.vpn_key),
                                ),
                                validator: validatePassword,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: MaterialButton(
                            onPressed:() async {
                              if (_isLoginLoading == false) {
                                String email = _userController.text;
                                String password = _passwordController.text;

                                if (email.isEmpty || password.isEmpty) {
                                  Utility.errorAlert(context, "Invalid Login Details");
                                } else {
                                  setState(() {
                                    _isLoginLoading = true;
                                  });
                                  await login(context , email, password);
                                  setState(() {
                                    _isLoginLoading = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 70,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        SizedBox(height: 11),
                        Align(
                          child: TextButton(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> login(
      BuildContext context, String email, String password) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
    };
    String body = json.encode(data);
    print('Login request body: $body');
    print(UrlConstantscreen.LOGIN_URL);
    final response = await DioClient.post(UrlConstantscreen.LOGIN_URL, body: body);
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['success'] == true) {
        var data = result['data'];
        data['user']['password'] = password;
        var token = data['token'];
        print('Token: $token');
        print('User data: ${data['user']}');
        await Utility.storeSharedPreferences(API_TOKEN, token);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>  ComplaintScreen1()));

      } else  {
        Utility.errorAlert(context, result['message']);
        return false;
      }
    } else {
      Utility.errorAlert(context, "Login  Error");
    }

    return true;
  }
}

const String API_TOKEN = "token";