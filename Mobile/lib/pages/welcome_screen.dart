import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talent_tree/pages/login_screen.dart';
import 'package:talent_tree/pages/register_screen.dart';
import 'package:talent_tree/widgets/action_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_bg_img.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ActionButton(
                    height: 50,
                    width: 300,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    text: 'REGISTER',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ActionButton(
                    height: 50,
                    width: 300,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: 'LOGIN',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
