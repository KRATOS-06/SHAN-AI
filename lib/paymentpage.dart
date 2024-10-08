import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  final String planId;
  final String priceId;
  final String type;
  final String gymId;

  const PaymentPage({
    super.key,
    required this.planId,
    required this.priceId,
    required this.type,
    required this.gymId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late FixedExtentScrollController _controller;
  int _selectedIndex = 0;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String country = "";
  String address = "";
  String pinCode = "";
  bool isLoading = false;
  String responseMessage = "";
  String sessionUrl = "";

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
    loadUserDetails();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.animateToItem(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String get _textForIndex {
    switch (_selectedIndex) {
      case 0:
        return "Card Payment";
      case 1:
        return "UPI Payment";
      case 2:
        return "Net Banking";
      default:
        return "";
    }
  }

  Widget _buildPaymentDetails() {
    switch (_selectedIndex) {
      case 0: // Card Payment
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                "First name",
                _firstNameController,
                    (value) => value!.isEmpty ? 'First name is required' : null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTextField(
                "Last name",
                _lastNameController,
                    (value) => value!.isEmpty ? 'Last name is required' : null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTextField(
                "Phone number",
                _phoneNumberController,
                    (value) => value!.isEmpty ? 'Phone number is required' : null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTextField(
                "Address",
                _addressController,
                    (value) => value!.isEmpty ? 'Address is required' : null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTextField(
                "Country",
                _countryController,
                    (value) => value!.isEmpty ? 'Country is required' : null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildTextField(
                "Pin Code",
                _pinCodeController,
                    (value) => value!.isEmpty ? 'Pin Code is required' : null,
              ),

            ],
          ),
        );

      case 1: // UPI Payment
        return _buildTextField(
          "Enter UPI ID",
          null,
              (value) {
            if (value!.isEmpty) return 'UPI ID is required';
            if (!RegExp(r'^\w+@\w+$').hasMatch(value)) return 'Invalid UPI ID';
            return null;
          },
        );

      case 2: // Net Banking
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", null, null),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("Account Number", null, null),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("Branch", null, null),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("IFSC CODE", null, null),
          ],
        );

      default:
        return Container();
    }
  }

  Widget _buildTextField(String hintText, TextEditingController? controller, String? Function(String?)? validator) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.88,
        child: TextFormField(
          controller: controller,
          validator: validator,
          style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.05),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.width * 0.045),
            filled: true,
            fillColor: Colors.white.withOpacity(0.4),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? '';
      firstName = prefs.getString('first_name') ?? '';
      lastName = prefs.getString('last_name') ?? '';
      phoneNumber = prefs.getString('phone') ?? '';
      country = prefs.getString('country') ?? '';
      address = prefs.getString('address') ?? '';
      pinCode = prefs.getString('pin_code') ?? '';

      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _phoneNumberController.text = phoneNumber;
      _countryController.text = country;
      _addressController.text = address;
      _pinCodeController.text = pinCode;
    });
  }

  Future<void> processPayment(String planId, String priceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final response = await PaymentService().makePayment(
        username: userName,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        gymId: widget.gymId,
        productType: widget.type,
        stripePriceId: widget.priceId,
        userId: prefs.getString('user_id') ?? '',
        promoCode: "12345", // Update promo code if needed
        productId: planId,
        address: _addressController.text,
        phoneNumber: _phoneNumberController.text,
        country: _countryController.text,
        pinCode: _pinCodeController.text,
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
      backgroundColor: const Color(0xFF00B2B2),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0), // Add padding to prevent overflow
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // Gradient Background
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        "Payment Page",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        _textForIndex,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListWheelScrollViewX(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          controller: _controller,
                          itemExtent: MediaQuery.of(context).size.width * 0.35,
                          onSelectedItemChanged: (index) {
                            _scrollToIndex(index, context);
                          },
                          children: [
                            _buildPaymentOption('assets/cards.png', 0),
                            _buildPaymentOption('assets/image10.png', 1),
                            _buildPaymentOption('assets/image11.png', 2),
                          ],
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      _buildPaymentDetails(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          print(widget.planId);
                          print(widget.priceId);
                          processPayment(widget.planId, widget.priceId);
                        },
                        child: const Text("Proceed"),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      if (responseMessage.isNotEmpty)
                        Text(
                          responseMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String imagePath, int index) {
    return GestureDetector(
      onTap: () => _scrollToIndex(index, context),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            index == 0 ? 'Card' : index == 1 ? 'UPI' : 'Net Banking',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentWebViewPage extends StatelessWidget {
  final String sessionUrl;

  const PaymentWebViewPage({super.key, required this.sessionUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebView(
        initialUrl: sessionUrl,
        javascriptMode: JavascriptMode.unrestricted,
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
