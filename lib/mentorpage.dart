import 'package:flutter/material.dart';

class MentorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00B2B2),
        title: Text(
          'Mentors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.07, // Adjusted font size
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/gym_logo.png',
              height: screenHeight * 0.1, // Adjusted height
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF00B2B2),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08, // Adjusted padding
          vertical: screenHeight * 0.02,  // Adjusted padding
        ),
        children: [
          Divider(
            color: Colors.black,
            thickness: 1,
            indent: screenWidth * 0.02, // Adjusted indent
            endIndent: screenWidth * 0.02, // Adjusted end indent
          ),
          MentorCard(
            index: 1,
            name: "Brad Schoenfeld",
            image: "assets/brad_schoenfeld.jpg",
            profession: "Exercise scientist & author.",
            expertise: "Muscle growth and strength training.",
            job: "Professor at Lehman College.",
            research: "300+ studies published.",
            books: "Wrote on muscle hypertrophy.",
            certifications: "Strength coach and trainer.",
          ),
          MentorCard(
            index: 2,
            name: "Matt Roberts",
            image: "assets/matt_roberts.jpg",
            profession: "Celebrity personal trainer and author.",
            expertise: "Fitness and wellness.",
            job: "Trained high-profile celebrities.",
            research: "Authored fitness guides.",
            media: "Regularly appears on TV and in magazines.",
          ),
          MentorCard(
            index: 3,
            name: "Louise Parker",
            image: "assets/louise_parker.jpg",
            profession: "Wellness coach and author.",
            expertise: "Lifestyle transformation.",
            job: "Developed a best-selling wellness program.",
            books: "Published numerous wellness books.",
            certifications: "Certified nutritionist.",
          ),
        ],
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final String profession;
  final String expertise;
  final String job;
  final String research;
  final String books;
  final String certifications;
  final String media;

  MentorCard({
    required this.index,
    required this.name,
    required this.image,
    required this.profession,
    required this.expertise,
    required this.job,
    this.research = '',
    this.books = '',
    this.certifications = '',
    this.media = '',
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Adjusted margin
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // Adjusted padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.4, // Adjusted width
              height: screenHeight * 0.55, // Adjusted height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03), // Adjusted spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$index. $name',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // Adjusted font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  _buildProfileText('Profession', profession, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  _buildProfileText('Expertise', expertise, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  _buildProfileText('Job', job, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  if (research.isNotEmpty)
                    _buildProfileText('Research', research, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  if (books.isNotEmpty)
                    _buildProfileText('Books', books, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  if (certifications.isNotEmpty)
                    _buildProfileText('Certifications', certifications, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  if (media.isNotEmpty)
                    _buildProfileText('Media', media, screenWidth),
                  SizedBox(height: screenHeight * 0.005), // Adjusted spacing
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor:Colors.lightBlueAccent,// Removes shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03, // Adjusted padding
                          vertical: screenHeight * 0.01, // Adjusted padding
                        ),
                      ),
                      onPressed: () {
                        // Add functionality for the "Appoint as a Mentor" button
                      },
                      child: Text(
                        'Appoint as a Mentor',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03, // Adjusted font size
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileText(String title, String content, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.01), // Adjusted padding
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenWidth * 0.045, // Adjusted font size
              ),
            ),
            TextSpan(
              text: content,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04, // Adjusted font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
