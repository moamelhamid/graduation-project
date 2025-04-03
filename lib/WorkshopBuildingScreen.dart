import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WorkshopBuildingScreen extends StatelessWidget {
  final List<String> workshopImages = [
    'assets/workshop1.jpg',
    'assets/workshop2.jpg',
    'assets/workshop3.jpg',
  ]; // صور مبنى الورش

  final String workshopDescription =
      '🔧 يحتوي مبنى الورش الهندسية على مجموعة من الورش المجهزة بالأدوات والتجهيزات الحديثة. '
      'يتم استخدامه في تدريب الطلاب على التطبيقات العملية في الهندسة   .';

  final String workshopLocation = '📍 الموقع: تقع في نصف و الى جانب شارع الهندسة';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مبنى الورش الهندسية'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 سلايدر لعرض صور مبنى الورش
            CarouselSlider(
              items: workshopImages.map((image) {
                return Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    workshopDescription,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    workshopLocation,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
