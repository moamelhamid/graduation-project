import 'package:flutter/material.dart';

class EngineeringLabsScreen extends StatelessWidget {
  final List<Lab> labs = [
   
    Lab(
      name: 'مختبر الهندسة الطبية',
      image: 'assets/images/comp2.jpg',

      description: 'مختبر مخصص لتطوير الأجهزة الطبية وتحليل الإشارات الحيوية.',
    ),
  
    Lab(
      name: 'مختبر الحاسوب  ',
      image: 'assets/images/comp1.jpg',
      description: 'مختبر يحتوي على أجهزة متطورة لتطوير الخوارزميات والبرمجيات.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مختبرات كلية الهندسة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة
            crossAxisSpacing: 8, // المسافة بين الأعمدة
            mainAxisSpacing: 8, // المسافة بين الصفوف
            childAspectRatio: 1, // نسبة العرض إلى الارتفاع
          ),
          itemCount: labs.length,
          itemBuilder: (context, index) {
            return LabCard(lab: labs[index]);
          },
        ),
      ),
    );
  }
}

// 🔹 ويدجت مخصصة لعرض كل مختبر في شبكة
class LabCard extends StatelessWidget {
  final Lab lab;

  const LabCard({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال إلى شاشة تفاصيل المختبر
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LabDetailsScreen(lab: lab),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  lab.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                lab.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 شاشة تفاصيل المختبر عند النقر عليه
class LabDetailsScreen extends StatelessWidget {
  final Lab lab;

  const LabDetailsScreen({Key? key, required this.lab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lab.name),
      ),
      body: Column(
        children: [
          Image.asset(
            lab.image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              lab.description,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 نموذج بيانات المختبرات
class Lab {
  final String name;
  final String image;
  final String description;

  Lab({required this.name, required this.image, required this.description});
}
