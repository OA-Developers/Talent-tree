import 'package:flutter/material.dart';
import 'package:talent_tree/utils/pallete.dart';

class LoginInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const LoginInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _LoginInputFieldState createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
      ),
    );
  }
}
