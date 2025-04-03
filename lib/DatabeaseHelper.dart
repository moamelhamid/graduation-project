import 'package:http/http.dart' as http;
import 'package:nahrain_univ/schedule_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = "http://192.168.1.27:8000/api";
  var status;
  var token;

 Future<bool> loginData(String name, String passkey) async {
    try {
      final response = await http.post(
        Uri.parse('$serverUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'name': name, 'password': passkey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('error')) {
          return false;
        }
        await _save(data['token'], name);
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  _save(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('username', username); // Save username
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    // print('read: $value');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    //print('User logged out');
  }

  Future<Map<String, dynamic>> updateUserInfo({
    required String email,
    required String password,
    required String homeLocation,
    required String phoneNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No authentication token found');
    }

    final url = Uri.parse('http://26.130.65.172:8000/api/update-profile');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        "email": email,
        "password": password,
        "home_location": homeLocation,
        "phone_number": phoneNumber
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user info: ${response.reasonPhrase}');
    }
  }
   Future<Schedule> getSchedule() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) {
    throw Exception('No authentication token found');
  }

  final response = await http.get(
    Uri.parse('$serverUrl/schedule'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Schedule.fromJson(data['data']); // إرجاع كائن Schedule
  } else {
    throw Exception('Failed to load schedule: ${response.statusCode}');
  }
}

}

