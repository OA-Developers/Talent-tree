import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talent_tree/pages/registration_screen.dart';
import 'package:http/http.dart' as http;
import 'package:talent_tree/providers/user_provider.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/widgets/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class VideoData {
  final String videoUrl;
  final String thumbnailUrl;

  VideoData({required this.videoUrl, required this.thumbnailUrl});
}

class _HomePageState extends State<HomePage> {
  List<String> _imageUrls = [];
  List<VideoData> _videos = [];
  bool showButton = true;
  int _currentImageIndex = 0;
  int _currentVideoIndex = 0;
  @override
  void initState() {
    super.initState();
    toggleVisibleRegister();

    _fetchBanners();
  }

  toggleVisibleRegister() async {
    bool registered =
        Provider.of<UserProvider>(context, listen: false).isRegistered;
    if (registered) {
      setState(() {
        showButton = false;
      });
    }
  }

  Future<void> _fetchBanners() async {
    final response = await http.get(Uri.parse('${Constants.baseURL}banners'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<String> imgurls = [];
      final List<VideoData> vidurls = [];

      for (final banner in data) {
        if (banner['type'] == "image") {
          imgurls.add('${Constants.baseURL}files/${banner['url']}');
        } else {
          vidurls.add(VideoData(
            videoUrl: '${Constants.baseURL}files/${banner['url']}',
            thumbnailUrl:
                '${Constants.baseURL}thumbnails/${banner['thumbnailUrl']}',
          ));
        }
      }

      setState(() {
        _imageUrls = imgurls;
        _videos = vidurls;
      });
    } else {
      throw Exception('Failed to fetch banners');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Latest Updates',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: _imageUrls.map((imageUrl) {
                              return Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentImageIndex =
                                      index; // Update the current image index
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                              height:
                                  10), // Add spacing between the carousel and dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _imageUrls.map((imageUrl) {
                              int index = _imageUrls.indexOf(imageUrl);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentImageIndex == index
                                      ? Colors.blue
                                      : Colors
                                          .grey, // Customize active and inactive dot colors
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Latest Videos',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: _videos.map((video) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VideoPlayer(videoUrl: video.videoUrl),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  video.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentVideoIndex =
                                      index; // Update the current image index
                                });
                              },
                              viewportFraction: 1.0,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  10), // Add spacing between the carousel and dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _videos.asMap().entries.map((entry) {
                              final index = entry.key;
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentVideoIndex == index
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Visibility(
                      visible: showButton,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/job_search.svg',
                                    semanticsLabel:
                                        'Register & start exploring opportuinites we have at talent tree ',
                                    height: 125,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'Register & start exploring opportuinites we have at talent tree',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const RegistrationScreen()));
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10.0),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text('Register Now',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                            fontFamily: 'Poppins')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
