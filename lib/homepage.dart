import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/profilepage.dart';
import 'package:gym_management/reviewpage2.dart';
import 'package:gym_management/shoppage.dart';
import 'package:gym_management/membership.dart';
import 'package:gym_management/contactuspage.dart';
import 'package:gym_management/mentorpage.dart';

class WorkoutHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00B2B2),
        elevation: 0, // Removes the shadow
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/menu_icon.png'), // Menu icon image
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          ),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/gym_logo.png', // Your logo image
            height: 65.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Color(0xFF00B2B2), // Background color
      drawer: _buildDrawer(context), // Add the drawer here
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Reduced spacing here
              Text(
                '   Browse our Workouts to',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Text(
                  'Tune Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              SizedBox(height: 20), // Added spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGradientCircle('assets/circle1.png'),
                  SizedBox(width: 20), // Custom spacing between circles
                  _buildGradientCircle('assets/circle2.png'),
                  SizedBox(width: 20),
                  _buildGradientCircle('assets/circle3.png'),
                ],
              ),
              SizedBox(height: 20),
              _buildWorkoutCard(
                  'Beginner Workout',
                  'Start small, stay consistent, and watch your strength and confidence grow.',
                  'assets/img1.jpg'),
              SizedBox(height: 16),
              _buildWorkoutCard(
                  'Weight Loss',
                  'Fuel your body with intention, move with purpose, and the results will follow.',
                  'assets/img2.jpg'),
              SizedBox(height: 16),
              _buildWorkoutCard(
                  'Muscle Building',
                  'Lift heavy, eat smart, and rest well – the trifecta of muscle growth',
                  'assets/img3.jpg'),
              SizedBox(height: 16),
              _buildWorkoutCard(
                  'Yoga & Flexibility',
                  'Stretch your body, calm your mind, and find balance in every breath',
                  'assets/img4.jpg'),
              SizedBox(height: 16), // Added spacing
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF00B2B2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 0.0), // Space between the title and the logo
                Image.asset(
                  'assets/gym_logo.png', // Your logo image
                  height: 150.0, // Adjust the height of the logo as needed
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to Home
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Plan'),
            onTap: () {
              // Navigate to Plan
              // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MembershipPlansScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Mentors'),
            onTap: () {
              // Navigate to Mentors
              // Close the drawer
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MentorsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              // Navigate to Shop
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShopPage()));
              // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Reviews'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewPage()));
              //Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () {
              // Close the drawer
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsForm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Navigate to Profile
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Logout'),
            onTap: () {
              // Navigate to Login
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGradientCircle(String image) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.pink, Colors.orange, Colors.yellow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          child: Image.asset(image),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],

            // Inner circle color
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String description, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Text content on the left side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text('Join us'),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0), // Space between the text and the image
          // Image on the right side
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'CO-PARTNERS',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 42.0, // Space between logos
            runSpacing: 8.0, // Space between rows if wrapped
            alignment: WrapAlignment.center,
            children: [
              _buildPartnerLogo('assets/logo1.png'),
              _buildPartnerLogo('assets/logo2.png'),
              _buildPartnerLogo('assets/logo3.png'),
              _buildPartnerLogo('assets/logo4.png'),
              _buildPartnerLogo('assets/logo5.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerLogo(String imagePath) {
    return Container(
      width: 80.0, // Reduced size
      height: 80.0, // Reduced size
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
