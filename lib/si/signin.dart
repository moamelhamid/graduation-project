import 'package:flutter/material.dart';
import 'package:nahrain_univ/DatabeaseHelper.dart';
import 'package:nahrain_univ/UpdateInfoScreen.dart';
import 'package:nahrain_univ/mapscr.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:nahrain_univ/mapscr.dart';
//import 'package:nahrain_univ/si/sing_up.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

read() async{
  final prefs = await SharedPreferences.getInstance();
  final key='token';
  final value = prefs.get(key) ?? 0;
  if(value !='0' );
}
//   @override
//   initState(){
//     read();
//   }





  DatabaseHelper databaseHelper =  DatabaseHelper();
  String msgstatus = '';
final TextEditingController _nameController =  TextEditingController();
final TextEditingController _passkeyController =  TextEditingController();

_onpressed(){
  setState(() {
    if(_nameController.text.isNotEmpty && _passkeyController.text.isNotEmpty){
      databaseHelper.loginData(_nameController.text, _passkeyController.text).whenComplete(() {
        if(databaseHelper.status){
          _showDialog();
           msgstatus = 'Check your name or passkey';
        print ("{$_nameController.text.isNotEmpty}" "${_passkeyController.text.isNotEmpty}");
        }else {
       
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

        
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
            (Route<dynamic> route) => false,
          );
        }
      });
    }
  });
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formPadding = screenWidth * 0.1;

    return Scaffold(appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: formPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person),
                  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passkeyController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your passkey',
                  labelText: 'passkey',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onpressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.7, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 20),

              Container(
                height: 50,
                child:  Text(
                  msgstatus,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )




            
            ],
          ),
        ),
      ),
    );
    
  }

void _showDialog(){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Error'),
        content: const Text('Check your name or passkey'),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      );
    },
  );
}
}


