import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewPlanPage extends StatefulWidget {
  final String gymId;

  const NewPlanPage({Key? key, required this.gymId}) : super(key: key);

  @override
  _NewPlanPageState createState() => _NewPlanPageState();
}

class _NewPlanPageState extends State<NewPlanPage> {
  final _formKey = GlobalKey<FormState>();
  String? planName;
  String? description;
  int? price;
  String? interval;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> submitNewPlan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    _formKey.currentState!.save();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? adminId = prefs.getString('user_id');

      if (adminId == null) {
        throw Exception('Admin ID not found in SharedPreferences');
      }

      final response = await http.post(
        Uri.parse('https://gym-management-2.onrender.com/subscriptions/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'plan_name': planName,
          'desc': description,
          'price': price,
          'admin': adminId,
          'gym_id': widget.gymId,
          'interval': interval,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context, true); // Go back to PlansPage with success
      } else {
        print(response.body);
        print(response.statusCode);
        setState(() {
          errorMessage = 'Failed to create plan';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Plan'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Plan Name'),
                validator: (value) => value!.isEmpty ? 'Please enter plan name' : null,
                onSaved: (value) => planName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter description' : null,
                onSaved: (value) => description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter price' : null,
                onSaved: (value) => price = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interval'),
                validator: (value) => value!.isEmpty ? 'Please enter interval' : null,
                onSaved: (value) => interval = value,
              ),
              SizedBox(height: 20),
              if (isLoading) CircularProgressIndicator(),
              if (!isLoading)
                ElevatedButton(
                  onPressed: submitNewPlan,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(),
                ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(errorMessage, style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
