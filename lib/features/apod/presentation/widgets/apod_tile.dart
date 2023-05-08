import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/features/apod/presentation/widgets/apod_video.dart';
import 'package:astronomy_picture/theme.dart';
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
            Hero(
              tag: 'apod-${apod.date.toString()}',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(apod.thumbnailUrl ?? apod.url),
                          fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                          color: PersonalTheme.white.withOpacity(.5))),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: PersonalTheme.black.withOpacity(.6),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    apod.title,
                                    style: TextStyle(
                                      color: PersonalTheme.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    apod.explanation,
                                    maxLines: 1,
                                    style:
                                        TextStyle(color: PersonalTheme.white),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: PersonalTheme.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                apod.title,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: PersonalTheme.vermilion,
                    fontSize: 16),
              ),
            ),
            Text(
              apod.explanation,
              maxLines: 2,
              style: TextStyle(color: PersonalTheme.white),
            ),
            const Text(
              "Read more",
              style: TextStyle(color: Colors.blue),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget checkMediaType(BuildContext context) {
    if (apod.mediaType == "image") {
      return Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(apod.url), fit: BoxFit.fitHeight),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: PersonalTheme.white.withOpacity(.5))),
      );
    } else {
      return Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: PersonalTheme.white.withOpacity(.5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ApodVideo(
                url: apod.url,
                showOptions: false,
              ),
            ],
          ));
    }
  }
}
