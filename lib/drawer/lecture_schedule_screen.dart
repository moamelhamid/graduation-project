import 'package:flutter/material.dart';

class LectureScheduleScreen extends StatelessWidget {
  const LectureScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Schedule'),
      ),
      body: const Center(
        child: Text('Lecture schedule will be displayed here.'),
      ),
    );
  }
}
