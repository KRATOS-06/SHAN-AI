import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gym_management/gym_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorSignInPage extends StatefulWidget {

  const MentorSignInPage({super.key});

  @override
  State<MentorSignInPage> createState() => _MentorSignInPageState();
}

class _MentorSignInPageState extends State<MentorSignInPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _gymIdController = TextEditingController();

  // Validators
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length > 150) {
      return 'Username must be 150 characters or less';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length > 150) {
      return 'Must be 150 characters or less';
    }
    return null;
  }

  String? _validateExpertise(String? value) {
    if (value != null && value.length > 150) {
      return 'Expertise must be 150 characters or less';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (value.length > 254) {
      return 'Email must be 254 characters or less';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 1 || value.length > 15) {
      return 'Phone number must be between 1 and 15 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 1 || value.length > 20) {
      return 'Password must be between 1 and 20 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _password1Controller.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateGymId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the gym ID';
    }
    // Add UUID format validation if needed
    return null;
  }

  Future<void> _submitForm() async {
    // Obtain the gym ID and admin ID from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gymId = prefs.getString('gym_id') ?? '';
    String adminId = prefs.getString('user_id') ?? '';

    // Validate form inputs
    if (_formKey.currentState!.validate()) {
      try {
        // Send the POST request
        final response = await http.post(
          Uri.parse('https://gym-management-2.onrender.com/mentors/'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'admin': adminId,                      // Admin ID
            'username': _usernameController.text,   // Username
            'first_name': _firstNameController.text,// First Name
            'last_name': _lastNameController.text,  // Last Name
            'expertise': _expertiseController.text, // Expertise
            'email': _emailController.text,         // Email
            'phone_number': _phoneNumberController.text, // Phone Number
            'password1': _password1Controller.text, // Password 1
            'password2': _password2Controller.text, // Password 2
            'gym_id': gymId,                        // Gym ID
          }),
        );

        // Handle success response
        if (response.statusCode == 201) {
          print('Registration successful ${response.body}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MentorPage(),
            ),
          );
        } else {
          // Handle error responses
          print('Failed to register: ${response.body}');
          final Map<String, dynamic> responseData = json.decode(response.body);
          final errorMessage = responseData['message'] ?? 'Unknown error';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: $errorMessage')),
          );
        }
      } catch (e) {
        // Handle network errors
        print('An error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Network error: Unable to register')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Sign Up')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: _validateUsername,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: _validateName,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: _validateName,
              ),
              TextFormField(
                controller: _expertiseController,
                decoration: InputDecoration(labelText: 'Expertise'),
                validator: _validateExpertise,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: _validatePhoneNumber,
              ),
              TextFormField(
                controller: _password1Controller,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              TextFormField(
                controller: _password2Controller,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _expertiseController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    _gymIdController.dispose();
    super.dispose();
  }
}