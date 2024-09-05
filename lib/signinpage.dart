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
                          Color(0xffff22D6E0),Color(0xffff79BED6).withOpacity(0.4),
                        ]
                    )
                ),

              ),
              Positioned(
                  top: 60,
                  left: 30,
                  child: Text("    Create Account",style: TextStyle(color: Colors.black,fontSize: 40,fontStyle: FontStyle.italic),)
              ),
              Positioned(
                top: 130,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded,size: 30,),

                        hintText: "First Name",
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
                top: 210,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded,size: 30,),

                        hintText: "Last Name",
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
                top: 290,
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
                top: 370,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,size: 30,),

                        hintText: "Mobile Number",
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
                top: 450,
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
                top: 530,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open,size: 30,),

                        hintText: "Confirm Password",
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
                top: 610,
                left: 35,
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined,size: 30,),

                        hintText: "City",
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
                top: 610,
                left: 240,
                child: SizedBox(
                  width: 170,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.security_outlined,size: 30,),

                        hintText: "Zip Code",
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
                top: 690,
                left: 35,
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,size: 30,),

                        hintText: "Country",
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
                top: 770,
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
