import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late FixedExtentScrollController _controller= FixedExtentScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    // Dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.animateToItem(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  String get _textForIndex {
    switch (_selectedIndex) {
      case 0:
        return "Card Payment";
      case 1:
        return "UPI Payment";
      case 2:
        return "Net Banking";
      default:
        return "";
    }
  }
  Widget _buildPaymentDetails() {
    switch (_selectedIndex) {
      case 0: // Card Payment
        return SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    decoration: InputDecoration(
                      hintText: "Card Holder Name",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    decoration: InputDecoration(
                      hintText: "Card Number",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        decoration: InputDecoration(
                          hintText: "Expiry Date",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.4),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.only(left:5),
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                            hintText: "CVV",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.4),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,top: 17),
                child: SizedBox(
                  width:350,
                  child: TextField(
                    style: TextStyle(color: Colors.black,fontSize: 22),
                    decoration: InputDecoration(
                        hintText: "Card Number",
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
            ],
          ),
        );

      case 1: // UPI Payment
        return Padding(
          padding: const EdgeInsets.only(left: 25, top: 100),
          child: SizedBox(
            width: 350,
            child: TextField(
              style: TextStyle(color: Colors.black, fontSize: 22),
              decoration: InputDecoration(
                hintText: "Enter UPI ID",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                filled: true,
                fillColor: Colors.white.withOpacity(0.4),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        );

      case 2: // Net Banking
      // Add fields for Net Banking if needed
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20),
              child: SizedBox(
                width: 350,
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  decoration: InputDecoration(
                    hintText: "Account Number",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25,top: 17),
              child: SizedBox(
                width:350,
                child: TextField(
                  style: TextStyle(color: Colors.black,fontSize: 22),
                  decoration: InputDecoration(
                      hintText: "Branch",
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
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 17),
              child: SizedBox(
                width:350,
                child: TextField(
                  style: TextStyle(color: Colors.black,fontSize: 22),
                  decoration: InputDecoration(
                      hintText: "IFSC CODE",
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
          ],
        );

      default:
        return Container();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [

              Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors: [Color(0xffff22D6E0),Color(0xffff79BED6).withOpacity(0.4)]
                )
              ),
            ),
              Container(
                margin: EdgeInsets.only(top: 180,left: 20),
                height: 100,
                width:double.infinity ,
                color: Colors.transparent,
                child: Text("Choose the Payment Method Below",style:TextStyle(color: Colors.black,fontSize: 20)),
              ),
              Positioned(
                top: 240,
                left: 20,
                child: Row(

                  children: [
                    GestureDetector(
                      onTap:()=> _scrollToIndex(0),
                      child: Container(
                          height: 100,
                          width: 110,
                          color: Colors.white.withOpacity(0.6),
                          child: Image.asset('assets/cards.png',fit: BoxFit.contain,)
                      ),
                    ),

                    GestureDetector(
                      onTap:() => _scrollToIndex(1),
                      child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 100,
                          width: 110,
                          color: Colors.white.withOpacity(0.6),
                          child: Image.asset('assets/image10.png',fit: BoxFit.contain,)
                      ),
                    ),
                    GestureDetector(
                      onTap:() => _scrollToIndex(2),
                      child: Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 100,
                          width: 120,
                          color: Colors.white.withOpacity(0.6),
                          child: Image.asset('assets/image11.png',fit: BoxFit.contain,)
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top:10,
                right: 20,
                child: Container(
                  height: 200,
                  width: 150,
                  child: ListWheelScrollView(itemExtent: 100,
                      controller: _controller,
                      squeeze: 0.6,
                      offAxisFraction: -3.5,
                      children: [ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Container(
                            height: 100,
                            width: 110,
                            color: Colors.white.withOpacity(0.6),
                            child: Image.asset('assets/card2.png',fit: BoxFit.contain,)
                        ),
                      ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Container(
                              height: 100,
                              width: 120,

                              color: Colors.white.withOpacity(0.6),
                              child: Image.asset('assets/image10.png',fit: BoxFit.contain,)
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Container(

                              height: 100,
                              width: 120,
                              color: Colors.white.withOpacity(0.6),
                              child: Image.asset('assets/image11.png',fit: BoxFit.contain,)
                          ),
                        ),

                      ]
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 5000),
                curve: Curves.easeInOut,
                child: Container(
                    margin: EdgeInsets.only(top: 70,left: 20),
                    height: 100,
                    width: 300,
                    child: Text( _textForIndex,style: TextStyle(color: Colors.black,fontSize: 30),)),
              ),
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: Padding(
                  padding: const EdgeInsets.only(top: 380),
                  child: Stack(
                    children: [
                      _buildPaymentDetails(),

                      Padding(
                        padding: const EdgeInsets.only(left:110,top:370),
                        child: Container(
                            width: 200,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffff066589),
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            child: TextButton(onPressed: (){}, child: Text("Pay",style: TextStyle(color: Colors.white,fontSize: 20),))
                        ),
                      ),
                    ],
                  ),
                )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
