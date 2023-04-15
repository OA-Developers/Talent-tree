import 'package:flutter/material.dart';
import 'package:talent_tree/pages/audience_page.dart';
import 'package:talent_tree/pages/course_page.dart';
import 'package:talent_tree/pages/debate_page.dart';
import 'package:talent_tree/pages/home_page.dart';
import 'package:talent_tree/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const AudiencePage(),
    const DebatePage(),
    const CoursePage(),
    const ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.blue,
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              backgroundColor: Colors.blue,
              label: 'Audience'),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              backgroundColor: Colors.blue,
              label: 'Debate'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cast_for_education),
              backgroundColor: Colors.blue,
              label: 'Course'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
            backgroundColor: Colors.blue,
          )
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue.shade600,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
