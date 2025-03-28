
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
if(status){
  print('data: ${data["error"]}');
}else{
  print('data: ${data["token"]}');
  _save(data["token"]);

}
}

_save(String token) async{
 final prefs= await SharedPreferences.getInstance();
 final key ='token';
 final value = token;
  
  prefs.setString(key , value);
 
}


read() async{
  final prefs = await SharedPreferences.getInstance();
  final key='token';
  final value = prefs.get(key) ?? 0;
  print('read: $value');
}
}