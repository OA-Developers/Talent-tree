import 'package:flutter/material.dart';
import 'package:talent_tree/utils/pallete.dart';

class LoginInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const LoginInputField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.appThemeColor, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Pallete.appThemeColor, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          controller: controller,
        ));
  }
}
