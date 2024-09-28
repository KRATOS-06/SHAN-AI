import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_management/mentorsigninpage.dart';
import 'package:gym_management/newPlanPage.dart';
import 'package:gym_management/editPlanPage.dart';

class GymDetailsPage extends StatelessWidget {
  final Map<String, dynamic> gymDetails;

  const GymDetailsPage({Key? key, required this.gymDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B2B2),
        title: Text(gymDetails['gym_name'] ?? 'Gym Details'),
      ),
      backgroundColor: const Color(0xFF00B2B2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gym Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow('Name', gymDetails['gym_name']),
                  _buildDetailRow('Email', gymDetails['gym_email']),
                  _buildDetailRow('Phone', gymDetails['gym_phone_number']),
                  _buildDetailRow('Address', gymDetails['gym_address']),
                  _buildDetailRow('Owner', '${gymDetails['gym_owner_first_name'] ?? ''} ${gymDetails['gym_owner_last_name'] ?? ''}'),
                  _buildDetailRow('Promo Code', gymDetails['promo_code']),
                  _buildDetailRow('Promo Offers', _getBooleanString(gymDetails['promo_code_offers'])),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Mentor Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MentorPage(),
                            ),
                          );
                        },
                        child: Text('View Mentors'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Plans Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlansPage(),
                            ),
                          );
                        },
                        child: Text('View Plans'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  String _getBooleanString(dynamic value) {
    if (value == null) return 'N/A';
    return value is bool ? (value ? 'Yes' : 'No') : 'N/A';
  }
}

// Placeholder classes for MentorPage and PlansPage
// You'll need to replace these with your actual implementations

class MentorPage extends StatefulWidget {
  const MentorPage({Key? key}) : super(key: key);

  @override
  _MentorPageState createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> {
  List<dynamic> mentors = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchMentors();
  }

  Future<void> fetchMentors() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? adminId = prefs.getString('user_id');
      String? gymId = prefs.getString('gym_id');
      print(adminId);
      print(gymId);
      if (adminId == null || gymId == null) {
        throw Exception('Admin ID or Gym ID not found in SharedPreferences');
      }

      final response = await http.get(
        Uri.parse('https://gym-management-2.onrender.com/mentors/?admin=$adminId&gym_id=$gymId'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          mentors = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Failed to load mentors');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentors'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : mentors.isEmpty
          ? Center(child: Text('No mentors found'))
          : ListView.builder(
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('${mentor['first_name']} ${mentor['last_name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${mentor['username']}'),
                  Text('Email: ${mentor['email']}'),
                  Text('Phone: ${mentor['phone_number']}'),
                  Text('Expertise: ${mentor['expertise']}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MentorSignInPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00B2B2),
      ),
    );
  }
}


class PlansPage extends StatefulWidget {
  const PlansPage({Key? key}) : super(key: key);

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  List<dynamic> subscriptions = [];
  bool isLoading = true;
  String errorMessage = '';
  String? gymId;
  String? userId;  // To identify admin
  bool isAdmin = false; // To track if the user is admin

  @override
  void initState() {
    super.initState();
    fetchGymIdAndSubscriptions();
  }

  Future<void> fetchGymIdAndSubscriptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user =prefs.getString('user');
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      gymId = prefs.getString('gym_id') ?? 'null';
      userId = prefs.getString('user_id');  // Get user ID for admin check

      if (gymId == null || gymId == 'null') {
        throw Exception('Gym ID not found in SharedPreferences');
      }

      // Check if the user is an admin
      if (user == 'admin') { // Replace with actual admin id check
        isAdmin = true;
      }

      final response = await http.get(
        Uri.parse('https://gym-management-2.onrender.com/subscriptions/?gym_id=$gymId'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            subscriptions = responseData;
            isLoading = false;
          });
        } else if (responseData is Map) {
          setState(() {
            subscriptions = [responseData];
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load subscriptions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }


  void selectPlan(String planId) {
    // Logic for selecting a plan
    print('Selected Plan: $planId');
  }

  void editPlan(String planId) {
    // Logic for editing a plan
    print('Edit Plan: $planId');
  }

  Future<void> deletePlan(String planId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gymId = prefs.getString('gym_id') ?? '';
    String adminId = prefs.getString('user_id') ?? '';
    try {
      final response = await http.delete(
        Uri.parse('https://gym-management-2.onrender.com/subscriptions/'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "admin": adminId, // Send the admin ID
          "gym_id": gymId, // Send the gym ID
        }),
      );

      if (response.statusCode == 204) {
        // Successfully deleted, now remove from local state
        setState(() {
          subscriptions.removeWhere((plan) => plan['id'] == planId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plan deleted successfully')),
        );
      } else {
        throw Exception('Failed to delete plan');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting plan: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : subscriptions.isEmpty
          ? Center(child: Text('No subscriptions found'))
          : ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final subscription = subscriptions[index];

          final planName = subscription['plan_name'] ?? 'No name available';
          final desc = subscription['desc'] ?? 'No description available';
          final price = subscription['price']?.toString() ?? 'No price available';
          final interval = subscription['interval'] ?? 'No interval available';
          final planId = subscription['id'] ?? '';

          return Card(
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      planName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Per $interval',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Description: $desc'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => selectPlan(planId),
                    child: Text('SELECT PLAN'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 45),
                    ),
                  ),
                  if (isAdmin) ...[
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text('EDIT PLAN'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => deletePlan(planId),
                      child: Text('DELETE PLAN'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 45),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPlanPage(gymId: gymId!),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00B2B2),
      ),
    );
  }
}