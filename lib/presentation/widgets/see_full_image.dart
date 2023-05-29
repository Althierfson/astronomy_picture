import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SeeFullImage extends StatefulWidget {
  final String url;
  const SeeFullImage({super.key, required this.url});

  @override
  State<SeeFullImage> createState() => _SeeFullImageState();
}

class _SeeFullImageState extends State<SeeFullImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: PersonalTheme.spaceBlue.withOpacity(0.0),
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: saveOnGallery,
            icon: Icon(
              Icons.download,
              color: PersonalTheme.white,
            ),
            label: Text(
              'Save on Gallery',
              style: TextStyle(color: PersonalTheme.white),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: InteractiveViewer(
            child: AspectRatio(
          aspectRatio: 1,
          child: ClipRect(
            clipBehavior: Clip.none,
            child: Image.network(
              widget.url,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        )),
      ),
    );
  }

  void saveOnGallery() {
    GallerySaver.saveImage(widget.url).then((value) {
      if (value == true) {
        setState(() {
          showSnackBar("Image Save on Gallery");
        });
      }
    });
  }

  void showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    });
  }
}
