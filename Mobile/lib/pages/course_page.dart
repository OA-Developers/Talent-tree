import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/construction.svg',
              semanticsLabel: 'Coming soon',
              height: 150,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Coming Soon...',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
