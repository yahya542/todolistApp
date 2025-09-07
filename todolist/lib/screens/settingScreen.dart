import 'package:flutter/material.dart';

void main() {
  runApp(const SettingScreen());
}
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setting Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Setting Screen'),
        ),
        body: const Center(
          child: Text('This is the setting screen'),
        ),
      ),
    );
  }
}