import 'package:flutter/material.dart';

class ApodButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ApodButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0b3d91),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
