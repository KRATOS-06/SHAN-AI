import 'package:flutter/material.dart';

class ContactUsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Apply background color to the Scaffold
        Scaffold(
          backgroundColor: Color(0xff00b2b2),
          // Background color of the entire page
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Color(0xff00b2b2),
              /*  decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7FE5FF), Color(0xFF90DFFE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Optional: Add some spacing at the top
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Name',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // Reduces the height of the TextField
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Email Address',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // Reduces the height of the TextField
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // Reduces the height of the TextField
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Message',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      isDense: true,
                      // Reduces the height of the TextField
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      hintText: 'Any Queries..........',
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                      // Reduced font size
                      filled: true,
                      fillColor: Color(0xFFD5EFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffff066589),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 0,
          child: Image.asset(
            'assets/gym_logo.png', // Add the correct path to your image
            width: 120, // Set the desired width for the logo
          ),
        ),
      ],
    );
  }
}
