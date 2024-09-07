import 'package:flutter/material.dart';

class ContactUsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Apply background color to the Scaffold
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: screenWidth * 0.07,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
            ),
            backgroundColor: Color(0xff00b2b2),
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.04),
                child: Image.asset(
                  'assets/gym_logo.png',
                  height: screenHeight * 0.08,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xff00b2b2),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(screenWidth * 0.05),
              color: Color(0xff00b2b2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [// Spacing at the top
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.04),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.04),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.04),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: Text(
                      'Message',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.045),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.04),
                      hintText: 'Any Queries..........',
                      hintStyle: TextStyle(
                          color: Colors.black54, fontSize: screenWidth * 0.035),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffff066589),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(screenWidth * 0.05),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.15,
                          vertical: screenHeight * 0.015),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: screenWidth * 0.045, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
