import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_management/signinpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ischecked=false;
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Frame2Widget - FRAME
    return  Scaffold(
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
                        //Color(0xffffff0586).withOpacity(0.6),Color(0xffffff0586),
                       // Color(0xffff990615).withOpacity(0.8),Colors.black
                        Color(0xffff79BED6).withOpacity(0.4),Color(0xffff25aee2)
                      ]
                    )
                  ),
                  //color: Color(0xffffed13a1).withOpacity(0.7),
                ),
                Positioned(
                    top: 180,
                    left: 145,
                    child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 40,fontStyle: FontStyle.italic),)
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

                          borderSide: BorderSide(width: 100.0,color: Colors.green),
                          borderRadius: BorderRadius.circular(25.0)
                        )
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 410,
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
                  top:530,
                  left: 10,
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(value: ischecked, onChanged: (bool ? value){
                          setState(() {
                            ischecked = value??false;
                          });
                        }),
                      ),
                      Text("keep logged in",style: TextStyle(color: Colors.white,fontSize: 20),),
                      TextButton(
                      onPressed: (){},
                      child: Text("       Forget Password?",style: TextStyle(color: Colors.white,fontSize: 20) ,)),

                    ],
                  ),

                ),
                Positioned(
                  top: 600,
                  left:110,
                  child: Container(
                      width: 200,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffff066589),

                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      child: TextButton(onPressed: (){}, child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20),))
                  ),
                ),
                Positioned(
                  bottom: 120,
                  child: Row(
                    children: [
                      TextButton(onPressed: (){}, child: Text(" Don’t you  have an Account?",style: TextStyle(color: Colors.white,fontSize: 18),)),
                      TextButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> SignInPage()));
                      }, child: Text("           Sign up?",style: TextStyle(color: Colors.white,fontSize: 18),))
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
    );


  }
}