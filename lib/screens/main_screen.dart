import 'package:bmicalculator/controller/user_controller.dart'; // Import UserController
import 'package:bmicalculator/screens/activity_screen.dart'; // Import the ActivityScreen
import 'package:bmicalculator/screens/home_content.dart';
import 'package:bmicalculator/screens/profile_screen.dart';
import 'package:bmicalculator/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // Default to Home (middle button)
  final List<Widget> _screens = [
    const ProfileScreen(),
    const HomeContent(), // Middle button - Home content layout
    const SettingsScreen(),
  ];

  final UserController userController =
      Get.put(UserController()); // Get the UserController

  void _onTabTapped(int index) {
    if (index == 1 && _currentIndex == 1) {
      // Perform BMI calculation if already on Home
      _calculateBMI();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _calculateBMI() {
    double bmi = userController.calculateBMI();
    // Check if this prints a valid BMI value
    if (bmi > 0) {
      Get.to(() => const ActivityScreen(),
          arguments: bmi); // Pass the BMI to ActivityScreen
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the current screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Colors.black : Colors.transparent,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.calculate),
            ),
            label: 'BMI',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
