import 'package:flutter/material.dart';

class ApodImage extends StatelessWidget {
  final String url;
  const ApodImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
  }
}
