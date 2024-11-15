import 'package:bmicalculator/widgets/gender_widget.dart';
import 'package:bmicalculator/widgets/height_widget.dart';
import 'package:bmicalculator/widgets/weight_age.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  HomeContentState createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _resetValues(); // Reset values when the screen is created or revisited
  }

  void _resetValues() {
    // Reset values if needed when the user revisits this screen
    userController.setHeight(0.0);
    userController.setWeight(0.0);
    userController.setAge(0);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isAppBarVisible) {
        setState(() {
          _isAppBarVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible
          ? AppBar(
              title: const Text('BMI Calculator'),
              actions: [
                IconButton(
                  onPressed: () {
                    // Action for logout button
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
              ],
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GenderWidget(
                onGenderSelected: (gender) {
                  userController
                      .setGender(gender); // Update gender in controller
                },
              ),
              const SizedBox(height: 20),
              HeightWidget(
                onHeightSelected: (height) {
                  userController.setHeight(height);
                },
              ),
              const SizedBox(height: 20),
              WeightAge(
                onWeightSelected: (weight) {
                  userController.setWeight(weight);
                },
                onAgeSelected: (age) {
                  userController.setAge(age as int);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
