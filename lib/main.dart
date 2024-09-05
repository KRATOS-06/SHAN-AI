import 'package:flutter/material.dart';
import 'package:gym_management/homepage.dart';
import 'package:gym_management/onboardingpage.dart';
import 'package:gym_management/splashscreen.dart';
import 'package:gym_management/paymentpage.dart';
import 'package:gym_management/profilepage.dart';
import 'package:gym_management/reviewpage2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
