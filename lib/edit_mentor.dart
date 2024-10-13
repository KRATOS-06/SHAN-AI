import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateMentorPage extends StatefulWidget {
  final Function onMentorUpdated;
  final Map<String, dynamic> mentor;

  const UpdateMentorPage({Key? key, required this.onMentorUpdated, required this.mentor}) : super(key: key);

  @override
  _UpdateMentorPageState createState() => _UpdateMentorPageState();
}

class _UpdateMentorPageState extends State<UpdateMentorPage> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String firstName;
  late String lastName;
  late String expertise;
  late String email;
  late String phoneNumber;
  late String password1;
  late String password2;

  @override
  void initState() {
    super.initState();
    username = widget.mentor['username'] ?? '';
    firstName = widget.mentor['first_name'] ?? '';
    lastName = widget.mentor['last_name'] ?? '';
    expertise = widget.mentor['expertise'] ?? '';
    email = widget.mentor['email'] ?? '';
    phoneNumber = widget.mentor['phone_number'] ?? '';
    password1 = '';
    password2 = '';
  }

  Future<void> _updateMentor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String adminId = prefs.getString('user_id') ?? '';

      // Updated payload based on API requirements
      final Map<String, dynamic> updatedMentorData = {
        "admin": adminId,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "expertise": expertise,
        "email": email,
        "phone_number": phoneNumber,
        "password1": password1,
        "password2": password2,
        "mentor_id": widget.mentor['id'],
        "gym_id": widget.mentor['Gym']
      };
      print(updatedMentorData);
      try {
        final response = await http.put(
          Uri.parse('https://gym-management-2.onrender.com/mentors/'),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(updatedMentorData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mentor updated successfully!')),
          );
          widget.onMentorUpdated();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update mentor: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
        print(e);
      }
    }
  }
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B2B2),
        title: Text('Update Mentor'),
      ),
      backgroundColor: const Color(0xFF00B2B2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value ?? '';
                },
              ),
              TextFormField(
                initialValue: firstName,
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  firstName = value ?? '';
                },
              ),
              TextFormField(
                initialValue: lastName,
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  lastName = value ?? '';
                },
              ),
              TextFormField(
                initialValue: expertise,
                decoration: InputDecoration(labelText: 'Expertise'),
                onSaved: (value) {
                  expertise = value ?? '';
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value ?? '';
                },
              ),
              TextFormField(
                initialValue: phoneNumber,
                decoration: InputDecoration(labelText: 'Phone Number'),
                onSaved: (value) {
                  phoneNumber = value ?? '';
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'New Password'),
                onSaved: (value) {
                  password1 = value ?? '';
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                onSaved: (value) {
                  password2 = value ?? '';
                },
                obscureText: true,
                validator: (value) {
                  if (_passwordController.text != value) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateMentor,
                child: Text('Update Mentor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
