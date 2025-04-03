import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CafeAndLibraryScreen extends StatelessWidget {
  final List<String> cafeImages = [
    'assets/centereng.jpg',
    // 'assets/cafe2.jpg',
    // 'assets/cafe3.jpg',
  ]; // صور الكافيتريا

  final String cafeDescription =
      '☕ كافيتريا كلية الهندسة توفر مجموعة متنوعة من المشروبات والمأكولات الخفيفة للطلاب وأعضاء هيئة التدريس. '
      'تعد مكانًا مثاليًا للاسترخاء والدراسة في جو هادئ ومريح.';

  final String cafeLocation = '📍 الموقع: بالقرب من المدخل الرئيسي لكلية الهندسة.';

  final List<String> libraryImages = [
    'assets/lib1.jpg',
    // 'assets/library2.jpg',
    // 'assets/library3.jpg',
  ]; // صور المكتبة

  final String libraryDescription =
      '📚 مكتبة كلية الهندسة تحتوي على مجموعة واسعة من الكتب والمراجع العلمية في مختلف التخصصات الهندسية. '
      'تعد بيئة مثالية للدراسة والبحث العلمي، حيث توفر أماكن هادئة ومجهزة للطلاب.';

  final String libraryLocation = '📍 الموقع:  بجانب مبنى الكلية الرئيسي.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الكافيتريا والمكتبة'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 قسم الكافيتريا
            const SizedBox(height: 16),
            const Text(
              '🍽️ كافيتريا كلية الهندسة',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CarouselSlider(
              items: cafeImages.map((image) {
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
                    cafeDescription,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cafeLocation,
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

            // 🔹 قسم المكتبة
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            const Text(
              '📖 مكتبة كلية الهندسة',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CarouselSlider(
              items: libraryImages.map((image) {
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
                    libraryDescription,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    libraryLocation,
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
