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
      // appBar: AppBar(title: Text('Courses')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/course_coming.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
