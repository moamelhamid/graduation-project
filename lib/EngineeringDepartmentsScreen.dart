import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EngineeringDepartmentsScreen extends StatelessWidget {
  final List<String> mainBuildingImages = [
    'assets/hall.jpg',
    'assets/hall2.jpg',
    'assets/hall3.jpg',
  ]; // صور متعددة للمبنى الرئيسي

  final String mainBuildingDescription =
      'المبنى الرئيسي لكلية الهندسة يضم العديد من القاعات الدراسية والمختبرات الحديثة. '
      'يمكنك التنقل داخله للوصول إلى مختلف الأقسام الهندسية.';

  final List<Department> departments = [
     Department(
      name: ' هندسة الحاسوب ',
      images: [ 'assets/comp2.jpg', 'assets/comp3.jpg'],
      description: 'تصميم وتطوير انظمة الحاسوب ...',
      location: ' في نهاية المبنى الرئيسي - امام الدرج الثاني - الطابق ثاني  ',
    ),
    Department(
      name: 'الهندسة الميكانيكية',
      images: ['assets/mec1.jpg', 'assets/mec2.jpg'],
      description: 'تصميم وتطوير الأنظمة الميكانيكية والمحركات...',
      location: 'في نهاية المبنى الرئيسي - يمين المدخل - الطابق الارضي',
    ),
    Department(
      name: 'الهندسة المدنية',
      images: ['assets/civileng1.jpg', 'assets/civileng2.jpg'],
      description: 'تصميم وتنفيذ المشاريع الإنشائية والبنية التحتية...',
      location: 'في بداية المبنى الرئيسي -مقابل المدخل -الطابق الارضي'
    ),
     Department(
      name: 'هندسة الأطراف الصناعية',
      images: ['assets/han1.jpg', 'assets/han2.jpg'],
      description: 'تصميم الأطراف الصناعية والأجهزة التعويضية...',
      location: 'في نهاية المبنى الرئيسي - يمين الدرج الثاني - الطابق ثاني',
    ),
    Department(
      name: 'هندسة الكيمائية',
      images: ['assets/cem1.jpg', 'assets/cem2.jpg'],
      description: 'تصميم و تطوير مجال هندسة الكميائية...',
      location: 'في بداية المبنى الرئيسي -  يسار المدخل - الطابق الارضي',
    ),
    Department(
      name: 'هندسة الليزر والايكترونات البصرية',
      images: ['assets/les1.jpg', 'assets/les2.jpg', 'assets/les3.jpg'],
      description: 'تطوير التقنيات ليزير والأجهزة الحيوية...',
      location: 'في نهاية المبنى الرئيسي - يسار المدخل - الطابق الارضي',
    ),
     Department(
      name: " هندسة الطب حياتي",
      images: ['assets/les2.jpg', 'assets/han2.jpg', ],
      description: "تطوير وتجهيز الاجهزة والامعدات الطبية ",
      location: "في بداية المبنى الرئيسي - يمين الدرج الاول - الطابق ثاني",
    ),
    
     Department(
      name: "هندسة الاتكترون والاتصالات",
      images: ['assets/han2.jpg', 'assets/les2.jpg'],
      description: 'تصميم وتطوير أنظمة الاتصالات...',
      location: "في بداية المبنى الرئيسي -  يسار الدرج الاول  - الطابق الثاني",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المبنى الرئيسي والأقسام'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Carousel Slider للمبنى الرئيسي
            CarouselSlider(
              items: mainBuildingImages.map((image) {
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
              child: Text(
                mainBuildingDescription,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(thickness: 2),

            // 🔹 قائمة الأقسام الهندسية
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                return DepartmentCard(department: departments[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 ويدجت عرض القسم ككارد
class DepartmentCard extends StatelessWidget {
  final Department department;

  const DepartmentCard({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // الانتقال إلى شاشة تفاصيل القسم
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DepartmentDetailsScreen(department: department),
            ),
          );
        },
        child: Column(
          children: [
            // 🔹 Carousel Slider لكل قسم
            CarouselSlider(
              items: department.images.map((image) {
                return Image.asset(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    department.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    department.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        department.location,
                        style: const TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
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

// 🔹 شاشة تفاصيل القسم
class DepartmentDetailsScreen extends StatelessWidget {
  final Department department;

  const DepartmentDetailsScreen({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Carousel Slider لعرض صور القسم في صفحة التفاصيل
            CarouselSlider(
              items: department.images.map((image) {
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
                    department.description,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '📍 موقع القسم: ${department.location}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
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

// 🔹 كلاس موديل الأقسام
class Department {
  final String name;
  final List<String> images; // 🔥 تعديل: بدلاً من صورة واحدة، قائمة صور
  final String description;
  final String location;

  Department({
    required this.name,
    required this.images,
    required this.description,
    required this.location,
  });
}
