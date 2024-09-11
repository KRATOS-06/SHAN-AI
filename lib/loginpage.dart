import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gym_management/homepage.dart';
import 'package:gym_management/signinpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ischecked = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String _emailvalue = "";
  String _passwordvalue = "";

  Future<void> _login() async {
    final url = Uri.parse('https://gym-management-10.onrender.com/accounts/user_login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': _emailvalue,
        'password': _passwordvalue,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, the login was successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkoutHomePage()),
      );
    } else {
      // If the server returns a 400 response, the login failed
      final errorMessage = json.decode(response.body)['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $errorMessage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: screenSize.height,
            child: Stack(
              children: [
                Positioned(
                  top: screenSize.height * 0.04,
                  right: screenSize.width * 0.01,
                  left: screenSize.width * 0.02,
                  child: Container(
                    height: screenSize.height * 0.5,
                    width: screenSize.width * 0.9,
                    child: Image.asset(
                      'assets/image2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffff79BED6).withOpacity(0.4),
                        Color(0xffff22D6E0).withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.22,
                  left: screenSize.width * 0.35,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenSize.width * 0.1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.32,
                  left: screenSize.width * 0.08,
                  right: screenSize.width * 0.08,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.04,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            _emailvalue = value ?? "";
                          },
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.05),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              size: screenSize.width * 0.07,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: screenSize.width * 0.05),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.05),
                        TextFormField(
                          onSaved: (value) {
                            _passwordvalue = value ?? "";
                          },
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Please Enter Valid Password";
                            } else if (password.length < 8 || password.length > 15) {
                              return "Password must be 8-15 characters long";
                            }
                            return null;
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.05),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              size: screenSize.width * 0.07,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: screenSize.width * 0.05),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.66,
                  left: screenSize.width * 0.03,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: screenSize.width * 0.005,
                        child: Checkbox(
                          value: ischecked,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked = value ?? false;
                            });
                          },
                        ),
                      ),
                      Text(
                        "keep logged in",
                        style: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.045),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "       Forget Password?",
                          style: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.045),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.75,
                  left: screenSize.width * 0.3,
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: screenSize.height * 0.08,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xffff066589),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formkey.currentState != null && formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          _login(); // Call the login function
                        }
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.05),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenSize.height * 0.10,
                  left: screenSize.width * 0.02,
                  right: screenSize.width * 0.02,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Don’t you  have an Account?",
                          style: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.045),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInPage()),
                          );
                        },
                        child: Text(
                          "Sign up?",
                          style: TextStyle(color: Colors.blue, fontSize: screenSize.width * 0.045),
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
    );
  }
}
