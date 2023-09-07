
import 'package:flutter/material.dart';
import 'token_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('ログイン'),
              onPressed: () {
                // Get the email and password from the respective controllers
                String email = _emailController.text;
                String password = _passwordController.text;

                // Validate the user credentials (For this demo, we're checking the mock database)
                if (database.containsKey(email) && database[email]['password'] == password) {
                  // If the credentials are valid, navigate to the home page
                  Navigator.pushReplacementNamed(context, '/mainPage');
                } else {
                  // If the credentials are not valid, show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('メールアドレスまたはパスワードが正しくありません。'))
                  );
                }
              },
            ),
            TextButton(
              child: const Text('アカウントをお持ちでない方はこちら'),
              onPressed: () {
                // Navigate to registration page
              },
            ),
          ],
        ),
      ),
    );
  }
}
