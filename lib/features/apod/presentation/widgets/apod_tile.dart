import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_image.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_video.dart';
import 'package:flutter/material.dart';

class ApodTile extends StatelessWidget {
  final Apod apod;
  final Function() onTap;
  const ApodTile({super.key, required this.apod, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            checkMediaType()
                ? ApodImage(
                    url: apod.url,
                    hdurl: apod.hdurl ?? apod.url,
                    showOptions: false,
                  )
                : ApodVideo(
                    url: apod.url,
                    showOptions: false,
                  ),
            Text(
              apod.title,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              apod.explanation,
              maxLines: 2,
            ),
            const Text(
              "Read more",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
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
