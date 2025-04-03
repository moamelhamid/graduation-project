import 'package:flutter/material.dart';
import 'package:nahrain_univ/DatabeaseHelper.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _homeLocationController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _homeLocationController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updateInfo() async {
    if (!_validateFields()) return;

    setState(() => _isLoading = true);

    try {
      await _dbHelper.updateUserInfo(
        email: _emailController.text.trim(),
        password: _newPasswordController.text.trim(),
        homeLocation: _homeLocationController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Information updated successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update failed: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _validateFields() {
    // Check if all fields are empty
    if (_emailController.text.isEmpty &&
        _phoneController.text.isEmpty &&
        _homeLocationController.text.isEmpty &&
        _newPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill at least one field to update'),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    }

    // Validate password match if new password is provided
    if (_newPasswordController.text.isNotEmpty &&
        _newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate email format if email is provided
    if (_emailController.text.isNotEmpty &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validate phone number format if provided
    if (_phoneController.text.isNotEmpty &&
        !RegExp(r'^[0-9]{10,15}$').hasMatch(_phoneController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number (10-15 digits)'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile Information'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: 20,
            ),
            child: Column(
              children: [
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPhoneField(),
                const SizedBox(height: 20),
                _buildHomeLocationField(),
                const SizedBox(height: 20),
                _buildPasswordFields(),
                const SizedBox(height: 30),
                _buildUpdateButton(screenWidth),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'name@example.com',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: '07XXXXXXXX',
        prefixIcon: const Icon(Icons.phone_android_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildHomeLocationField() {
    return TextField(
      controller: _homeLocationController,
      decoration: InputDecoration(
        labelText: 'Home Location',
        hintText: 'Enter your home address',
        prefixIcon: const Icon(Icons.location_on_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        TextField(
          controller: _newPasswordController,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            labelText: 'New Password',
            hintText: 'Enter new password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => setState(() => _showPassword = !_showPassword),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _confirmPasswordController,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Confirm your new password',
            prefixIcon: const Icon(Icons.lock_reset_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton(double screenWidth) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _updateInfo,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth * 0.7, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      child: const Text(
        'Update Information',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}