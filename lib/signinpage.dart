import 'package:flutter/material.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 800,
                width: 500,
                child: Image.asset('assets/image2.png',fit: BoxFit.cover,),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffff79BED6).withOpacity(0.4),Color(0xffff25aee2)
                        ]
                    )
                ),

              ),
              Positioned(
                  top: 180,
                  left: 30,
                  child: Text("Create Your Account",style: TextStyle(color: Colors.white,fontSize: 40,fontStyle: FontStyle.italic),)
              ),
              Positioned(
                top: 300,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded,size: 30,),

                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0)
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 420,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,size: 30,),

                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0)
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 540,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open,size: 30,),

                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0)
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 680,
                left:110,
                child: Container(
                    width: 200,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffff066589),
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    child: TextButton(onPressed: (){}, child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 20),))
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
