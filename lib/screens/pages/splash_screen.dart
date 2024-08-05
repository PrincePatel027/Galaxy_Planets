import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timerClass;

  @override
  void initState() {
    super.initState();
    timerClass = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
    timerClass.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }
}
