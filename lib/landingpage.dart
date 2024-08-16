import 'package:flutter/material.dart';
import 'package:gym_management/loginpage.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Container(

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter,

                colors: [Color(0xffff990615),Colors.black]
              )
            ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffff990615))
              ),
              height: 450,
              width: double.infinity,
              child: Image.asset('assets/Frame.png',fit: BoxFit.cover,),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
            child: const Text("    Unleash your power \n with our workout plans",style: TextStyle(color: Colors.white,fontSize: 30),)),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text("Stop into strength and confidence\n Your fitness journey starts here...",style: TextStyle(color: Colors.white,fontSize: 20))
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
               width: 350,
                height: 60,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.yellow,Colors.yellow,Colors.yellow,Colors.white]
                  ),
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: TextButton(onPressed: (){}, child: const Text("GET STARTED",style: TextStyle(color: Colors.black,fontSize: 35),))
            ),
            Container(
                margin: const EdgeInsets.only(top: 40),
                width: 160,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.yellow,Colors.yellow,Colors.yellow,Colors.white]
                    ),
                    borderRadius: BorderRadius.circular(25.0)
                ),
                child: TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                }, child: const Text("LOGIN",style: TextStyle(color: Colors.black,fontSize: 30),))
            )


          ],
        ),
      )
    );
  }
}
