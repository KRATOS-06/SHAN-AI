import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_management/profilepage.dart';
import 'package:gym_management/reviewpage2.dart';
import 'package:gym_management/shoppage.dart';
import 'package:gym_management/membership.dart';
import 'package:gym_management/contactuspage.dart';
import 'package:gym_management/mentorpage.dart';
import 'package:gym_management/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Event {
  final String name;
  final String date;
  final String timing;
  final String location;
  final String description;
  final String guestName;
  final String gymId;
  final String adminId;

  Event({
    required this.name,
    required this.date,
    required this.timing,
    required this.location,
    required this.description,
    required this.guestName,
    required this.gymId,
    required this.adminId,
  });
}


Future<void> _logout(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear all relevant user data
    await prefs.clear(); // Clears all stored data in SharedPreferences
    print("User has been logged out");

    // Navigate to LoginPage after clearing data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully logged out')),
    );
  } catch (error) {
    // Handle any errors during logout
    print('Error during logout: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed. Please try again.')),
    );
  }
}

class WorkoutHomePage extends StatefulWidget {
  @override
  _WorkoutHomePageState createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  List<Event> events = [
    Event(
      name: "Yoga Workshop",
      date: "2024-09-20",
      timing: "10:00 AM - 12:00 PM",
      location: "Main Gym Hall",
      description: "Join us for a relaxing yoga session led by expert instructors.",
      guestName: "Sarah Johnson",
      gymId: "123e4567-e89b-12d3-a456-426614174000",
      adminId: "98765432-e89b-12d3-a456-426614174000",
    ),
    // Add more events as needed
  ];
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
                  _buildEventStories(constraints),
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
              _logout(context);
            },
          ),
        ],
      ),
    );

  }

  Widget _buildEventStories(BoxConstraints constraints) {
    return Container(
      height: constraints.maxWidth * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length + 1,  // +1 for the add button
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStoryButton(constraints);
          } else {
            return _buildStoryCircle(events[index - 1], constraints);
          }
        },
      ),
    );
  }

  Widget _buildAddStoryButton(BoxConstraints constraints) {
    return GestureDetector(
      onTap: _addNewEvent,
      child: Container(
        width: constraints.maxWidth * 0.25,
        height: constraints.maxWidth * 0.25,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Icon(Icons.add, size: constraints.maxWidth * 0.1),
      ),
    );
  }

  Widget _buildStoryCircle(Event event, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () => _showEventDetails(event),
      child: Container(
        width: constraints.maxWidth * 0.25,
        height: constraints.maxWidth * 0.25,
        margin: EdgeInsets.only(right: 10),
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
            width: constraints.maxWidth * 0.22,
            height: constraints.maxWidth * 0.22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                event.name.substring(0, 2).toUpperCase(),
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String description, String imageUrl,
      BoxConstraints constraints) {
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
  void _addNewEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(
          onEventAdded: (Event newEvent) {
            setState(() {
              events.add(newEvent);
            });
          },
        ),
      ),
    );
  }

  void _showEventDetails(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(event: event),
      ),
    );
  }
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



class AddEventPage extends StatefulWidget {
  final Function(Event) onEventAdded;

  AddEventPage({required this.onEventAdded});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String date = '';
  String timing = '';
  String location = '';
  String description = '';
  String guestName = '';
  String gymId = '';
  String adminId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date';
                  }
                  return null;
                },
                onSaved: (value) => date = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Timing'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter timing';
                  }
                  return null;
                },
                onSaved: (value) => timing = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
                onSaved: (value) => location = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Guest Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter guest name';
                  }
                  return null;
                },
                onSaved: (value) => guestName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gym ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gym ID';
                  }
                  return null;
                },
                onSaved: (value) => gymId = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Admin ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admin ID';
                  }
                  return null;
                },
                onSaved: (value) => adminId = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add Event'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newEvent = Event(
                      name: name,
                      date: date,
                      timing: timing,
                      location: location,
                      description: description,
                      guestName: guestName,
                      gymId: gymId,
                      adminId: adminId,
                    );
                    widget.onEventAdded(newEvent);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        backgroundColor: Color(0xFF00B2B2),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${event.date}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Time: ${event.timing}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Location: ${event.location}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text('Description:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(event.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Guest: ${event.guestName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Gym ID: ${event.gymId}', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text('Admin ID: ${event.adminId}', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}