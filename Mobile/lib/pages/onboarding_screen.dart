import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:talent_tree/pages/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final List<Map<String, String>> onboardingPages = [
    {
      'image': 'assets/images/onboarding_img1.jpeg',
      'title': 'Welcome to MyApp',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'image': 'assets/images/onboarding_img2.jpeg',
      'title': 'Welcome to MyApp',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'image': 'assets/images/onboarding_img3.jpeg',
      'title': 'Welcome to MyApp',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
  ];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage(
      {required String urlImage,
      required String title,
      required String description}) {
    return Stack(
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.8,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView.builder(
          itemCount: onboardingPages.length,
          controller: controller,
          itemBuilder: ((context, index) {
            return buildPage(
              urlImage: onboardingPages[index]['image'].toString(),
              title: onboardingPages[index]['title'].toString(),
              description: onboardingPages[index]['description'].toString(),
            );
          }),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: const Text("SKIP"),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.blue.shade500),
                onDotClicked: (index) => controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn),
              ),
            ),
            TextButton(
              onPressed: () {
                if (controller.page!.toInt() != onboardingPages.length - 1) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()));
                }
              },
              child: const Text("NEXT"),
            ),
          ],
        ),
      ),
    );
  }
}
