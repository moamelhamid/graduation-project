
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper{
  String serverUrl = "http://26.130.65.172:8000/api";
  var status;
  var token;


 loginData(String name, String passkey) async{
  String myUrl = "$serverUrl/login";
 final response= await http.post(Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json'
      },
      body: {
        "name": "$name",
        "password": "$passkey"}
);
status = response.body.contains('error');


var data = json.decode(response.body);
if(!status) {
    _save(data["token"], name); // Pass username to save
  }
}

_save(String token, String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('username', username); // Save username
}

read() async{
  final prefs = await SharedPreferences.getInstance();
  final key='token';
  final value = prefs.get(key) ?? 0;
  print('read: $value');
}
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token'); 
  await prefs.remove('username');
  print('User logged out');
}

}
