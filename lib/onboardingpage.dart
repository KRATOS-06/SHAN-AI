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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffff79BED6), Color(0xffff25aee2)])),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          //  border: Border.all(color: const Color(0xffff990615))
                          ),
                      height: 450,
                      width: double.infinity,
                      // child: Image.asset('assets/Frame.png',fit: BoxFit.cover,),
                      child: Lottie.asset('assets/Animation3.json')),
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "    Unleash your power \n with our workout plans",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                          "Stop into strength and confidence\n Your fitness journey starts here...",
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffff79BED6), Color(0xffff25aee2)])),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        //border: Border.all(color: const Color(0xffff990615))
                        ),
                    height: 450,
                    width: double.infinity,
                    child: Lottie.asset('assets/Animation4.json'),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "    Unleash your power \n with our workout plans",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                          " Transform your body and mind \n   step into a healthier stronger\n        you with every workout.",
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffff79BED6), Color(0xffff25aee2)])),
              child: Column(
                children: [
                  Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/Frame2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "    Unleash your power \n with our workout plans",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const Text(
                          "  Sweat, smile, and repeat build the body \n                you’ve always dreamed of.....",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: 350,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffff066589),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            "GET STARTED",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )))
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: Color(0xffff25aee2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Colors.white),
                )),
            Center(
                child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 16,
                dotColor: Colors.white,
                activeDotColor: Color(0xffff066589),
              ),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn),
            )),
            TextButton(
                onPressed: () => controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
