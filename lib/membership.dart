import 'package:flutter/material.dart';
import 'package:gym_management/paymentpage.dart';

class MembershipPlansScreen extends StatefulWidget {
  const MembershipPlansScreen({super.key});

  @override
  _MembershipPlansScreenState createState() => _MembershipPlansScreenState();
}

class _MembershipPlansScreenState extends State<MembershipPlansScreen> {
  final ScrollController _scrollController = ScrollController();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff00b2b2),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: screenWidth * 0.07,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        backgroundColor: const Color(0xff00b2b2),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.04),
            child: Image.asset(
              'assets/gym_logo.png',
              height: screenHeight * 0.08,
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
  const MembershipPlans({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'PLANS',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.004,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            MembershipCard(
              planType: 'Basic',
              price: '\$100',
              description:
              'Start strong with the essentials, and build your fitness foundation.',
              features: const [
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
              features: const [
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
              features: const [
                'Full gym access',
                'Group classes',
                'Nutrition tips',
                'Extended hours',
              ],
              color1: Colors.lightBlueAccent,
              color2: Colors.blueAccent,
              ribbonColor: Colors.purple,
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ques1.png',
                  height: screenHeight * 0.03,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/save.png',
                  height: screenHeight * 0.025,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
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

  const MembershipCard({super.key, 
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Container(
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(screenWidth * 0.075),
          border: Border.all(
            color: Colors.deepPurpleAccent,
            width: screenWidth * 0.007,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: screenWidth * 0.03,
              offset: Offset(0, screenHeight * 0.005),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planType,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                description,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                price,
                style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              for (String feature in features)
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.025),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: screenHeight * 0.025),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ribbonColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                  ),
                  child: Text(
                    'JOIN NOW',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
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
