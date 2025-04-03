import 'package:flutter/material.dart';

class ArchitecturalEngineeringScreen extends StatefulWidget {
  @override
  _ArchitecturalEngineeringScreenState createState() =>
      _ArchitecturalEngineeringScreenState();
}

class _ArchitecturalEngineeringScreenState
    extends State<ArchitecturalEngineeringScreen> {
  final List<String> images = [
    'assets/civileng2.jpg',
    // 'assets/arch2.jpg',
    // 'assets/arch3.jpg',
  ]; // صور قسم الهندسة المعمارية

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الهندسة المعمارية'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔹 عرض الصور باستخدام PageView مع إظهار المؤشر
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      images[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // 🔹 مؤشر الصفحة (dots indicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 12 : 8,
                height: currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.blue : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // 🔹 وصف القسم
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🏛️ قسم الهندسة المعمارية',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'قسم الهندسة المعمارية يعنى بتصميم المباني والمساحات الحضرية بشكل يجمع بين الجمالية والوظيفية. '
                  'يهدف إلى تطوير بيئات عمرانية مستدامة تلبي احتياجات المجتمع.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

        
         
        ],
      ),
    );
  }
}
