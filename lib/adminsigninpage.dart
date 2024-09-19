import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:gym_management/homepage.dart';

class AdminSignInPage extends StatefulWidget {
  final String userid;

  const AdminSignInPage({super.key, required this.userid});

  @override
  State<AdminSignInPage> createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture form input values
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _gymNameController = TextEditingController();
  final TextEditingController _gymAddressController = TextEditingController();
  final TextEditingController _gymPhoneController = TextEditingController();

  // Validators for each field
  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final mobileRegex = RegExp(r'^\d{10}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  String? _validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your zip code';
    }
    final zipRegex = RegExp(r'^\d{6}$');
    if (!zipRegex.hasMatch(value)) {
      return 'Enter a valid 5-digit zip code';
    }
    return null;
  }

  String? _validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your country';
    }
    return null;
  }

  String? _validateGymName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the gym name';
    }
    return null;
  }

  String? _validateGymAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the gym address';
    }
    return null;
  }

  String? _validateGymPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the gym phone number';
    }
    final phoneRegex = RegExp(r'^\d{10}$'); // Assuming 10-digit phone number
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print("hello");
      try {
        // Prepare the POST request data
        final response = await http.post(
          Uri.parse(
              'https://gym-management-2.onrender.com/accounts/admin_register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'id': widget.userid,
            'username': _userNameController.text,
            'first_name': _firstNameController.text,
            'last_name': _lastNameController.text,
            'email': _emailController.text,
            'phone_number': _mobileController.text,
            'password1': _passwordController.text,
            'password2': _passwordController.text,
            'city': _cityController.text,
            'country': _countryController.text,
            'gym_name': _gymNameController.text,
            'gym_address': _gymAddressController.text,
            'gym_phone_number': _gymPhoneController.text,
          }),
        );
        print(response.statusCode);
        if (response.statusCode == 201) {
          // If the server returns a successful response
          print('Registration successful ${response.body}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WorkoutHomePage()),
          );
        } else {
          // If the server returns an error response
          print('Failed to register: ${response.body}');
          final Map<String, dynamic> responseData = json.decode(response.body);
          final errorMessage = responseData['message'] ?? 'Unknown error';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $errorMessage')),
          );
        }
      } catch (e) {
        // Navigator.of(context).pop();
        // Handle any exceptions (like network issues)
        print('An error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: Unable to login')),
        );
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _gymNameController.dispose();
    _gymAddressController.dispose();
    _gymPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              // Gradient Overlay
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.08,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: _userNameController,
                          validator: _validateFirstName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              size: screenWidth * 0.08,
                            ),
                            hintText: "User Name",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.045,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // First Name
                        TextFormField(
                          controller: _firstNameController,
                          validator: _validateFirstName,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Last Name
                        TextFormField(
                          controller: _lastNameController,
                          validator: _validateLastName,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          validator: _validateEmail,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Mobile Number
                        TextFormField(
                          controller: _mobileController,
                          validator: _validateMobile,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Password
                        TextFormField(
                          controller: _passwordController,
                          validator: _validatePassword,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Confirm Password
                        TextFormField(
                          controller: _confirmPasswordController,
                          validator: _validateConfirmPassword,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Gym Name
                        TextFormField(
                          controller: _gymNameController,
                          validator: _validateGymName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.map,
                              size: screenWidth * 0.08,
                            ),
                            hintText: "Gym Name",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.045,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Gym Address
                        TextFormField(
                          controller: _gymAddressController,
                          validator: _validateGymAddress,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.map,
                              size: screenWidth * 0.08,
                            ),
                            hintText: "Gym Address",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.045,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Gym Phone Number
                        TextFormField(
                          controller: _gymPhoneController,
                          validator: _validateGymPhone,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.map,
                              size: screenWidth * 0.08,
                            ),
                            hintText: "Gym Phone Number",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.045,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // City and Zip Code
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _cityController,
                                validator: _validateCity,
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
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.06),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: _zipCodeController,
                                validator: _validateZipCode,
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
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.06),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Country
                        TextFormField(
                          controller: _countryController,
                          validator: _validateCountry,
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
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.06),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Sign Up Button
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.08,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xffff066589),
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.06),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _formKey.currentState != null) {
                                // Form is valid, proceed further by submitting the form
                                _submitForm(); // Call the form submission function here
                              } else {
                                print("Form is not valid");
                              }
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
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