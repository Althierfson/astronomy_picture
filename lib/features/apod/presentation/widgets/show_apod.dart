import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_image.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowApod extends StatelessWidget {
  final Apod apod;
  const ShowApod({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        checkMediaType() ? ApodImage(url: apod.url) : ApodVideo(url: apod.url),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                apod.title,
                style: const TextStyle(
                    color: Color(0xFF0b3d91), fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: apod.title));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Color(0xFF0b3d91),
                  ))
            ],
          ),
        ),
        Text(
          "Date: ${apod.date.month}/${apod.date.day}/${apod.date.year}",
          style: const TextStyle(color: Color(0xFF0b3d91)),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(5.0),
          decoration:
              BoxDecoration(border: Border.all(color: const Color(0xFF212121))),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Text(
                  apod.explanation,
                  style: const TextStyle(
                      color: Color(0xFF212121),
                      decoration: TextDecoration.none),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: apod.explanation));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Color(0xFF0b3d91),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.copyright,
              ),
              Text(
                "copyright: ${apod.copyright}",
                style: const TextStyle(color: Color(0xFF212121)),
              ),
            ],
          ),
        )
      ],
    );
  }

  bool checkMediaType() {
    // return true for image and false for video
    if (apod.mediaType == "image") {
      return true;
    } else {
      return false;
    }
  }
}
