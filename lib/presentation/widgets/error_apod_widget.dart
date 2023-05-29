import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';

class ErrorApodWidget extends StatelessWidget {
  final String msg;
  final Function()? onRetry;
  const ErrorApodWidget({super.key, required this.msg, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: PersonalTheme.vermilion,
            size: 100,
          ),
          Text(
            msg,
            style: TextStyle(color: PersonalTheme.white),
          ),
          onRetry != null
              ? ElevatedButton(onPressed: onRetry, child: const Text("Retry"))
              : Container()
        ],
      ),
    );
  }
}
