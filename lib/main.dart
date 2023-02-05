import 'package:flutter/material.dart';
import 'package:ledbim_project/view/login_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledbim Project',
      theme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}

