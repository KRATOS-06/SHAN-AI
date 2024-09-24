import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gym_management/loginpage.dart';
class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  List<dynamic> gymList = [];
  bool isLoading = true;
  String userRole = 'user';
  String gymId="";
  @override
  void initState() {
    super.initState();
    _loadUserRole();
    _fetchGymList();
  }

  Future<void> _fetchGymList() async {
    try {
      final response = await http.get(Uri.parse('https://gym-management-2.onrender.com/gyms/'));

      if (response.statusCode == 200) {
        setState(() {
          gymList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        // Error response
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load gyms. Error: ${response.body}')),
        );
      }
    } catch (e) {
      // Handle any errors
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while fetching data: $e')),
      );
    }
  }
  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('user') ?? 'user';
      gymId=prefs.getString('gym_id') ??'null';
      print(gymId);
      print(userRole);
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF00B2B2),
          elevation: 0,
          title: Text("GYMS"),
          actions: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.013),
              child: Image.asset(
                'assets/gym_logo.png',
                width: screenWidth * 0.2,
                height: screenHeight * 0.08,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00B2B2),
        body:LayoutBuilder(
            builder: (context, constraints){
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: constraints.maxHeight * 0.02),

                      if ((userRole == 'admin' || userRole == 'mentor') && (gymId=='null' || gymId==''))
                        Center(child: _buildAddStoryButton(context,constraints)),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                        shrinkWrap: true, // To avoid unbounded height errors inside SingleChildScrollView
                        physics: NeverScrollableScrollPhysics(), // To prevent scrolling conflicts with SingleChildScrollView
                        itemCount: gymList.length,
                        itemBuilder: (context, index) {
                          final gym = gymList[index];
                          return _buildWorkoutCard(
                              gym['gym_name'],              // Pass gym name
                              gym['gym_email'],             // Pass gym email
                              gym['gym_phone_number'] ?? 'No phone',constraints // Pass phone number or default value
                          );
                        },
                      ),



                    ],
                  ),
                ),
              );
            }
        )

    );
  }
}
Widget _buildWorkoutCard(String gymName, String gymEmail, String gymPhone, BoxConstraints constraints) {
  return Padding(
    padding:  EdgeInsets.only(top:constraints.maxHeight * 0.01),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(constraints.maxWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gymName, // Display gym name
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          Text(
            'Email: $gymEmail', // Display gym email
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.04,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          Text(
            'Phone: $gymPhone', // Display gym phone
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.04,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          ElevatedButton(
            onPressed: () {
              // Action for "Join us"
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.01,
                horizontal: constraints.maxWidth * 0.05,
              ),
            ),
            child: const Text('Join us'),
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
        ],
      ),

    ),
  );

}

Widget _buildAddStoryButton(BuildContext context,BoxConstraints constraints) {
  return GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateGymPage()),
      );
    },
    child: Container(
      width: constraints.maxWidth * 0.25,
      height: constraints.maxWidth * 0.25,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: Icon(Icons.add, size: constraints.maxWidth * 0.1),
    ),
  );
}
class CreateGymPage extends StatefulWidget {
  const CreateGymPage({Key? key}) : super(key: key);

  @override
  _CreateGymPageState createState() => _CreateGymPageState();
}

class _CreateGymPageState extends State<CreateGymPage> {
  final _formKey = GlobalKey<FormState>();
  String gymName = '';
  String gymEmail = '';
  String ownerFirstName = '';
  String ownerLastName = '';
  String gymAddress = '';
  String gymPhoneNumber = '';
  String promoCode = '';
  bool promoOffers = false;

  Future<void> _submitGymForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String adminId = prefs.getString('user_id') ?? 'default-admin-id';
      print(adminId);
      final Map<String, String> gymData = {
        "admin": adminId,
        "gym_name": gymName,
        "gym_email": gymEmail,
        "gym_owner_first_name": ownerFirstName,
        "gym_owner_last_name": ownerLastName,
        "gym_address": gymAddress,
        "gym_phone_number": gymPhoneNumber,
        "promo_code_offers": "true",
        "promo_code": "string"
      };

      try {
        // Log the request data to inspect
        print("Gym Data: ${json.encode(gymData)}");

        final response = await http.post(
          Uri.parse('https://gym-management-2.onrender.com/gyms/'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(gymData),
        );

        // Log the response for debugging
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gym created successfully!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          // Navigator.pop(context); // Close the form and return to the main page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create gym: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
        print(e);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF00B2B2),
          title: Text('Create Gym')),
      backgroundColor: const Color(0xFF00B2B2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Gym Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a gym name';
                  }
                  return null;
                },
                onSaved: (value) {
                  gymName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gym Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  gymEmail = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner First Name'),
                onSaved: (value) {
                  ownerFirstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Last Name'),
                onSaved: (value) {
                  ownerLastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gym Address'),
                onSaved: (value) {
                  gymAddress = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gym Phone Number'),
                onSaved: (value) {
                  gymPhoneNumber = value!;
                },
              ),
              SwitchListTile(
                title: Text('Promo Code Offers'),
                value: promoOffers,
                onChanged: (value) {
                  setState(() {
                    promoOffers = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Promo Code'),
                onSaved: (value) {
                  promoCode = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitGymForm,
                child: Text('Create Gym'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}