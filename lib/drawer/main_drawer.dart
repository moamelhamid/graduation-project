import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'lecture_schedule_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart'; // Import the Profile screen

class AppDrawer extends StatelessWidget {
  final Color nharaincol;

  const AppDrawer({super.key, required this.nharaincol});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: nharaincol,
            ),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Lecture Schedule'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const LectureScheduleScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const NotificationsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
