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
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/menu_icon.png'),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/gym_logo.png',
            height: 65.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Color(0xFF00B2B2),
      drawer: _buildDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Center(
                    child: Text(
                      'Browse our Workouts to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Tune Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: constraints.maxWidth * 0.07,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildResponsiveCircle('assets/circle1.png', constraints),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      _buildResponsiveCircle('assets/circle2.png', constraints),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      _buildResponsiveCircle('assets/circle3.png', constraints),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildWorkoutCard(
                      'Beginner Workout',
                      'Start small, stay consistent, and watch your strength and confidence grow.',
                      'assets/img1.jpg',
                      constraints),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildWorkoutCard(
                      'Weight Loss',
                      'Fuel your body with intention, move with purpose, and the results will follow.',
                      'assets/img2.jpg',
                      constraints),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildWorkoutCard(
                      'Muscle Building',
                      'Lift heavy, eat smart, and rest well – the trifecta of muscle growth',
                      'assets/img3.jpg',
                      constraints),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildWorkoutCard(
                      'Yoga & Flexibility',
                      'Stretch your body, calm your mind, and find balance in every breath',
                      'assets/img4.jpg',
                      constraints),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  _buildFooter(constraints),
                ],
              ),
            ),
          );
        },
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
                SizedBox(height: 0.0),
                Image.asset(
                  'assets/gym_logo.png',
                  height: 150.0,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Plan'),
            onTap: () {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MentorsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShopPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Reviews'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsForm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveCircle(String image, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.25,
      height: constraints.maxWidth * 0.25,
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
          width: constraints.maxWidth * 0.2,
          height: constraints.maxWidth * 0.2,
          child: Image.asset(image),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String description, String imageUrl, BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(constraints.maxWidth * 0.04),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.04,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.01,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                  ),
                  child: Text('Join us'),
                ),
              ],
            ),
          ),
          SizedBox(width: constraints.maxWidth * 0.04),
          Container(
            width: constraints.maxWidth * 0.3,
            height: constraints.maxWidth * 0.3,
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

  Widget _buildFooter(BoxConstraints constraints) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
        child: Column(
          children: [
            Text(
              'CO-PARTNERS',
              style: TextStyle(
                fontSize: constraints.maxWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            Wrap(
              spacing: constraints.maxWidth * 0.05,
              runSpacing: constraints.maxHeight * 0.01,
              alignment: WrapAlignment.center,
              children: [
                _buildPartnerLogo('assets/logo1.png', constraints),
                _buildPartnerLogo('assets/logo2.png', constraints),
                _buildPartnerLogo('assets/logo3.png', constraints),
                _buildPartnerLogo('assets/logo4.png', constraints),
                _buildPartnerLogo('assets/logo5.png', constraints),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerLogo(String imagePath, BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.2,
      height: constraints.maxWidth * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
