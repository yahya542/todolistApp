import 'package:flutter/material.dart';

void main() {
  runApp(const LoginScreen());
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setting Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: const Center(
          child: Text('This is the Login screen'),
        ),
      ),
    );
  }
}