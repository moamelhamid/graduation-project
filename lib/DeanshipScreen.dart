import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DeanshipScreen extends StatelessWidget {
  final List<String> deanshipImages = [
    'assets/den2.jpg',
    'assets/den4.jpg',
    'assets/den5.jpg',
  ]; // صور العمادة

  final String deanshipDescription =
      '🎓 تمثل عمادة كلية الهندسة القلب الإداري والأكاديمي للكلية، حيث تُشرف على جميع الأنشطة الأكاديمية '
      'وتقدم الدعم للطلاب وأعضاء هيئة التدريس، بالإضافة إلى وضع الخطط الاستراتيجية لتطوير التعليم الهندسي.';

  final String deanshipLocation = 'الموقع: في نهاية شارع الهندسة - في مجمع العمادة -يسار المدخل...في الطابق الثاني يوجد الدراسات الاولية والمعاون العلمي و في الطابق الثالث يوجد شعبة المالية و المعاون الاداري  ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عمادة كلية الهندسة'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 صورة العمادة مع الـ Slider
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  items: deanshipImages.map((image) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    '📍 عمادة كلية الهندسة',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // 🔹 وصف العمادة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'حول العمادة',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deanshipDescription,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // 🔹 معلومات الموقع
            const Divider(thickness: 2),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.blue, size: 30),
              title: Text(
                deanshipLocation,
                style: const TextStyle(fontSize: 18),
              ),
            ),

            // 🔹 زر التواصل
            const SizedBox(height: 16),
           
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
