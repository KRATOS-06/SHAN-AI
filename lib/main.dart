import 'package:flutter/material.dart';
import 'package:gym_management/adminsigninpage.dart';
import 'package:gym_management/homepage.dart';
import 'package:gym_management/onboardingpage.dart';
import 'package:gym_management/splashscreen.dart';
import 'package:gym_management/paymentpage.dart';
import 'package:gym_management/profilepage.dart';
import 'package:gym_management/reviewpage2.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool islogin = prefs.getBool('islogin') ?? false;
  runApp(MyApp(islogin: islogin));
}

class MyApp extends StatelessWidget {
  final bool islogin;

  const MyApp({super.key, required this.islogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: islogin ? WorkoutHomePage() : const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}