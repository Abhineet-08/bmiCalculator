import 'package:bmicalculator/controller/bottomnav/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_navigation.dart';

class HomePageController extends StatelessWidget {
  const HomePageController({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController controller = Get.put(BottomNavController());
    return Scaffold(
      floatingActionButton: const BottomNavigation(),
      body: Obx(() => controller.screens[controller.index.value]),
    );
  }
}
