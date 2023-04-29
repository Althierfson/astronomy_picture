import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ApodVideo extends StatefulWidget {
  final String url;
  const ApodVideo({super.key, required this.url});

  @override
  State<ApodVideo> createState() => _ApodVideoState();
}

class _ApodVideoState extends State<ApodVideo> {
  late VideoPlayerController _videoController;
  late YoutubePlayerController _youtubeController;
  VideoPlataform videoPlataform = VideoPlataform.stand;

  @override
  void initState() {
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
    if (widget.url.substring(0, youtubeHost.length) == youtubeHost) {
      videoPlataform = VideoPlataform.youtube;
      _youtubeController = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(widget.url) ?? "",
          flags: const YoutubePlayerFlags(autoPlay: false));
      setState(() {});
    } else {
      _videoController = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Widget buildVideoPlayer() {
    if (videoPlataform == VideoPlataform.youtube) {
      return YoutubePlayer(controller: _youtubeController);
    }

    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          )
        : Container();
  }
}

enum VideoPlataform { stand, youtube, vimeo }
