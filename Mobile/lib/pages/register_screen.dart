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
        padding: const EdgeInsets.only(top: 150),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              const SizedBox(height: 25),
              LoginInputField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  const Text("I am 18 or above and i agree to the terms",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ActionButton(
                  height: 50,
                  width: 150,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  text: "Register",
                  onPressed: () {
                    // signupUser();
                  },
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Already have an account??",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
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
                            builder: (_) => LoginScreen(),
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
