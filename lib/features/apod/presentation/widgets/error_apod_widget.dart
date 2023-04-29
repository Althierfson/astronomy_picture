import 'package:flutter/material.dart';

class ErrorApodWidget extends StatelessWidget {
  final String msg;
  const ErrorApodWidget({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.error,
            color: Color(0xFFdd361c),
          ),
          Text(
            msg,
            style: const TextStyle(color: Color(0xFF212121)),
          )
        ],
      ),
    );
  }
}
