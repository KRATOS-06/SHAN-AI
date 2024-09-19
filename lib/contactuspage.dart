import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactUsForm extends StatefulWidget {
  @override
  _ContactUsFormState createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Function to send the form data using EmailJS API
  Future<void> sendEmail() async {
    const serviceId = 'service_yf5kzb5'; // Your service ID
    const templateId = 'template_tr7an7l'; // Your template ID
    const publicKey = 'doxCmVOUD5Vqs6iJE'; // Your public key

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost', // Required for CORS compliance
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'user_name': _nameController.text,
          'user_email': _emailController.text,
          'user_phone': _phoneController.text,
          'message': _messageController.text,
        },
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message Sent Successfully')),
      );
    } else {
      print('Failed response: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send message')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
      ),
      backgroundColor: Color(0xff00b2b2),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.05),
          color: Color(0xff00b2b2),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField('Name', _nameController, screenHeight, screenWidth),
                _buildTextField('Email Address', _emailController, screenHeight, screenWidth),
                _buildTextField('Phone Number', _phoneController, screenHeight, screenWidth),
                _buildTextField('Message', _messageController, screenHeight, screenWidth, maxLines: 4),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendEmail(); // Send the email on submit
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff066589),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.15,
                      vertical: screenHeight * 0.015,
                    ),
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
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller, double screenHeight, double screenWidth, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: screenHeight * 0.01),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.black, fontSize: screenWidth * 0.045),
            textAlign: TextAlign.left,
          ),
        ),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
                horizontal: screenWidth * 0.04),
            filled: true,
            fillColor: Color(0xFFD5EFFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
      ],
    );
  }
}