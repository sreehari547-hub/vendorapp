import 'package:flutter/material.dart';
import 'package:vendorapp/session/session_manager.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // implement initState
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = await SessionManager.isLoggedIn();

    if (!mounted) return;
    // Navigation logic can be added here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}