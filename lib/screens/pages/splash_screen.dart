import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galaxy_planets/utils/height_width.dart';

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
        timerClass.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
