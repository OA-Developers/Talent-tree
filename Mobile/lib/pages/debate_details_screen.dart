import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class DebateDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String type;
  final String videoUrl;

  const DebateDetailsScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<DebateDetailsScreen> createState() => _DebateDetailsScreenState();
}

class _DebateDetailsScreenState extends State<DebateDetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Set the aspect ratio to 16:9
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      showControls: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
      placeholder: Container(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Set the aspect ratio to 16:9
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
