import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditPlanPage extends StatefulWidget {
  final String planId;
  final String planName;
  final String desc;
  final String price;
  final String interval;
  final String gymId;
  final String adminId;

  const EditPlanPage({
    Key? key,
    required this.planId,
    required this.planName,
    required this.desc,
    required this.price,
    required this.interval,
    required this.gymId,
    required this.adminId,
  }) : super(key: key);

  @override
  _EditPlanPageState createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _planNameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _intervalController;

  @override
  void initState() {
    super.initState();
    _planNameController = TextEditingController(text: widget.planName);
    _descController = TextEditingController(text: widget.desc);
    _priceController = TextEditingController(text: widget.price);
    _intervalController = TextEditingController(text: widget.interval);
  }

  Future<void> updatePlan() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.put(
          Uri.parse('https://gym-management-2.onrender.com/subscriptions/'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "plan_name": _planNameController.text,
            "desc": _descController.text,
            "price": double.parse(_priceController.text),
            "admin": widget.adminId,
            "gym_id": widget.gymId,
            "interval": _intervalController.text
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Plan updated successfully')),
          );
          Navigator.pop(context, true); // Pop back with success signal
        } else {
          throw Exception('Failed to update plan');
        }
      } catch (e) {
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
          child: Column(
            children: [
              TextFormField(
                controller: _planNameController,
                decoration: InputDecoration(labelText: 'Plan Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _intervalController,
                decoration: InputDecoration(labelText: 'Interval'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an interval';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updatePlan,
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
