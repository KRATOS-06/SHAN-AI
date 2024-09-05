import 'package:flutter/material.dart';

class MentorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00B2B2),
        title: Text(
          'Mentors',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/gym_logo.png',
              height: 65.0,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF00B2B2),
      body: ListView(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
        children: [
          Divider(
            color: Colors.black, // Color of the line
            thickness: 1, // Thickness of the line
            indent: 10, // Left padding
            endIndent: 10, // Right padding
          ),
          MentorCard(
            index: 1,
            name: "Brad Schoenfeld",
            image: "assets/brad_schoenfeld.jpg",
            // Replace with the actual image path
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
            // Replace with the actual image path
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
            // Replace with the actual image path
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image), // Ensure the image path is correct
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$index. $name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildProfileText('Profession', profession),
                  SizedBox(height: 8),
                  _buildProfileText('Expertise', expertise),
                  SizedBox(height: 8),
                  _buildProfileText('Job', job),
                  SizedBox(height: 8),
                  if (research.isNotEmpty)
                    _buildProfileText('Research', research),
                  SizedBox(height: 8),
                  if (books.isNotEmpty) _buildProfileText('Books', books),
                  SizedBox(height: 8),
                  if (certifications.isNotEmpty)
                    _buildProfileText('Certifications', certifications),
                  SizedBox(height: 8),
                  if (media.isNotEmpty) _buildProfileText('Media', media),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent, // Removes shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Ensures rounded corners
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      ),
                      onPressed: () {
                        // Add functionality for the "Appoint as a Mentor" button
                      },
                      child: Text(
                        'Appoint as a Mentor',
                        style: TextStyle(fontSize: 10.0, color: Colors.black),
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

  Widget _buildProfileText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            TextSpan(
              text: content,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
