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
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      'image': 'assets/images/onboarding_img2.jpeg',
      'title': 'Welcome to MyApp',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      'image': 'assets/images/onboarding_img3.jpeg',
      'title': 'Welcome to MyApp',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
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
          bottom: MediaQuery.of(context).size.height * 0.1,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),
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
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => controller.jumpToPage(2),
                  child: const Text(
                    "SKIP",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.white60),
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.page!.toInt() !=
                        onboardingPages.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WelcomeScreen()));
                    }
                  },
                  child: const Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
