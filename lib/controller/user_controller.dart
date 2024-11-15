import 'package:get/get.dart';

class UserController extends GetxController {
  var gender = RxString('');
  var height = RxDouble(0.0);
  var weight = RxDouble(0.0);
  var age = RxInt(0);

  void setGender(String selectedGender) {
    gender.value = selectedGender;
  }

  void setHeight(double selectedHeight) {
    height.value = selectedHeight;
  }

  void setWeight(double selectedWeight) {
    weight.value = selectedWeight;
  }

  void setAge(int selectedAge) {
    age.value = selectedAge;
  }

  // BMI Calculation
  double calculateBMI() {
    if (height.value > 0 && weight.value > 0) {
      // Convert height to meters (assuming height is in centimeters)
      double heightInMeters = height.value / 100;
      double bmi = weight.value / (heightInMeters * heightInMeters);
      return bmi;
    } else {
      return 0.0;
    }
  }
}
