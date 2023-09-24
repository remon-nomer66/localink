import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'main.dart';

class UserInfoProvider with ChangeNotifier {
  String username = '';
  String email = '';
  String password = '';

  void updateUserInfo(String username, String email, String password) {
    this.username = username;
    this.email = email;
    this.password = password;
    notifyListeners();
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ImageProvider _profileImage = const AssetImage('assets/default_profile.jpg');

  bool _isValid() {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    bool validUsername = RegExp(r'^[a-zA-Z0-9]{8,16}$').hasMatch(username);
    bool validEmail = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z0-9]+$').hasMatch(email);
    bool validPassword = RegExp(r'^[a-zA-Z0-9!@#&*~]{8,16}$').hasMatch(password);

    // Debug prints to identify which field is invalid
    if (!validUsername) print('Invalid Username: $username');
    if (!validEmail) print('Invalid Email: $email');
    if (!validPassword) print('Invalid Password: $password');

    return validUsername && validEmail && validPassword;
  }



  Future<void> _showChangeProfileImageDialog() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      setState(() {
        _profileImage = FileImage(image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '新規会員登録',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _showChangeProfileImageDialog,
              child: CircleAvatar(
                backgroundImage: _profileImage,
                radius: 50,
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'ユーザー名 (8~16英数)'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス (@必須)'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード (8~16英数)'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isValid() ? Colors.green : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                minimumSize: const Size(100, 50),
              ),
              onPressed: _isValid() ? () {
                Provider.of<UserInfoProvider>(context, listen: false).updateUserInfo(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
                );
              } : null,
              child: const Text(
                '登録',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
