import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DebateDetailsScreen extends StatefulWidget {
  // const DebateDetailsScreen({super.key});
  final String videoUrl;

  DebateDetailsScreen({super.key, required this.videoUrl});
  @override
  State<DebateDetailsScreen> createState() => _DebateDetailsScreenState();
}

class _DebateDetailsScreenState extends State<DebateDetailsScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Debate Details"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: _controller.value.isInitialized
          ? Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Description of the video goes here.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
