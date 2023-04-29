import 'package:flutter/material.dart';
import 'package:talent_tree/pages/main_screen.dart';
import 'package:talent_tree/pages/register_screen.dart';
import 'package:talent_tree/widgets/login_input_field.dart';
import 'package:talent_tree/widgets/action_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 15,
              ),
              const Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 25),
              LoginInputField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 25),
              LoginInputField(
                hintText: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ActionButton(
                  height: 50,
                  width: 150,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  text: "Sign In",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainScreen(),
                        ));
                  },
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don’t have an account??",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ActionButton(
                    height: 50,
                    width: 150,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: "Register",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterScreen(),
                          ));
                    })
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
