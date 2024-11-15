import 'package:bmicalculator/controller/bottomnav/homepage_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    if (mounted) {
      // Splash duration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageController()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'), // Your splash image
      ),
    );
  }
}
