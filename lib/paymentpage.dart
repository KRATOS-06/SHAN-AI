import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late FixedExtentScrollController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Card Holder Name"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("Card Number"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField("Expiry Date"),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Expanded(
                  flex: 1,
                  child: _buildTextField("CVV"),
                ),
              ],
            ),
          ],
        );

      case 1: // UPI Payment
        return _buildTextField("Enter UPI ID");

      case 2: // Net Banking
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("Account Number"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("Branch"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildTextField("IFSC CODE"),
          ],
        );

      default:
        return Container();
    }
  }

  Widget _buildTextField(String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.88,
        child: TextField(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [const Color(0xffff22d6e0), const Color(0xffff79bed6).withOpacity(0.4)]
                    )
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                left: MediaQuery.of(context).size.width * 0.05,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "Choose the Payment Method Below",
                    style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                left: MediaQuery.of(context).size.width * 0.05,
                child: Row(
                  children: [
                    _buildPaymentOption('assets/cards.png', 0),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    _buildPaymentOption('assets/image10.png', 1),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    _buildPaymentOption('assets/image11.png', 2),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.width * 0.05,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.375,
                  child: ListWheelScrollView(
                      itemExtent: MediaQuery.of(context).size.height * 0.125,
                      controller: _controller,
                      squeeze: 0.6,
                      offAxisFraction: -3.5,
                      children: [
                        _buildWheelScrollItem('assets/card2.png'),
                        _buildWheelScrollItem('assets/image10.png'),
                        _buildWheelScrollItem('assets/image11.png'),
                      ]
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.09,
                left: MediaQuery.of(context).size.width * 0.05,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    _textForIndex,
                    style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.075),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.475,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      _buildPaymentDetails(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.075,
                        decoration: BoxDecoration(
                            color: const Color(0xffff066589),
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String assetPath, int index) {
    return GestureDetector(
      onTap: () => _scrollToIndex(index),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.125,
        width: MediaQuery.of(context).size.width * 0.275,
        color: Colors.white.withOpacity(0.6),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildWheelScrollItem(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.125,
        width: MediaQuery.of(context).size.width * 0.275,
        color: Colors.white.withOpacity(0.6),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}