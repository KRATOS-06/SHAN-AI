import 'package:flutter/material.dart';
import 'package:gym_management/paymentpage.dart';

class MembershipPlansScreen extends StatefulWidget {
  @override
  _MembershipPlansScreenState createState() => _MembershipPlansScreenState();
}

class _MembershipPlansScreenState extends State<MembershipPlansScreen> {
  ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        setState(() {
          _isScrolled = true;
        });
      } else {
        setState(() {
          _isScrolled = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00b2b2),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black, // Ensure the back button is visible
        ),
        backgroundColor: Color(0xff00b2b2),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/gym_logo.png',
              // Adjust the path to where you save your image
              height: 120, // Adjust the height as per your need
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: MembershipPlans(),
        ),
      ),
    );
  }
}

class MembershipPlans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MEMBERSHIP',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'PLANS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  width: 200, // Width of the underline
                  child: Container(
                    height: 3,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            MembershipCard(
              planType: 'Basic',
              price: '\$100',
              description:
                  'Start strong with the essentials, and build your fitness foundation.',
              features: [
                'Essential gym access',
                'Personalized workout routine',
                'Flexible timings',
                'Locker facilities',
              ],
              color1: Colors.white,
              color2: Colors.purpleAccent,
              ribbonColor: Colors.purple,
            ),
            MembershipCard(
              planType: 'Premium',
              price: '\$950',
              description:
                  'Push beyond your limits, and achieve elite-level results.',
              features: [
                '24/7 Premium access',
                'Personal training',
                'Advanced nutrition',
                'All locker rooms',
              ],
              color1: Colors.orangeAccent,
              color2: Colors.yellowAccent,
              ribbonColor: Colors.orange,
            ),
            MembershipCard(
              planType: 'Lite',
              price: '\$500',
              description:
                  'Challenge yourself to grow, and elevate your workout routine.',
              features: [
                'Full gym access',
                'Group classes',
                'Nutrition tips',
                'Extended hours',
              ],
              color1: Colors.lightBlueAccent,
              color2: Colors.blueAccent,
              ribbonColor: Colors.purple,
            ),
            SizedBox(height: 20),

            // Image and text for 'Terms & Conditions'
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ques1.png', // Make sure the image path is correct
                  height: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Image and text for 'Privacy Policy'
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/save.png', // Use the newly uploaded image
                  height: 20, // Set the height of the image to 20
                ),
                SizedBox(width: 8),
                Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  final String planType;
  final String price;
  final String description;
  final List<String> features;
  final Color color1;
  final Color color2;
  final Color ribbonColor;

  MembershipCard({
    required this.planType,
    required this.price,
    required this.description,
    required this.features,
    required this.color1,
    required this.color2,
    required this.ribbonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planType,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              Text(
                price,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              for (String feature in features)
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.black),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PaymentPage()));
                  },
                  child: Text('JOIN NOW'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ribbonColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
