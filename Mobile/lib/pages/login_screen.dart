import 'package:flutter/material.dart';
import 'package:talent_tree/pages/forgot_pass.dart';
import 'package:talent_tree/pages/main_screen.dart';
import 'package:talent_tree/pages/register_screen.dart';
import 'package:talent_tree/services/auth_services.dart';
import 'package:talent_tree/utils/utils.dart';
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
  final AuthService authService = AuthService();

  void loginUser() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar(context, "All Field's are required!");
      return;
    }

    authService.siginUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
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
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgotPassword(),
                            ));
                      },
                      child: const Text("Forgot Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  ActionButton(
                    height: 50,
                    width: 100,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    text: "Sign In",
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => MainScreen(),
                      //     ));
                      loginUser();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
