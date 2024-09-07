import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<String> cimages = [
    'assets/Group4.png',
    'assets/Group5.png',
    'assets/Group7.png',
    'assets/Group7.png',
    'assets/Group5.png',
    'assets/Group4.png',
  ];
  List<String> comments = [
    'I ve been loving my experience at this gym! The facilities are top-notch, and the variety of membership plans cater to all needs. The staff is friendly and supportive, making every workout enjoyable. Highly recommend it for anyone looking to start or enhance their fitness journey!',
    'This gym has everything you need to kickstart your fitness journey. The facilities are top-notch, and the staff is always helpful. I love the flexible membership options, especially the Pro plan with 24/7 access. Highly recommend for anyone serious about their health!',
    'Great gym with a welcoming atmosphere! The Lite Membership is perfect for my schedule, and the equipment is well-maintained. The staff is friendly, and the community vibe keeps me motivated. A solid choice for anyone looking to stay fit without breaking the bank!',
    'Great gym with a welcoming atmosphere! The Lite Membership is perfect for my schedule, and the equipment is well-maintained. The staff is friendly, and the community vibe keeps me motivated. A solid choice for anyone looking to stay fit without breaking the bank!',
    'Great gym with a welcoming atmosphere! The Lite Membership is perfect for my schedule, and the equipment is well-maintained. The staff is friendly, and the community vibe keeps me motivated. A solid choice for anyone looking to stay fit without breaking the bank!',
    'This gym has everything you need to kickstart your fitness journey. The facilities are top-notch, and the staff is always helpful. I love the flexible membership options, especially the Pro plan with 24/7 access. Highly recommend for anyone serious about their health!',
  ];
  List<String> rowimages1 = [
    'assets/rimage11.png',
    'assets/rimage12.png',
    'assets/rimage13.png',
    'assets/rimage14.png'
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF00B2B2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.03),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.08,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.black, // Ensure the back button is visible
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/gym_logo.png',
                      height: screenHeight * 0.1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // Title
            Padding(
              padding: EdgeInsets.all(0),
              child: Center(
                child: Text(
                  "Review",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Subtitle
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.08, top: screenHeight * 0.02),
              child: Text(
                "Add your Comments..",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
            // Comment Input Field
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.07),
              child: Column(
                children: [
                  TextField(
                    maxLines: null,
                    minLines: 3,
                    expands: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.055,
                    ),
                    decoration: InputDecoration(
                      hintText: "   Share a moment with us.....",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.05,
                      ),
                      filled: true,
                      fillColor: Color(0xffffD9D9D9),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Image.asset(
                    'assets/image33.png',
                    height: screenHeight * 0.1,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            // Review List
            ListView.builder(
              itemCount: cimages.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.07, vertical: screenHeight * 0.01),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Color(0xffffFFE7E7),
                      borderRadius: BorderRadius.circular(screenWidth * 0.08),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          cimages[index],
                          height: screenHeight * 0.12,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          comments[index],
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: rowimages1.map((image) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: screenWidth * 0.01),
                                child: Image.asset(
                                  image,
                                  height: screenHeight * 0.05,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
