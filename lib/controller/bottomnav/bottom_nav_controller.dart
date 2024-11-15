import 'package:bmicalculator/screens/home_content.dart';
import 'package:bmicalculator/screens/profile_screen.dart';
import 'package:bmicalculator/screens/settings_screen.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt index = 0.obs;
  var screens = [
    const ProfileScreen(),
    const HomeContent(),
    const SettingsScreen()
  ];
}
