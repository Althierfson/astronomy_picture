import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodImage extends StatelessWidget {
  final String url;
  final String hdurl;
  const ApodImage({super.key, required this.url, required this.hdurl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
                onPressed: () {
                  launchUrl(Uri.parse(hdurl), mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Open Image in Browser")),
          ],
        ),
      ],
    );
  }
}
