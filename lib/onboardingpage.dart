import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gym_management/loginpage.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: screenSize.height * 0.08),
        child: PageView(
          controller: controller,
          children: [
            buildPage(
              context,
              screenSize,
              Lottie.asset('assets/Animation3.json'),
              "Unleash your power \n with our workout plans",
              "Stop into strength and confidence\n Your fitness journey starts here...",
            ),
            buildPage(
              context,
              screenSize,
              Lottie.asset('assets/Animation4.json'),
              "Unleash your power \n with our workout plans",
              "Transform your body and mind \n   step into a healthier stronger\n        you with every workout.",
            ),
            buildFinalPage(
              context,
              screenSize,
              Image.asset('assets/Frame2.png', fit: BoxFit.cover),
              "Unleash your power \n with our workout plans",
              "Sweat, smile, and repeat build the body \n                you’ve always dreamed of.....",
            ),
          ],
        ),
      ),
      bottomSheet: buildBottomSheet(context, screenSize),
    );
  }

  Widget buildPage(BuildContext context, Size screenSize, Widget image, String title, String subtitle) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffff79bed6), Color(0xffff25aee2)],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.55,
            width: double.infinity,
            child: image,
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.06),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.075,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.025),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFinalPage(BuildContext context, Size screenSize, Widget image, String title, String subtitle) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffff79bed6), Color(0xffff25aee2)],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.55,
            width: double.infinity,
            child: image,
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.04),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.075,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.04),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.05,
              ),
            ),
          ),
          Container(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.07,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffff066589),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: FittedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width * 0.07,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context, Size screenSize) {
    return Container(
      height: screenSize.height * 0.08,
      color: const Color(0xffff25aee2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: Text(
                "SKIP",
                style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.045),
              ),
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const WormEffect(
                spacing: 16,
                dotColor: Colors.white,
                activeDotColor: Color(0xffff066589),
              ),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(milliseconds: 500), curve: Curves.easeIn),
            ),
          ),
          FittedBox(
            child: TextButton(
              onPressed: () => controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              child: Text(
                "NEXT",
                style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
