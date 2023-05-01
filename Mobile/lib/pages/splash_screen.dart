import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:talent_tree/pages/onboarding_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Initialize the video player and chewie controller
    final videoPlayerController =
        VideoPlayerController.asset('assets/videos/splash_video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: false,
    );

    // Navigate to the onboarding screen after the video finishes
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(35),
        child: Text(
          "Talent Tree",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
