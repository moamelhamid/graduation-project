import 'package:flutter/material.dart';

class RegistrationDepartmentScreen extends StatefulWidget {
  @override
  _RegistrationDepartmentScreenState createState() =>
      _RegistrationDepartmentScreenState();
}

class _RegistrationDepartmentScreenState
    extends State<RegistrationDepartmentScreen> {
  final List<String> registrationImages = [
    'assets/den1.jpg',
    'assets/den4.jpg',
    'assets/den3.jpg',
    'assets/den6.jpg',
    'assets/den7.jpg'
  ]; // صور قسم التسجيل

  final String registrationDescription =
      '📋 قسم التسجيل مسؤول عن تسجيل الطلاب الجدد، تقديم الاستفسارات الأكاديمية، وإدارة البيانات الدراسية.';

  final String registrationLocation =
      '📍 الموقع:   في نهاية شارع الهندسة -بداية مجمع العمادة اول بناية على اليمين -الطابق الثاني   .';

  final List<String> instructions = [
    '✅ إحضار نسخة من الأوراق الرسمية عند التسجيل.',
    '✅ التأكد من دفع الرسوم الدراسية قبل الموعد النهائي.',
    '✅ الالتزام بالمواعيد المحددة لتقديم المستندات.',
    '✅ التواصل مع الموظفين للاستفسارات حول الجداول الدراسية.',
    '✅ متابعة البريد الإلكتروني للحصول على تحديثات حول القبول والتسجيل.',
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قسم التسجيل'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 عرض الصور باستخدام PageView
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageController,
                itemCount: registrationImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        registrationImages[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 مؤشر التمرير
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                registrationImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                  width: _currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // 🔹 معلومات القسم
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    registrationDescription,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    registrationLocation,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // 🔹 صندوق التعليمات
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '📌 تعليمات التسجيل:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...instructions.map(
                          (instruction) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              instruction,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
