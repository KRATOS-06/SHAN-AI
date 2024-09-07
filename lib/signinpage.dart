import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                child: Image.asset(
                  'assets/image2.png',
                  fit: BoxFit.cover,
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
                      Color(0xffff22D6E0),
                      Color(0xffff79BED6).withOpacity(0.4),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.07,
                left: screenWidth * 0.08,
                child: Text(
                  "    Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.08,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.16,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "First Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.26,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Last Name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.36,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.46,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Mobile Number",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.56,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_open,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.66,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_open,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.76,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.45,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "City",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.76,
                left: screenWidth * 0.6,
                child: SizedBox(
                  width: screenWidth * 0.35,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.security_outlined,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Zip Code",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.86,
                left: screenWidth * 0.08,
                child: SizedBox(
                  width: screenWidth * 0.85,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.05,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.map,
                        size: screenWidth * 0.08,
                      ),
                      hintText: "Country",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.045,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.96,
                left: screenWidth * 0.27,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.08,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffff066589),
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
