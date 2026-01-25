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
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // ROTATION CONTROLLER
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // slow rotation
    )..repeat();

    // LOGO ZOOM ANIMATION
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1)
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );

    // SPLASH TIMER (3 seconds)
    Timer(const Duration(seconds: 2), () {
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
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.1415926535,
                  child: child,
                );
              },
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withAlpha((0.7 * 255).toInt()),

                    width: 4,
                  ),
                ),
              ),
            ),

            // LOGO WITH ZOOM EFFECT
            ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/icon/logorm.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
