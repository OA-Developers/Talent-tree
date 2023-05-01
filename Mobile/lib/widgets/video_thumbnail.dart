import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnail extends StatelessWidget {
  final String videoUrl;

  VideoThumbnail({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final videoController = VideoPlayerController.network(videoUrl);

    return FutureBuilder(
      future: videoController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
