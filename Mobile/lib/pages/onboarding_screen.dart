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
      'image': 'assets/images/welcome2.png',
      'title': 'Audition Updates',
      'description':
          "If you're an aspiring performer and want to stay informed about the latest audition updates, you can sign up for the Talent Tree app. It will give you regular updates about auditions, which can help you increase your chances of success in the entertainment industry."
    },
    {
      'image': 'assets/images/welcome1.png',
      'title': 'About Courses',
      'description':
          "Talent Tree app not only provides regular updates about upcoming auditions but also offers a range of courses to help aspiring performers hone their skills. These courses are designed to provide trainning in various aspects of performing arts including action modelling and debate."
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
            padding: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
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
                    style: TextStyle(
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 2,
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
                    style: TextStyle(
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
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
