class Schedule {
  final String title;
  final String imageUrl;

  Schedule({required this.title, required this.imageUrl});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      title: json['title'],
      imageUrl: json['link_image'],
    );
  }
}