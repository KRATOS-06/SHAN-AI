import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GymPaymentDetailsPage extends StatefulWidget {
  const GymPaymentDetailsPage({Key? key}) : super(key: key);

  @override
  _GymPaymentDetailsPageState createState() => _GymPaymentDetailsPageState();
}

class _GymPaymentDetailsPageState extends State<GymPaymentDetailsPage> {
  bool isLoading = false;
  String postMessage = '';
  String getMessage = '';
  Map<String, dynamic>? paymentDetails;
  String? gymId;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadGymAndUserId();
   // getGymDetails();
  }

  Future<void> _loadGymAndUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gymId = prefs.getString('gym_id'); // Retrieve gym_id from SharedPreferences
      userId = prefs.getString('user_id'); // Retrieve user_id from SharedPreferences
    });
    getGymDetails();
  }


  Future<void> getGymDetails() async {
    if (gymId == null || userId == null) {
      setState(() {
        getMessage = 'Gym ID or User ID not found';
      });
      return;
    }

    setState(() {
      isLoading = true;
      getMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://gym-management-2.onrender.com/payment/details/?admin=63a2cda7-1455-4939-9f4e-75b15ffc5ebe&gym_id=$gymId'),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          paymentDetails = json.decode(response.body);
          getMessage = 'Payment details retrieved successfully';
        });
      } else {
        setState(() {
          getMessage = 'Failed to retrieve payment details';
        });
      }
    } catch (e) {
      setState(() {
        getMessage = 'Error: $e';
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
        title: const Text('Gym Payment Details'),
        backgroundColor: const Color(0xFF00B2B2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLoading)
              const CircularProgressIndicator()
            else ...[

              const SizedBox(height: 20),
              if (paymentDetails != null) ...[
                Text(
                  'Payment Details:',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Stripe Payment ID: ${paymentDetails!['stripe_payment_id'] ?? 'N/A'}'),
                Text('Amount: \$${paymentDetails!['amount'] ?? 'N/A'}'),
                Text('Status: ${paymentDetails!['status'] ?? 'N/A'}'),
                Text('Created At: ${paymentDetails!['created_at'] ?? 'N/A'}'),
                Text('User: ${paymentDetails!['user'] ?? 'N/A'}'),
                Text('Username: ${paymentDetails!['username'] ?? 'N/A'}'),
                Text('First Name: ${paymentDetails!['first_name'] ?? 'N/A'}'),
                Text('Last Name: ${paymentDetails!['last_name'] ?? 'N/A'}'),
              ] else
                Text(getMessage),
            ],
          ],
        ),
      ),
    );
  }
}
