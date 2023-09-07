import 'package:flutter/material.dart';
import 'token_handler.dart';
import 'login_page.dart';
import 'registration_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _checkTokenValidityAndNavigate());
  }

  _checkTokenValidityAndNavigate() async {
    // Mock user ID for the sake of this example.
    // In a real application, you'd retrieve the user ID and token from secure storage.
    String userId = "mockUserId";
    String? token = database[userId]?['token'];

    await Future.delayed(const Duration(seconds: 1));  // Mocking a slight delay

    if (token == null) {
      // If the token doesn't exist (indicating first time launch), navigate to the registration page.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
    } else if (isTokenValid(userId, token)) {
      // If the token is valid, navigate to the main page.
      Navigator.pushReplacementNamed(context, '/mainPage');
    } else {
      // If the token is not valid, navigate to the login page.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),  // Display a loading spinner
    );
  }
}
