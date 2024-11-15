import 'package:bmicalculator/controller/bottomnav/bottom_nav_controller.dart';
import 'package:bmicalculator/controller/user_controller.dart';
import 'package:bmicalculator/screens/activity_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    BottomNavController controller = Get.put(BottomNavController());
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 50,
            width: againGetCardWidth(context) * 2,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home Tab (index 0)
                InkWell(
                  onTap: () {
                    controller.index.value = 0;
                  },
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.bounceOut,
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        color: controller.index.value == 0
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 25,
                        color: controller.index.value == 0
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ),
                ),

                // Middle Tab (BMI, index 1)
                InkWell(
                  onTap: () {
                    if (controller.index.value == 1) {
                      // If already on BMI screen, perform BMI calculation
                      _calculateBMI();
                    } else {
                      controller.index.value = 1;
                    }
                  },
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.bounceOut,
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        color: controller.index.value == 1
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.calculate,
                        size: 25,
                        color: controller.index.value == 1
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ),
                ),

                // Settings Tab (index 2)
                InkWell(
                  onTap: () {
                    controller.index.value = 2;
                  },
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.bounceOut,
                      height: 50,
                      width: 40,
                      decoration: BoxDecoration(
                        color: controller.index.value == 2
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 25,
                        color: controller.index.value == 2
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double againGetCardWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width / 1.5;
    } else if (width < 1200) {
      return width / 3;
    } else {
      return width / 4;
    }
  }

  // Navigate to ActivityScreen and perform BMI calculation
  void _calculateBMI() {
    // Call the calculateBMI method from the controller
    double bmi = userController.calculateBMI();
    // Navigate to ActivityScreen and pass the BMI value
    Get.to(() => const ActivityScreen(), arguments: bmi);
  }
}
