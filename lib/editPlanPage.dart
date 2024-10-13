import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'gym_details_page.dart';

class EditPlanPage extends StatefulWidget {
  final String planId;
  final String planName;
  final String desc;
  final String price;
  final String interval;
  final String intervalCount;
  final String gymId;

  const EditPlanPage({
    Key? key,
    required this.planId,
    required this.planName,
    required this.desc,
    required this.price,
    required this.interval,
    required this.intervalCount,
    required this.gymId,
  }) : super(key: key);

  @override
  _EditPlanPageState createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  final _formKey = GlobalKey<FormState>();
  late String _planName;
  late String _desc;
  late String _price;
  late String _interval;
  late String _intervalCount;

  @override
  void initState() {
    super.initState();
    _planName = widget.planName;
    _desc = widget.desc;
    _price = widget.price;
    _interval = widget.interval;
    _intervalCount = widget.intervalCount;
  }

  Future<void> updatePlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getString('user_id');
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.put(
          Uri.parse('https://gym-management-2.onrender.com/subscriptions/'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "plan_id": widget.planId,
            "plan_name": _planName,
            "desc": _desc,
            "price": double.parse(_price),
            "admin": adminId,
            "gym_id": widget.gymId,
            "interval": _interval,
            "interval_count": _intervalCount
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Plan updated successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PlansPage(GymId: widget.gymId),
            ),
          );
        } else {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to update plan: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating plan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Plan'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _planName,
                decoration: InputDecoration(labelText: 'Plan Name'),
                onSaved: (value) {
                  _planName = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },

              ),
              TextFormField(
                initialValue: _desc,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _desc = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },

              ),
              TextFormField(
                initialValue: _price,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },

              ),
              TextFormField(
                initialValue: _interval,
                decoration: InputDecoration(labelText: 'Interval'),
                onSaved: (value) {
                  _interval = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an interval';
                  }
                  return null;
                },

              ),
              TextFormField(
                initialValue: _intervalCount,
                decoration: InputDecoration(labelText: 'Interval Count'),
                onSaved: (value) {
                  _intervalCount = value!;
                },
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an interval count';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid integer';
                  }
                  return null;
                },

              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    updatePlan();
                  }
                },
                child: Text('Update Plan'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}