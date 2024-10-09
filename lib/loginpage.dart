import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/adminsigninpage.dart';
import 'package:gym_management/homepage.dart';
import 'package:gym_management/signinpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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

    // Login URLs based on user type
    if (user == "Admin") {
      url = Uri.parse('https://gym-management-2.onrender.com/accounts/admin_login');
    } else if (user == "SuperUser") {
      url = Uri.parse('https://gym-management-2.onrender.com/accounts/superlogin/');
    } else if (user == "Mentor") {
      url = Uri.parse('https://gym-management-2.onrender.com/mentors/login/');
    } else {
      url = Uri.parse('https://gym-management-2.onrender.com/accounts/user_login');
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
      final String userId;
      final String? gymId = responseData['gym_id'];
      
      if (user == "Mentor") {
        userId = responseData['mentor_id'] ?? "";
      } else {
        userId = responseData['user_id'] ?? "";
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 && user == "SuperUser") {
        await prefs.setString('user', "superuser");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminSignInPage(userid: userId)),
        );
      } else if (response.statusCode == 200 && 
                (user == "Admin" || user == "User" || user == "Mentor")) {
        await prefs.setString('user_id', userId);
        await prefs.setString('gym_id', gymId ?? "");
        await prefs.setBool('islogin', true);

        if (user == "Admin") {
          await prefs.setString('gym_id', gymId ?? "null");
          await prefs.setString('user', "admin");
        } else if (user == "Mentor") {
          await prefs.setString('user', "mentor");
        } else if (user == "User") {
          await prefs.setString('user', "user");
          
          // Fetch user details
          final userResponse = await http.get(
            Uri.parse('https://gym-management-2.onrender.com/accounts/user_register?id=$userId'),
          );
          
          if (userResponse.statusCode == 200) {
            final Map<String, dynamic> userData = json.decode(userResponse.body);
            await prefs.setString('name', userData['username']?.toString() ?? 'Unknown');
            await prefs.setString('first_name', userData['first_name']?.toString() ?? '');
            await prefs.setString('last_name', userData['last_name']?.toString() ?? '');
            await prefs.setString('address', userData['address']?.toString() ?? '');
            await prefs.setString('pincode', userData['pincode']?.toString() ?? '');
            await prefs.setString('phone', userData['phone_number']?.toString() ?? '');
            await prefs.setString('country', userData['country']?.toString() ?? '');
          } else {
            print('Failed to fetch user details');
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WorkoutHomePage()),
        );
      } else {
        // Login failed
        final errorMessage = responseData['message'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $errorMessage')),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error: Unable to login')),
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
          child: SizedBox(
            height: screenSize.height,
            child: Stack(
              children: [
                Positioned(
                  top: screenSize.height * 0.12,
                  right: screenSize.width * 0.01,
                  left: screenSize.width * 0.02,
                  child: SizedBox(
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
                        const Color(0xffff79bed6).withOpacity(0.4),
                        const Color(0xffff22d6e0).withOpacity(0.6),
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
                    backgroundColor: const Color(0xff066589),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    title: Container(
                      color: const Color(0xff066589),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        user,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Color(0xff066589),
                        ),
                      ),
                    ),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        ischecked = expanded;
                      });
                    },
                    children: [
                      Container(
                        color: const Color(0xff066589),
                        child: ListTile(
                          title: Text(user == "User" ? "Admin" : "User"),
                          onTap: () {
                            setState(() {
                              user = user == "User" ? "Admin" : "User";
                              ischecked = false;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: const Color(0xff066589),
                        child: ListTile(
                          title: Text(user == "SuperUser" ? "User" : "SuperUser"),
                          onTap: () {
                            setState(() {
                              user = user == "SuperUser" ? "User" : "SuperUser";
                              ischecked = false;
                            });
                          },
                        ),
                      ),
                      Container(
                        color: const Color(0xff066589),
                        child: ListTile(
                          title: Text(user == "Mentor" ? "User" : "Mentor"),
                          onTap: () {
                            setState(() {
                              user = user == "Mentor" ? "User" : "Mentor";
                              ischecked = false;
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


                ),
                Positioned(
                  top: screenSize.height * 0.77,
                  left: screenSize.width * 0.3,
                  child: Container(
                    width: screenSize.width * 0.4,
                    height: screenSize.height * 0.08,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffff066589),
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
                                builder: (context) => const SignInPage()),
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