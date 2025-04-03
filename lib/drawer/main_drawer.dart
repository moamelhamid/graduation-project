import 'package:flutter/material.dart';
import 'package:nahrain_univ/UpdateInfoScreen.dart';
import 'package:nahrain_univ/mapscr.dart';
import 'package:nahrain_univ/si/signin.dart';
import 'about_screen.dart';
import 'lecture_schedule_screen.dart';
import 'package:nahrain_univ/DatabeaseHelper.dart'; // استيراد DatabaseHelper

class AppDrawer extends StatelessWidget {
  final Color nharaincol;
  final bool isSignedIn;
  final String? userName;

  const AppDrawer({
    super.key,
    required this.nharaincol,
    required this.isSignedIn,
    this.userName,
  });

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
          if (isSignedIn && userName != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Welcome $userName',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 27, 80, 141),
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(
              'Profile',
              style: TextStyle(
                color: isSignedIn
                    ? Colors.black
                    : const Color.fromARGB(255, 188, 0, 0).withOpacity(0.45),
              ),
            ),
            onTap: () {
              if (isSignedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const UpdateInfoScreen()),
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
                color: isSignedIn ? Colors.black : const Color.fromARGB(255, 188, 0, 0).withOpacity(0.45),
              ),
            ),
            onTap: () {
              if (isSignedIn) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => LectureScheduleScreen()),
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
          if (isSignedIn)
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                final dbHelper = DatabaseHelper();
                await dbHelper.logout(); // حذف التوكن
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (Route<dynamic> route) => false,
                ); // إغلاق الدرج
              },
            ),
        ],
      ),
    );
  }
}
