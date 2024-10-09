import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gym_management/loginpage.dart';
import 'package:gym_management/gym_details_page.dart';

class GymPage extends StatefulWidget {
  const GymPage({super.key});

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  List<dynamic> gymList = [];
  bool isLoading = true;
  String userRole = 'user';
  String gymId = "";

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
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load gyms. Error: ${response.body}')),
        );
      }
    } catch (e) {
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
      userRole = prefs.getString('user') ?? '';
      print(userRole);
      gymId = prefs.getString('gym_id') ?? '';
    });
  }

  Future<void> _deleteGym(String gymId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String adminId = prefs.getString('user_id') ?? '';
    try {
      final response = await http.delete(
        Uri.parse('https://gym-management-2.onrender.com/gyms/$gymId?admin=$adminId'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gym deleted successfully!')),
        );
        _fetchGymList();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete gym: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00B2B2),
        elevation: 0,
        title: Text("GYMS"),
        actions: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.013),
            child: Image.asset(
              'assets/gym_logo.png',
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.08,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF00B2B2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((userRole == 'admin' || userRole == 'mentor') && (gymId == 'null' || gymId == ''))
                    Center(child: _buildAddStoryButton(context, constraints)),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: gymList.length,
                    itemBuilder: (context, index) {
                      final gym = gymList[index];
                      return _buildWorkoutCard(context, gym, constraints);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddStoryButton(BuildContext context, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateGymPage(onGymCreated: _fetchGymList)),
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

  Widget _buildWorkoutCard(BuildContext context, Map<String, dynamic> gym, BoxConstraints constraints) {
    return Padding(
      padding: EdgeInsets.only(top: constraints.maxHeight * 0.01),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gym['gym_name'] ?? 'No Name',
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),

               // if ((userRole == 'admin' || userRole == 'mentor') || (gymId == 'null' || gymId == ''))
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteGym(gym['_id'] ?? '', context),
                  ),
              ],
            ),
            SizedBox(height: constraints.maxHeight * 0.01),
            Text(
              'Email: ${gym['gym_email'] ?? 'No Email'}',
              style: TextStyle(
                fontSize: constraints.maxWidth * 0.04,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.01),
            Text(
              'Phone: ${gym['gym_phone_number'] ?? 'No phone'}',
              style: TextStyle(
                fontSize: constraints.maxWidth * 0.04,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GymDetailsPage(gymDetails: gym),
                      ),
                    );
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
                if ((userRole == 'admin' || userRole == 'mentor') )
                  Padding(
                    padding: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateGymPage(onGymCreated: _fetchGymList, gym: gym)),
                        );
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
                      child: const Text('Edit'),
                    ),
                  ),
              ],
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
          ],
        ),
      ),
    );
  }
}

class CreateGymPage extends StatefulWidget {
  final Function onGymCreated;
  const CreateGymPage({Key? key, required this.onGymCreated}) : super(key: key);

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
      final Map<String, String> gymData = {
        "admin": adminId,
        "gym_name": gymName,
        "gym_email": gymEmail,
        "gym_owner_first_name": ownerFirstName,
        "gym_owner_last_name": ownerLastName,
        "gym_address": gymAddress,
        "gym_phone_number": gymPhoneNumber,
        "promo_code_offers": promoOffers.toString(),
        "promo_code": promoCode
      };

      try {
        final response = await http.post(
          Uri.parse('https://gym-management-2.onrender.com/gyms/'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(gymData),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gym created successfully!')),
          );
          widget.onGymCreated();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()));
        } else {
          print(response.body);
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
        title: Text('Create Gym'),
      ),
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gym name';
                  }
                  return null;
                },
                onSaved: (value) {
                  gymName = value ?? '';
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
                  promoCode = value ?? '';
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

class UpdateGymPage extends StatefulWidget {
  final Function onGymCreated;
  final Map<String, dynamic> gym;
  const UpdateGymPage({Key? key, required this.onGymCreated, required this.gym}) : super(key: key);

  @override
  _UpdateGymPageState createState() => _UpdateGymPageState();
}

class _UpdateGymPageState extends State<UpdateGymPage> {
  final _formKey = GlobalKey<FormState>();
  late String gymName;
  late String gymEmail;
  late String ownerFirstName;
  late String ownerLastName;
  late String gymAddress;
  late String gymPhoneNumber;
  late String promoCode;
  late bool promoOffers;

  @override
  void initState() {
    super.initState();
    gymName = widget.gym['gym_name'] ?? '';
    gymEmail = widget.gym['gym_email'] ?? '';
    ownerFirstName = widget.gym['gym_owner_first_name'] ?? '';
    ownerLastName = widget.gym['gym_owner_last_name'] ?? '';
    gymAddress = widget.gym['gym_address'] ?? '';
    gymPhoneNumber = widget.gym['gym_phone_number'] ?? '';
    promoCode = widget.gym['promo_code'] ?? '';
    promoOffers = widget.gym['promo_code_offers'] == 'true';
  }

  Future<void> _updateGym() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String adminId = prefs.getString('user_id') ?? '';

      final Map<String, String> updatedGymData = {
        "admin": adminId,
        "gym_name": gymName,
        "gym_email": gymEmail,
        "gym_owner_first_name": ownerFirstName,
        "gym_owner_last_name": ownerLastName,
        "gym_address": gymAddress,
        "gym_phone_number": gymPhoneNumber,
        "promo_code_offers": promoOffers.toString(),
        "promo_code": promoCode
      };

      try {
        final response = await http.put(
          Uri.parse('https://gym-management-2.onrender.com/gyms/${widget.gym['_id']}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(updatedGymData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gym updated successfully!')),
          );
          widget.onGymCreated();
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update gym: ${response.body}')),
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
        title: Text('Update Gym'),
      ),
      backgroundColor: const Color(0xFF00B2B2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: gymName,
                decoration: InputDecoration(labelText: 'Gym Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gym name';
                  }
                  return null;
                },
                onSaved: (value) {
                  gymName = value ?? '';
                },
              ),
              TextFormField(
                initialValue: gymEmail,
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
                initialValue: ownerFirstName,
                decoration: InputDecoration(labelText: 'Owner First Name'),
                onSaved: (value) {
                  ownerFirstName = value!;
                },
              ),
              TextFormField(
                initialValue: ownerLastName,
                decoration: InputDecoration(labelText: 'Owner Last Name'),
                onSaved: (value) {
                  ownerLastName = value!;
                },
              ),
              TextFormField(
                initialValue: gymAddress,
                decoration: InputDecoration(labelText: 'Gym Address'),
                onSaved: (value) {
                  gymAddress = value!;
                },
              ),
              TextFormField(
                initialValue: gymPhoneNumber,
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
                initialValue: promoCode,
                decoration: InputDecoration(labelText: 'Promo Code'),
                onSaved: (value) {
                  promoCode = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateGym,
                child: Text('Update Gym'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}