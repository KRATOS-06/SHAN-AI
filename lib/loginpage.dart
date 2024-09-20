import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/adminsigninpage.dart';
import 'package:gym_management/homepage.dart';
import 'package:gym_management/signinpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = "User";
  bool ischecked = false;
  bool checked = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String _uservalue = "";
  String _passwordvalue = "";

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(user);
    Uri url;
    if (user == "Admin") {
      url = Uri.parse(
          'https://gym-management-2.onrender.com/accounts/admin_login');
    } else if (user == "SuperUser") {
      url = Uri.parse(
          'https://gym-management-2.onrender.com/accounts/superlogin/');
    } else {
      url = Uri.parse(
          'https://gym-management-2.onrender.com/accounts/user_login');
    }
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': _uservalue,
          'password': _passwordvalue,
        }),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      final String userId = responseData['user_id'];

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200 && user == "SuperUser") {
        // Login successful
        await prefs.setString('user', "superuser");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminSignInPage(userid: userId)),
        );
      } else if (response.statusCode == 200 &&
          (user == "Admin" || user == "User")) {
        print('hi');

        await prefs.setString('user_id', userId);
        await prefs.setBool('islogin', true);
        if (user == "Admin"){
          final String gymId = responseData['gym_id'];
          await prefs.setString('gym_id', gymId);
          await prefs.setString('user', "admin");
        }
        else {
          await prefs.setString('user', "user");
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WorkoutHomePage()),
        );
        // Login successful
        /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WorkoutHomePage()),
          );*/
      } else {
        print('hi');
        // Login failed
        final Map<String, dynamic> responseData = json.decode(response.body);
        final errorMessage = responseData['message'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $errorMessage')),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: Unable to login')),
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
                  top: screenSize.height * 0.12,
                  right: screenSize.width * 0.01,
                  left: screenSize.width * 0.02,
                  child: Container(
                    height: screenSize.height * 0.8,
                    width: screenSize.width * 0.10,
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
                        // fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.55,
                  left: screenSize.width * 0.08,
                  right: screenSize.width * 0.08,
                  child: ExpansionTile(
                    backgroundColor: Color(0xff066589),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    title: Container(
                      color: Color(0xff066589),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        user, // Displays the selected user
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Color(0xff066589),
                        ),
                      ),
                    ),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        ischecked =
                            expanded; // Update the expansion state for color change
                      });
                    },
                    children: [
                      Container(
                        color: Color(0xff066589),
                        // Solid color for the expanded content
                        child: ListTile(
                          title: Text(user == "Admin" ? "User" : "Admin"),
                          onTap: () {
                            setState(() {
                              user = user == "Admin"
                                  ? "User"
                                  : "Admin"; // Update the user variable to "Admin"
                              ischecked = false; // Collapse after selection
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Color(0xff066589),
                        child: ListTile(
                          title:
                          Text(user == "SuperUser" ? "User" : "SuperUser"),
                          onTap: () {
                            setState(() {
                              user = user == "SuperUser"
                                  ? "User"
                                  : "SuperUser"; // Switch between SuperUser and User
                              ischecked = false; // Collapse after selection
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.28,
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
                            _uservalue = value ?? "";
                          },
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              size: screenSize.width * 0.07,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: screenSize.width * 0.05),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        TextFormField(
                          onSaved: (value) {
                            _passwordvalue = value ?? "";
                          },
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Please Enter Valid Password";
                            } else if (password.length < 3 ||
                                password.length > 15) {
                              return "Password must be 8-15 characters long";
                            }

                            return null;
                          },
                          obscureText: true,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.05),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              size: screenSize.width * 0.07,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: screenSize.width * 0.05),
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
                  top: screenSize.height * 0.70,
                  left: screenSize.width * 0.56,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      " Forget Password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenSize.width * 0.045),
                    ),
                  ),

                  /* Row(
                    children: [
                     /* Transform.scale(
                        scale: screenSize.width * 0.005,
                        child: Checkbox(
                          value: checked,
                          onChanged: (bool? value) {
                            setState(() {
                              checked = value ?? false;
                            });
                          },
                        ),
                      ),*/
                      /*  Text(
                        "keep logged in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenSize.width * 0.045),
                      ),*/
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "                                              Forget Password?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.045),
                        ),
                      ),
                    ],
                  ),*/
                ),
                Positioned(
                  top: screenSize.height * 0.77,
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
                        if (formkey.currentState != null &&
                            formkey.currentState!.validate()) {
                          formkey.currentState!.save();
                          _login(); // Call the login function
                        }
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.05),
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenSize.width * 0.045),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                          );
                        },
                        child: Text(
                          "Sign up?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: screenSize.width * 0.045),
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