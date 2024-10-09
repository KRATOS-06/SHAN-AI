import 'package:flutter/material.dart';
import 'package:gym_management/paymentpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_management/mentorsigninpage.dart';
import 'package:gym_management/newPlanPage.dart';
import 'package:gym_management/editPlanPage.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
                              builder: (context) => PlansPage(GymId:gymDetails['id'].toString()),
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
  void _editMentor(dynamic mentor) {
    // TODO: Implement edit functionality
    print('Editing mentor: ${mentor['first_name']} ${mentor['last_name']}');
  }

  Future<void> _deleteMentor(dynamic mentor) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? adminId = prefs.getString('user_id');
      String? mentorId = mentor['id'];

      if (adminId == null) {
        throw Exception('Admin ID not found in SharedPreferences');
      }

      final response = await http.delete(
        Uri.parse(
            'https://gym-management-2.onrender.com/mentors/?admin=$adminId&mentor_id=$mentorId'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 204) {
        // Mentor deleted successfully
        setState(() {
          mentors.removeWhere((m) => m['id'] == mentorId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mentor deleted successfully')),
        );
      } else {
        print(mentorId);
        throw Exception('Failed to delete mentor: ${response.body}');
      }
    } catch (e) {
      print('Error deleting mentor: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete mentor: $e')),
      );
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editMentor(mentor),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMentor(mentor),
                  ),
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
            MaterialPageRoute(builder: (context) => MentorSignInPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00B2B2),
      ),
    );
  }
}
class PaymentService {
  final String baseUrl = 'https://gym-management-2.onrender.com/payment/';

  Future<Map<String, dynamic>> makePayment({
    required String username,
    required String firstName,
    required String lastName,
    required String gymId,
    required String productType,
    required String stripePriceId,
    required String userId,
    required String promoCode,
    required String productId,
    required String address,
    required String phoneNumber,
    required String country,
    required String pinCode,
    required String paymentType,
  }) async {
    try {
      final url = Uri.parse(baseUrl);
      final headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'gym_id': gymId,
        'product_type': productType,
        'stripe_price_id': stripePriceId,
        'user_id': userId,
        'promo_code': promoCode,
        'product_id': productId,
        'address': address,
        'phone_number': phoneNumber,
        'country': country,
        'pin_code': pinCode,
        'payment_type': paymentType,
      });

      final response = await http.post(url, headers: headers, body: body);
      print('Request Body: $body'); // Log request body
      print('Response Body: ${response.body}'); // Log response body
      print('Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print(data);
        return data;
      } else {
        return {'error': 'Failed to process payment. Please try again.'};
      }
    } catch (e) {
      return {'error': 'An error occurred: $e'};
    }
  }
}


class PlansPage extends StatefulWidget {
  final String GymId;
  const PlansPage({Key? key, required this.GymId}) : super(key: key);

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  List<dynamic> subscriptions = [];
  bool isLoading = true;
  String errorMessage = '';
  String gymId = '';
  String? userId;  // To identify admin
  bool isAdmin = false; // To track if the user is admin
  String userRole = 'user'; // Default role
  String firstName = '';
  String lastName = '';
  String username = '';
  String phoneNumber = '';
  String country = '';
  String address = '';
  String pincode = '';
  final PaymentService _paymentService = PaymentService();
  String responseMessage = '';
  String sessionUrl = '';

  @override
  void initState() {
    super.initState();
    gymId = widget.GymId;
    fetchGymIdAndSubscriptions();
    loadUserDetails();
    _loadUserRole();
  }

  Future<void> loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('name') ?? '';
      lastName = prefs.getString('last_name') ?? '';
      username = prefs.getString('name') ?? '';
      phoneNumber = prefs.getString('phone') ?? '';
      country = prefs.getString('country') ?? '';
      address = prefs.getString('address') ?? '';
      pincode = prefs.getString('pincode') ?? '';
      userRole = prefs.getString('user') ?? 'user';
      isLoading = false; // Once user details are loaded
    });
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user') ?? 'user';
      isAdmin = userRole == 'admin';
    });
  }

  Future<void> fetchGymIdAndSubscriptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      userId = prefs.getString('user_id');  // Get user ID for admin check
      if (gymId == null || gymId == 'null') {
        throw Exception('Gym ID not found in SharedPreferences');
      }

      // Check if the user is an admin
      if (prefs.getString('user') == 'admin') {
        isAdmin = true;
      }

      final response = await http.get(
        Uri.parse('https://gym-management-2.onrender.com/subscriptions/?admin=$userId&gym_id=$gymId'),
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

  Future<void> processPayment(String planId, String priceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _paymentService.makePayment(
        username: username,
        firstName: firstName,
        lastName: lastName,
        gymId: gymId,
        productType: 'subscription',
        stripePriceId: priceId,
        userId: prefs.getString('user_id') ?? '',
        promoCode: "12345", // Update promo code if needed
        productId: planId,
        address: address,
        phoneNumber: phoneNumber,
        country: country,
        pinCode: pincode,
        paymentType: "card", // Placeholder for payment method
      );

      setState(() {
        isLoading = false;

        if (response.containsKey('error')) {
          responseMessage = response['error'];
        } else if (response['sessionUrl'] != null) {
          sessionUrl = response['sessionUrl'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentWebViewPage(sessionUrl: sessionUrl),
            ),
          );
        } else {
          responseMessage = 'Payment failed. No session URL found.';
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        responseMessage = 'An error occurred: $e';
      });
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
          final priceId = subscription['stripe_price_id'];

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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(planId:planId,priceId:priceId,type:"subscription",gymId: gymId,),
                        ),
                      );
                    },
                    child: Text('SELECT PLAN'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 45),
                    ),
                  ),
                  if (isAdmin) ...[
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Logic to edit plan
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
    );
  }
}

class PaymentWebViewPage extends StatelessWidget {
  final String sessionUrl;

  const PaymentWebViewPage({Key? key, required this.sessionUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Payment'),
      ),
      body: WebView(
        initialUrl: sessionUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
