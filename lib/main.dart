import 'package:flutter/material.dart';
import 'package:vendorapp/Login/login_page.dart';
import 'package:vendorapp/registration_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(),);
  }
}