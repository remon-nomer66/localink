import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ImageProvider _profileImage = const AssetImage('assets/default_profile.jpg'); // デフォルトのプロフィール画像

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      status = await Permission.storage.request();
      return status.isGranted;
    }
    if (status.isPermanentlyDenied) {
      // The OS restricts the permission, so we have to inform the user to do it manually.
      openAppSettings();
      return false;
    }
    return status.isGranted;
  }


  void _showChangeProfileImageDialog() async {
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      // If we don't have permission, we won't proceed further.
      return;
    }

    final ImagePicker picker = ImagePicker();
    // 画像を選択する
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = FileImage(File(image.path));
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
            const Text(
              '認証を行うために、受信可能なメールアドレスを入力して下さい。',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _showChangeProfileImageDialog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: _profileImage,
                    radius: 50,
                  ),
                  const Text('画像を変更', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'ユーザー名'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                minimumSize: const Size(100, 50),
              ),
              onPressed: () {
                // ...
              },
              child: const Text(
                '登録',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              child: const Text(
                'すでにアカウントをお持ちの方はこちら',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                // Navigate to login page
              },
            ),
          ],
        ),
      ),
    );
  }
}
