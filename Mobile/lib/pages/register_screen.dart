import 'package:flutter/material.dart';
import 'package:talent_tree/pages/login_screen.dart';
import 'package:talent_tree/pages/main_screen.dart';
import 'package:talent_tree/services/auth_services.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:talent_tree/widgets/login_input_field.dart';
import 'package:talent_tree/widgets/action_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isChecked = false;

  void signupUser() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showSnackBar(context, "All Field's are required!");
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(context, "Passwords Doesn't Match!");
      return;
    }
    authService.signUpUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
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
                isPassword: true,
              ),
              const SizedBox(height: 25),
              LoginInputField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Checkbox(
                    value: isChecked,
                    checkColor: Colors.black87,
                    fillColor: MaterialStateProperty.all(Colors.white),
                    shape: CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Flexible(
                    child: Text(
                      "I am 18 or above and i agree to the terms",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ActionButton(
                    height: 50,
                    width: 125,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: "Register",
                    onPressed: () {
                      signupUser();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ActionButton(
                    height: 50,
                    width: 150,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: "Sign In",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
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
