import 'package:flutter/material.dart';
import 'package:nahrain_univ/DatabeaseHelper.dart';
import 'package:nahrain_univ/mapscr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passkeyController = TextEditingController();
  String _msgStatus = '';
  bool _isLoading = false;

  Future<void> _attemptLogin() async {
    if (_nameController.text.isEmpty || _passkeyController.text.isEmpty) {
      setState(() => _msgStatus = 'Please fill in all fields');
      return;
    }

    setState(() {
      _isLoading = true;
      _msgStatus = '';
    });

    try {
      final success = await _databaseHelper.loginData(
        _nameController.text,
        _passkeyController.text,
      );

      if (success) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        _showErrorDialog('Invalid credentials');
        setState(() => _msgStatus = 'Check your name or passkey');
      }
    } catch (e) {
      _showErrorDialog('Login error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formPadding = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
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
                  labelText: 'Passkey',
                  hintText: 'Enter your passkey',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                ),)
              ),
              const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _isLoading ? null : _attemptLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.7, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign In'),
              ),
              const SizedBox(height: 20),
              Text(
                _msgStatus,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK')),
        ],
      ),
    );
  }
}