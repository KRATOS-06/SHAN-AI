import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  right: 5,
                  left: 10,
                  child: Container(
                    height: 800,
                    width: 500,
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
                        Color(0xffff22D6E0).withOpacity(0.6)
                      ])),
                ),
                Positioned(
                  top: 180,
                  left: 145,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 35,
                  right: 35,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            _emailvalue = value ?? "";
                          },
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return "Please Enter Name";
                            }
                            /*else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email)) {
                              return "Please Enter Valid Email Address";
                            }*/
                            else if (email != "gym") {
                              return "Invalid Name";
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle_rounded,
                                size: 30,
                              ),
                              hintText: "Name",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.4),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          onSaved: (value) {
                            _passwordvalue = value ?? "";
                          },
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Please Enter Valid Password";
                            } else if (password.length < 8 ||
                                password.length > 15) {
                              return "Password must be 8-15 characters long";
                            } else if (password != "12345678") {
                              return "Invalid Password";
                            }
                            return null;
                          },
                          obscureText: true,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              hintText: "Password",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.4),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0))),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 530,
                  left: 10,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            value: ischecked,
                            onChanged: (bool? value) {
                              setState(() {
                                ischecked = value ?? false;
                              });
                            }),
                      ),
                      Text(
                        "keep logged in",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "       Forget Password?",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: 600,
                  left: 110,
                  child: Container(
                      width: 200,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffff066589),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();

                              if (_emailvalue == "gym" &&
                                  _passwordvalue == "12345678") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WorkoutHomePage()));
                              }
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))),
                ),
                Positioned(
                  bottom: 120,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            " Don’t you  have an Account?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: Text(
                            "           Sign up?",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
