import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About the Application'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // A calm and visually appealing color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About the App Section
              _sectionHeader(
                title: 'About the App',
                icon: Icons.info_outline,
                color: Colors.teal,
              ),
              const SizedBox(height: 10),
              const Text(
                'The Al-Nahrain University Tour Guide app is built to provide a seamless experience for students and visitors to explore the university campus. With an interactive map, detailed department overviews, and an intuitive interface, it enhances the overall campus navigation.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87, // Use a darker text color for better readability
                ),
              ),
              const SizedBox(height: 20),
              
              // About the Developer Section
              _sectionHeader(
                title: 'About the Developer',
                icon: Icons.person_outline,
                color: Colors.teal,
              ),
              const SizedBox(height: 10),
              const Text(
                'As a passionate mobile app developer with a focus on Flutter and backend development using Laravel, I enjoy building user-friendly and functional applications. This app is part of my ongoing journey to create tools that make a difference in people\'s everyday lives.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Contact Information
              _sectionHeader(
                title: 'Contact Me',
                icon: Icons.mail_outline,
                color: Colors.teal,
              ),
              const SizedBox(height: 10),
              const Text(
                'Feel free to reach out for collaborations or feedback:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              _contactInfoRow(
                icon: Icons.email_outlined,
                contactText: 'moamel1969s@gmail.com',
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              _contactInfoRow(
                icon: Icons.link,
                contactText: 'LinkedIn: linkedin.com/in/moamelabdalnubi',
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              _contactInfoRow(
                icon: Icons.web_outlined,
                contactText: 'GitHub: github.com/moamelhamid',
                color: Colors.blue,
              ),
              const SizedBox(height: 30),
              
              // Footer (Optional)
              Center(
                child: Text(
                  'Built with Flutter',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for Section Headers
  Widget _sectionHeader({required String title, required IconData icon, required Color color}) {
    return Row(
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // Helper method for Contact Information Rows
  Widget _contactInfoRow({required IconData icon, required String contactText, required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            contactText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
