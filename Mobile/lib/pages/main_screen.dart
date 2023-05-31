import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_tree/pages/audience_page.dart';
import 'package:talent_tree/pages/coupons_page.dart';
import 'package:talent_tree/pages/course_page.dart';
import 'package:talent_tree/pages/debate_page.dart';
import 'package:talent_tree/pages/home_page.dart';
import 'package:talent_tree/pages/profile_page.dart';
import 'package:talent_tree/pages/registration_screen.dart';
import 'package:talent_tree/pages/subscription_page.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:talent_tree/utils/utils.dart';

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

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (index == 1) {
      if (!userProvider.isRegistered) {
        showSnackBar(context, 'Please Complete Registration First!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegistrationScreen()),
        );
      } else {
        if (!userProvider.isSubscribed) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CouponsPage()),
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Talent Tree')),
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
              label: 'Audition'),
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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue.shade600,
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // change this to enable others
      ),
    );
  }
}
