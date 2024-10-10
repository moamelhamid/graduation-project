// departments_list.dart
import 'package:flutter/material.dart';
import 'package:nahrain_univ/about_screen.dart';
import 'package:nahrain_univ/markerdet/department_data.dart';
import 'package:nahrain_univ/markerdet/departmentdet.dart'; // For the detail screen

class DepartmentsListScreen extends StatelessWidget {
  const DepartmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineering Departments'),
        actions: [IconButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx)=>const AboutScreen())
          );
        }, icon: const Icon(Icons.menu))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: departments.length, // Use the department list from department_detail.dart
          itemBuilder: (context, index) {
            final department = departments[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // Image of the department
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      department.imagePaths[0], // Use the first image for the department
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      department.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text("${department.description.substring(0, 60)}...",
                    style: const TextStyle(fontSize: 17),
                    ), // Show a short part of the description
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DepartmentDetailScreen(
                            department: department, // Pass the full department object
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
