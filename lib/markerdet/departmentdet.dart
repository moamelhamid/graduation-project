import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nahrain_univ/drawer/main_drawer.dart';
import 'package:nahrain_univ/markerdet/department_data.dart';

class DepartmentDetailScreen extends StatefulWidget {
  final Department department;

  const DepartmentDetailScreen({super.key, required this.department});

  @override
  State<StatefulWidget> createState() {
    return _DepartmentDetailScreenState();
  }
}

class _DepartmentDetailScreenState extends State<DepartmentDetailScreen> {
  int _currentIndex = 0; // Variable to store the current index of the carousel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.department.name),
        centerTitle: true, // Center the title for better alignment
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    
      ),
      endDrawer: const AppDrawer(nharaincol: Color.fromARGB(255, 14, 66, 139), isSignedIn: false,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel for images at the top
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20.0), // Rounded corners for the images
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.1,
                          height: 250,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex =
                                  index; // Update current index when the carousel slides
                            });
                          },
                        ),
                        items: widget.department.imagePaths.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      // Dots Indicator placed right below the images
                    ],
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.department.imagePaths.map((imagePaths) {
                int index = widget.department.imagePaths.indexOf(imagePaths);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blueGrey[900] // Active dot color
                        : Colors.grey, // Inactive dot color
                  ),
                );
              }).toList(),
            ),

            // Department Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.department.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            // About Section wrapped in a Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About the Department',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var section in widget.department.fuldescription) ...[
                        const SizedBox(height: 10),
                        Text(
                          section,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Instructions Section wrapped in a Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.blueGrey[50], // Light background for contrast
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instructions:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Please make sure to follow the department rules and guidelines. This helps maintain a healthy learning environment for everyone.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Extra space at the bottom
          ],
        ),
      ),
    );
  }
}
