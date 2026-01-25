import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // ROTATION CONTROLLER (slow)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // slower rotation
    )..repeat();

    // SPLASH TIMER (1.5 seconds)
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 126, 72),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            // ROTATING CIRCLE
            RotationTransition(
              turns: _controller,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
            ),

            // LOGO IN CENTER
            Image.asset(
              'assets/icon/logorm.png',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
