import 'package:astronomy_picture/features/apod/domain/entities/apod.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodViewPage extends StatelessWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: PersonalTheme.spaceBlue.withOpacity(0.0),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [PersonalTheme.spaceBlue, PersonalTheme.black]),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(apod.url),
                            fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                            color: PersonalTheme.white.withOpacity(.5))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 350.0, 30.0, 0.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerLeft,
                              colors: [
                                PersonalTheme.blue,
                                PersonalTheme.vermilion,
                                PersonalTheme.vermilion
                              ]),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: PersonalTheme.white.withOpacity(.3),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: PersonalTheme.blue.withOpacity(0.7),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                                offset: const Offset(0, 0))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onDoubleTap: () {
                              clipData(context,
                                  textToClip: apod.title,
                                  msg: "Title was copy");
                            },
                            child: Text(
                              apod.title,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: PersonalTheme.white,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onDoubleTap: () {
                              clipData(context,
                                  textToClip: apod.explanation,
                                  msg: "Description was copy");
                            },
                            child: Text(
                              apod.explanation,
                              style: TextStyle(
                                color: PersonalTheme.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "by ${apod.copyright}",
                            style: TextStyle(
                              color: PersonalTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildBt(
                        name: "Image in HD",
                        icon: Icons.hd,
                        description:
                            "Images may be distorted or incomplete! Tap here to view full image in high quality",
                        onTap: () {
                          launchUrl(Uri.parse(apod.hdurl ?? apod.url),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    buildBt(
                        name: "Save",
                        icon: Icons.bookmark_border,
                        description:
                            "Save this content for quick access in future",
                        onTap: () {
                          showSnackBar(context, "No build yet");
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        )));
  }

  Widget buildBt(
      {required String name,
      required IconData icon,
      required String description,
      Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 250,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: PersonalTheme.black,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: PersonalTheme.white.withOpacity(.6))),
          child: Column(
            children: [
              Icon(
                icon,
                color: PersonalTheme.white,
                size: 50,
              ),
              Text(
                name,
                style: TextStyle(color: PersonalTheme.white, fontSize: 22),
              ),
              Text(
                description,
                style: TextStyle(color: PersonalTheme.white, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  void clipData(BuildContext context,
      {required String textToClip, required String msg}) {
    Clipboard.setData(ClipboardData(text: textToClip));
    showSnackBar(context, msg);
  }

  bool checkMediaType() {
    // return true for image and false for video
    if (apod.mediaType == "image") {
      return true;
    } else {
      return false;
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
