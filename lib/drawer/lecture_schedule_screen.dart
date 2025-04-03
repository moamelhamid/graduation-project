import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nahrain_univ/DatabeaseHelper.dart';
import 'package:nahrain_univ/schedule_model.dart';

class LectureScheduleScreen extends StatefulWidget {
  @override
  _LectureScheduleScreenState createState() => _LectureScheduleScreenState();
}

class _LectureScheduleScreenState extends State<LectureScheduleScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<Schedule> _scheduleFuture;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scheduleFuture = _loadSchedule();
  }

  Future<Schedule> _loadSchedule() async {
    try {
      return await _dbHelper.getSchedule();
    } catch (e) {
      throw Exception('Error loading schedule: $e');
    }
  }

  Future<void> _refreshSchedule() async {
    setState(() => _isRefreshing = true);
    try {
      final newSchedule = await _dbHelper.getSchedule();
      setState(() {
        _scheduleFuture = Future.value(newSchedule);
      });
    } finally {
      setState(() => _isRefreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Schedule>(
          future: _scheduleFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            if (snapshot.hasError) {
              return const Text("Error loading title");
            }
            return Text(snapshot.data?.title ?? "Lecture Schedule");
          },
        ),
        actions: [
          IconButton(
            icon: _isRefreshing
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshSchedule,
          ),
        ],
      ),
      body: FutureBuilder<Schedule>(
        future: _scheduleFuture,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _buildContent(snapshot),
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<Schedule> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Loading schedule...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }

    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 10),
            Text('Error: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _refreshSchedule,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return InteractiveViewer(
      panEnabled: true,
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: "http://192.168.1.27:8000/storage/${snapshot.data!.imageUrl}",
            placeholder: (context, url) => const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text('Failed to load schedule', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
