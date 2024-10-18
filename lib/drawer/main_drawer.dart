import 'package:flutter/material.dart';
import 'package:nahrain_univ/si/signin.dart';
import 'about_screen.dart';
import 'lecture_schedule_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
 // Import the Sign-In screen

class AppDrawer extends StatelessWidget {
  final Color nharaincol;
  final bool isSignedIn;

  const AppDrawer({super.key, required this.nharaincol, required this.isSignedIn});

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
            title: Text(
              'Profile',
              style: TextStyle(
                color: isSignedIn ? Colors.black : Colors.blue.withOpacity(0.6),
              ),
            ),
            onTap: () {
              if (isSignedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const ProfileScreen()),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SignInScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(
              'Lecture Schedule',
              style: TextStyle(
                color: isSignedIn ? Colors.black : Colors.blue.withOpacity(0.6),
              ),
            ),
            onTap: () {
              if (isSignedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const LectureScheduleScreen()),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SignInScreen()),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(
              'Notifications',
              style: TextStyle(
                color: isSignedIn ? Colors.black : Colors.blue.withOpacity(0.6),
              ),
            ),
            onTap: () {
              if (isSignedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const NotificationsScreen()),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const SignInScreen()),
                );
              }
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
