import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'gym_details_page.dart';

class NewCustomerPage extends StatefulWidget {
  const NewCustomerPage({Key? key}) : super(key: key);

  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  String? adminId;
  String? gymId;
  String? planName;
  String? firstname;
  String? lastname;
  String? status;
  String? start_date;
  String? end_date;
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
      String? gymId = prefs.getString('gym_id');
      if (adminId == null) {
        throw Exception('Admin ID not found in SharedPreferences');
      }
      print('Admin ID: $adminId');
      print('Gym ID: $gymId');
      final response = await http.post(
        Uri.parse('https://gym-management-2.onrender.com/customers/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'plan_name': planName,
          'username':firstname,
          'first_name': firstname,
          'last_name': lastname,
          'admin': adminId,
          'gym': gymId,
          'plan_status': status,
          'plan_start_date':start_date,
          'plan_end_date':end_date,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 500) {
        print(response.statusCode);
        print("customer added successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  CustomerPage()));
      } else {
        print(response.statusCode);
        print(response.body);
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
        title: Text('Create New Customer'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  decoration: InputDecoration(labelText: 'first name'),
                  validator: (value) => value!.isEmpty ? 'Please enter description' : null,
                  onSaved: (value) => firstname = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'last name'),
                  //keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Please enter price' : null,
                  onSaved: (value) => lastname = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'plan status'),
                  validator: (value) => value!.isEmpty ? 'Please enter interval' : null,
                  onSaved: (value) => status = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'start date (YYYY-MM-DD)'),
                  validator: (value) => value!.isEmpty ? 'Please enter interval' : null,
                  onSaved: (value) => start_date = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'end date (YYYY-MM-DD)'),
                  validator: (value) => value!.isEmpty ? 'Please enter interval' : null,
                  onSaved: (value) => end_date = value,
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
      ),
    );
  }
}


class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<dynamic> customers = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? adminId = prefs.getString('user_id');
    String? gymId = prefs.getString('gym_id');

    if (adminId == null || gymId == null) {
      setState(() {
        errorMessage = 'Admin ID or Gym ID not found';
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://gym-management-2.onrender.com/customers/?admin=$adminId&gym_id=$gymId'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          customers = json.decode(response.body);
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load customers';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: customers.isEmpty
          ? Center(child: isLoading ? CircularProgressIndicator() : Text('No customers available'))
          : ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          var customer = customers[index];
          return ListTile(
            title: Text('${customer['first_name']} ${customer['last_name']}'),
            subtitle: Text('Plan: ${customer['plan_name']} - Status: ${customer['plan_status']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewCustomerPage()),  // Navigate to AddCustomerPage
          ).then((value) {
            if (value == true) {
              fetchCustomers();
            }
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00B2B2),
      ),
    );
  }
}
