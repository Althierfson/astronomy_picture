import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/core/success_return.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark_apod/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/core/date_convert.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/widgets/apod_video.dart';
import 'package:astronomy_picture/presentation/widgets/see_full_image.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodViewPage extends StatefulWidget {
  final Apod apod;
  const ApodViewPage({super.key, required this.apod});

  @override
  State<ApodViewPage> createState() => _ApodViewPageState();
}

class _ApodViewPageState extends State<ApodViewPage> {
  late BookmarkApodBloc _apodBloc;
  late Apod _apod;
  IconData iconSave = Icons.bookmark_border;

  @override
  void initState() {
    _apodBloc = getIt<BookmarkApodBloc>();
    _apod = widget.apod;
    _apodBloc.input.add(
        IsSaveBookmarkApodEvent(date: DateConvert.dateToString(_apod.date)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: PersonalTheme.spaceBlue.withOpacity(0.0),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: PersonalTheme.white,
              ),
              color: PersonalTheme.black,
              itemBuilder: (context) => buildMenuButton(),
            ),
          ],
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
                  Hero(
                      tag: 'apod-${_apod.date.toString()}',
                      child: ClipRRect(child: checkMediaType(context))),
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
                                  textToClip: _apod.title,
                                  msg: "Title was copy");
                            },
                            child: Text(
                              _apod.title,
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
                                  textToClip: _apod.explanation,
                                  msg: "Description was copy");
                            },
                            child: Text(
                              _apod.explanation,
                              style: TextStyle(
                                color: PersonalTheme.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "by ${_apod.copyright}",
                            style: TextStyle(
                              color: PersonalTheme.white,
                            ),
                          ),
                          Text(
                            "Date: ${DateConvert.dateToString(_apod.date)} (YYYY-MM-DD)",
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
                          launchUrl(Uri.parse(_apod.hdurl ?? _apod.url),
                              mode: LaunchMode.externalApplication);
                        }),
                    const SizedBox(
                      width: 15,
                    ),
                    StreamBuilder(
                        stream: _apodBloc.stream,
                        builder: (context, snapshot) {
                          var state = snapshot.data;

                          if (state is LocalAccessSuccessBookmarkApodState) {
                            if (state.msg == ApodSave().msg) {
                              if (iconSave.codePoint !=
                                  Icons.bookmark.codePoint) {
                                showSnackBar(state.msg);
                                iconSave = Icons.bookmark;
                              }
                            } else {
                              if (iconSave != Icons.bookmark_border) {
                                showSnackBar(state.msg);
                                iconSave = Icons.bookmark_border;
                              }
                            }
                          }

                          if (state is IsSaveBookmarkApodState) {
                            if (state.wasSave) {
                              iconSave = Icons.bookmark;
                            }
                          }

                          return buildBt(
                              name: "Save",
                              icon: iconSave,
                              description:
                                  "Save this content for quick access in future",
                              onTap: () {
                                if (iconSave == Icons.bookmark_border) {
                                  _apodBloc.input
                                      .add(SaveBookmarkApodEvent(apod: _apod));
                                } else {
                                  _apodBloc.input.add(
                                      RemoveSaveBookmarkApodEvent(
                                          date: DateConvert.dateToString(
                                              _apod.date)));
                                }
                              });
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
    showSnackBar(msg);
  }

  Widget checkMediaType(BuildContext context) {
    if (_apod.mediaType == "image") {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SeeFullImage(url: _apod.hdurl ?? _apod.url)));
        },
        child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_apod.url), fit: BoxFit.fitHeight),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: PersonalTheme.white.withOpacity(.5))),
        ),
      );
    } else {
      return Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_apod.thumbnailUrl ??
                      "https://spaceplace.nasa.gov/gallery-space/en/NGC2336-galaxy.en.jpg"),
                  fit: BoxFit.fitHeight),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: PersonalTheme.white.withOpacity(.5))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ApodVideo(
                url: _apod.url,
                showOptions: false,
              ),
            ],
          ));
    }
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }

  List<PopupMenuItem> buildMenuButton() {
    List<PopupMenuItem> list = [];

    if (_apod.mediaType == "image") {
      list.add(PopupMenuItem(
        textStyle: TextStyle(color: PersonalTheme.white),
        onTap: saveOnGallery,
        child: const Text('Save Image on Gallery'),
      ));
    }
    list.addAll([
      PopupMenuItem(
        textStyle: TextStyle(color: PersonalTheme.white),
        onTap: sharedOnlyLink,
        child: const Text('Share Only Image'),
      ),
      PopupMenuItem(
        textStyle: TextStyle(color: PersonalTheme.white),
        onTap: sharedAllContent,
        child: const Text('Share All Content'),
      )
    ]);

    return list;
  }

  void saveOnGallery() {
    if (_apod.mediaType == "image") {
      GallerySaver.saveImage(_apod.hdurl ?? _apod.url).then((value) {
        if (value == true) {
          setState(() {
            showSnackBar("Image Save on Gallery");
          });
        }
      });
    }
  }

  void sharedOnlyLink() {
    Share.share(_apod.hdurl ?? _apod.url);
  }

  void sharedAllContent() {
    String link = _apod.hdurl ?? _apod.url;
    Share.share(
        "${_apod.title}\n\n${_apod.explanation}\n\nlink: $link\n\nby: ${_apod.copyright}");
  }
}
