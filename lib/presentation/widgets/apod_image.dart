import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodImage extends StatelessWidget {
  final String url;
  final String hdurl;
  final bool showOptions;
  const ApodImage(
      {super.key,
      required this.url,
      required this.hdurl,
      this.showOptions = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Image.network(
            url,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.fitHeight,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        showOptions
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse(hdurl),
                            mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.open_in_browser),
                      label: const Text("view full Image")),
                ],
              )
            : Container(),
      ],
    );
  }
}
