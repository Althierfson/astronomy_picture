import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideo extends StatefulWidget {
  final String url;
  const ApodVideo({super.key, required this.url});

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  late String url;
  late VideoPlayerController _videoController;
  late YoutubePlayerController _youtubeController;
  VideoPlataform videoPlataform = VideoPlataform.stand;

  @override
  void initState() {
    url = widget.url; // "https://vimeo.com/70591644";
    checkVideoPlataform();
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildVideoPlayer();
  }

  void checkVideoPlataform() {
    String youtubeHost = "https://www.youtube.com";
    String vimeoHost = "https://vimeo.com";
    if (url.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlataform = VideoPlataform.youtube;
      _youtubeController = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url) ?? "",
          flags: const YoutubePlayerFlags(autoPlay: false));
      setState(() {});
    } else if (url.substring(0, vimeoHost.length) == vimeoHost) {
      videoPlataform = VideoPlataform.vimeo;
    } else {
      _videoController = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget buildVideoPlayer() {
    Widget videoWidget;
    if (videoPlataform == VideoPlataform.youtube) {
      videoWidget = YoutubePlayer(controller: _youtubeController);
    } else if (videoPlataform == VideoPlataform.vimeo) {
      videoWidget = VimeoVideoPlayer(
        url: url,
        autoPlay: true,
      );
    } else {
      if (_videoController.value.hasError) {
        videoWidget = const Text(
            "Sorry! We can't play this video. Try open in your browser");
      } else {
        videoWidget = _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : Container();
      }
    }

    return Column(
      children: [
        videoWidget,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: () {
                  launchUrl(Uri.parse(url),
                      mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Open video in Browser or APP")),
          ],
        )
      ],
    );
  }
}

enum VideoPlataform { stand, youtube, vimeo }
