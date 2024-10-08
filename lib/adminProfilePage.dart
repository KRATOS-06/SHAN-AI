import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  String? _error;
  String? _userRole;
  String? _userId;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _gymNameController = TextEditingController();
  final TextEditingController _gymAddressController = TextEditingController();
  final TextEditingController _gymPhoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    _gymNameController.dispose();
    _gymAddressController.dispose();
    _gymPhoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('user_id') ?? '';
    _userRole = prefs.getString('user') ?? '';

    String apiUrl = _userRole == 'admin'
        ? 'https://gym-management-2.onrender.com/accounts/admin_register?id=$_userId'
        : 'https://gym-management-2.onrender.com/accounts/user_register?id=$_userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _profileData = json.decode(response.body);
          _isLoading = false;
          _populateControllers();
        });
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _populateControllers() {
    _usernameController.text = _profileData?['username'] ?? '';
    _firstNameController.text = _profileData?['first_name'] ?? '';
    _lastNameController.text = _profileData?['last_name'] ?? '';
    _emailController.text = _profileData?['email'] ?? '';
    _phoneNumberController.text = _profileData?['phone_number'] ?? '';
    _countryController.text = _profileData?['country'] ?? '';
    if (_userRole == 'admin') {
      _gymNameController.text = _profileData?['gym_name'] ?? '';
      _gymAddressController.text = _profileData?['gym_address'] ?? '';
      _gymPhoneNumberController.text = _profileData?['gym_phone_number'] ?? '';
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String apiUrl = _userRole == 'admin'
        ? 'https://gym-management-2.onrender.com/accounts/admin_register'
        : 'https://gym-management-2.onrender.com/accounts/user_register';

    Map<String, dynamic> body = {
      "id": _userId,
      "username": _usernameController.text,
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "phone_number": _phoneNumberController.text,
      "country": _countryController.text,
      "password1": _password1Controller.text,
      "password2": _password2Controller.text,
    };

    if (_userRole == 'admin') {
      body.addAll({
        "gym_name": _gymNameController.text,
        "gym_address": _gymAddressController.text,
        "gym_phone_number": _gymPhoneNumberController.text,
      });
    }

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        _fetchProfileData(); // Refresh profile data
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: ${e.toString()}')),
      );
    }
  }

  Future<void> _deleteProfile() async {
    String apiUrl = _userRole == 'admin'
        ? 'https://gym-management-2.onrender.com/accounts/admin_register?id=$_userId'
        : 'https://gym-management-2.onrender.com/accounts/user_register?id=$_userId';

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Profile deleted successfully
        Navigator.of(context).pushReplacementNamed('/login'); // Redirect to login page
      } else {
        throw Exception('Failed to delete profile');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting profile: ${e.toString()}')),
      );
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      // You can add more sophisticated email validation here
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(labelText: 'Country'),
                  ),
                  TextFormField(
                    controller: _password1Controller,
                    decoration: InputDecoration(labelText: 'New Password'),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _password2Controller,
                    decoration: InputDecoration(labelText: 'Confirm New Password'),
                    obscureText: true,
                    validator: (value) {
                      if (_password1Controller.text.isNotEmpty && value != _password1Controller.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  if (_userRole == 'admin') ...[
                    TextFormField(
                      controller: _gymNameController,
                      decoration: InputDecoration(labelText: 'Gym Name'),
                    ),
                    TextFormField(
                      controller: _gymAddressController,
                      decoration: InputDecoration(labelText: 'Gym Address'),
                    ),
                    TextFormField(
                      controller: _gymPhoneNumberController,
                      decoration: InputDecoration(labelText: 'Gym Phone Number'),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  _updateProfile();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Profile'),
          content: Text('Are you sure you want to delete your profile? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProfile();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileItem(String label, String value, IconData icon) {
    return Animate(
      effects: [FadeEffect(delay: 300.ms), SlideEffect(begin: Offset(0, 50), end: Offset.zero)],
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _showDeleteConfirmation,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator().animate().scale())
          : _error != null
          ? Center(child: Text('Error: $_error').animate().fadeIn())
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Animate(
              effects: [FadeEffect(), ScaleEffect()],
              child: Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Animate(
              effects: [FadeEffect(delay: 200.ms), SlideEffect(begin: Offset(0, 50), end: Offset.zero)],
              child: Text(
                '${_profileData?['first_name']} ${_profileData?['last_name']}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            _buildProfileItem('Username', _profileData?['username'] ?? '', Icons.person),
            _buildProfileItem('Email', _profileData?['email'] ?? '', Icons.email),
            _buildProfileItem('Phone Number', _profileData?['phone_number'] ?? '', Icons.phone_android),
            _buildProfileItem('Country', _profileData?['country'] ?? '', Icons.flag),
            if (_userRole == 'admin') ...[
              _buildProfileItem('Gym Name', _profileData?['gym_name'] ?? '', Icons.fitness_center),
              _buildProfileItem('Gym Address', _profileData?['gym_address'] ?? '', Icons.location_on),
              _buildProfileItem('Gym Phone', _profileData?['gym_phone_number'] ?? '', Icons.phone),
            ],
          ],
        ),
      ),
    );
  }
}