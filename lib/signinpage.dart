import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gym_management/homepage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();

  Future<void> _register() async {
    final url = Uri.parse('https://gym-management-10.onrender.com/accounts/user_register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": _userNameController.text, // Replace with actual username
        "first_name": _firstNameController.text,
        "last_name": _lastNameController.text,
        "email": _emailController.text,
        "phone_number": _phoneController.text,
        "country": _countryController.text,
        "password1": _passwordController.text,
        "password2": _confirmPasswordController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Navigate to HomePage if registration is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkoutHomePage()),
      );
    } else {
      _showErrorDialog('Invalid input or missing fields');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00B2B2),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Create Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.0),
            _buildTextField(_userNameController, Icons.account_circle_rounded, "User Name"),
            SizedBox(height: 16.0),
            _buildTextField(_firstNameController, Icons.account_circle_rounded, "First Name"),
            SizedBox(height: 16.0),
            _buildTextField(_lastNameController, Icons.account_circle_rounded, "Last Name"),
            SizedBox(height: 16.0),
            _buildTextField(_emailController, Icons.email_outlined, "Email"),
            SizedBox(height: 16.0),
            _buildTextField(_phoneController, Icons.phone, "Mobile Number"),
            SizedBox(height: 16.0),
            _buildTextField(_countryController, Icons.map, "Country"),
            SizedBox(height: 16.0),
            _buildTextField(_cityController, Icons.location_city, "City"),
            SizedBox(height: 16.0),
            _buildTextField(_zipCodeController, Icons.code, "ZIP Code"),
            SizedBox(height: 16.0),
            _buildTextField(_passwordController, Icons.lock_open, "Password", obscureText: true),
            SizedBox(height: 16.0),
            _buildTextField(_confirmPasswordController, Icons.lock_open, "Confirm Password", obscureText: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffff066589),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: _register,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String hintText, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.black,
        fontSize: MediaQuery.of(context).size.width * 0.05,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: MediaQuery.of(context).size.width * 0.08,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.width * 0.045,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.06),
        ),
      ),
    );
  }
}
