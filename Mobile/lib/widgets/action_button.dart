
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontFamily: 'Poppins'
          ),
        ),
      ),
    );
  }
}
