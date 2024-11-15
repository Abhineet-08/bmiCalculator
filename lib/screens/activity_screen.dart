import 'package:bmicalculator/widgets/related_activity_screen/basic_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the BMI value passed from HomeContent
    double bmi = Get.arguments ?? 0;

    // Get BMI category and health status
    String category = _getBMICategory(bmi);
    String healthCategory = _getHealthCategory(category);

    // Determine if the BMI category is healthy
    bool isHealthy = healthCategory == 'Healthy';

    // Define sentences based on BMI health status
    String sentence1 =
        'Great job! You are maintaining a healthy weight. Also, you can follow the activities mentioned below to keep up the good work.';
    String sentence2 =
        'Consider consulting a health professional for advice on managing your weight. Also, you can follow the activities mentioned below to help improve your fitness.';

    // Define activity list based on BMI category
    Map<String, List<Map<String, String>>> activitiesMap = {
      'Underweight': [
        {
          'name': 'Strength Training',
          'description': 'Helps build muscle and improve strength',
          'icon': 'assets/icons/strength_training.png'
        },
        {
          'name': 'Yoga',
          'description': 'Improves flexibility and promotes relaxation',
          'icon': 'assets/icons/yoga_female.png'
        },
        {
          'name': 'Stretching',
          'description': 'Increases flexibility and reduces muscle tension',
          'icon': 'assets/icons/stretching.png'
        },
      ],
      'Normal weight': [
        {
          'name': 'Cardio',
          'description': 'Improves cardiovascular health',
          'icon': 'assets/icons/cardio.png'
        },
        {
          'name': 'Yoga',
          'description': 'Improves flexibility and promotes relaxation',
          'icon': 'assets/icons/yoga_female.png'
        },
        {
          'name': 'Hiking',
          'description': 'Great for building endurance and enjoying nature',
          'icon': 'assets/icons/hiking.png'
        },
      ],
      'Overweight': [
        {
          'name': 'Cardio',
          'description': 'Improves cardiovascular health',
          'icon': 'assets/icons/cardio.png'
        },
        {
          'name': 'Swimming',
          'description':
              'Full-body workout for improving strength and endurance',
          'icon': 'assets/icons/swimming.png'
        },
        {
          'name': 'Walking',
          'description':
              'A low-impact exercise that boosts cardiovascular health',
          'icon': 'assets/icons/walking_female.png'
        },
      ],
      'Obesity': [
        {
          'name': 'Walking',
          'description': 'Great low-impact exercise for weight loss',
          'icon': 'assets/icons/walking_female.png'
        },
        {
          'name': 'Swimming',
          'description': 'Low-impact full-body exercise',
          'icon': 'assets/icons/swimming.png'
        },
        {
          'name': 'Gentle Yoga',
          'description': 'Promotes flexibility and reduces stress',
          'icon': 'assets/icons/yoga_female.png'
        },
      ],
    };

    List<Map<String, String>> activities = activitiesMap[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(); // Navigate back
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.chat_bubble_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BasicInfo(),
              const SizedBox(height: 20),
              Text(
                'A BMI of $category indicates that you are at a $healthCategory weight for your height.${isHealthy ? sentence1 : sentence2}',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Activities',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              // Horizontal Scrollable Carousel
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: activities.map((activity) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image.asset(
                                activity['icon'] ?? 'assets/icons/default.png',
                                height: 50,
                                width: 50),
                            Text(activity['name']!,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(activity['description']!,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Track Your Progress:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              LinearProgressIndicator(
                value: 0.4, // 40% progress for example
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Share functionality
                },
                child: const Text('Share Your Activities'),
              ),
              const SizedBox(height: 20),
              Text(
                'Healthy Living Tips for You:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                category == 'Normal weight'
                    ? 'Keep maintaining a balanced diet and stay active.'
                    : 'Incorporate more physical activity and focus on healthy eating habits.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to get BMI category based on value
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  // Function to determine health status based on BMI category
  String _getHealthCategory(String category) {
    return category == 'Normal weight' ? 'Healthy' : 'Unhealthy';
  }
}
