import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            text,
            style: TextStyle(color: PersonalTheme.white),
          ),
          Text("For more information, please visit:",
              style: TextStyle(color: PersonalTheme.white)),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse("https://api.nasa.gov/"),
                  mode: LaunchMode.externalApplication);
            },
            child: const Text(
              "https://api.nasa.gov/",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ]),
      ),
    );
  }
}

String text = """
Our application is a platform that consumes data from NASA's APOD API to display amazing images and videos from space.

It is important to note that NASA has no relationship with the application, and the information provided and displayed is available to anyone who wants to access the APOD API.

Our APP simply organizes and provides easy ways to access this data.

Some images or videos may have copyrights, so be sure to check the usage rights before using any content found here.
""";
