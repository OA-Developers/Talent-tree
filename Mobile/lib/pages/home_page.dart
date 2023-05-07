import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:talent_tree/pages/registration_screen.dart';
import 'package:http/http.dart' as http;
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/widgets/video_player.dart';
import 'package:talent_tree/widgets/video_thumbnail.dart';

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

  @override
  void initState() {
    super.initState();

    _fetchBanners();
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
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                ),
                const SizedBox(height: 25),
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
                    viewportFraction: 1.0,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegistrationScreen()));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: const Text('Register Now',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          fontFamily: 'Poppins')),
                ),
                const SizedBox(height: 25),
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Text("About Us",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Talent Tree is an innovative application that aims to revolutionize the casting process in the entertainment industry by connecting casting directors and actors directly. Our platform provides a streamlined and user-friendly experience for both casting directors and actors, making the process of casting for productions faster and more efficient.\n\nFor actors, Talent Tree offers a unique opportunity to showcase their talent and get noticed by casting directors. Our platform allows actors to easily upload their audition tapes, headshots, resumes, and other relevant information. This ensures that their profile is always up-to-date and accessible to casting directors who are looking for new talent.\n\nFor casting directors, Talent Tree provides a centralized database of actors that can be easily searched and filtered based on specific criteria such as age range, gender, location, and skill set. This saves valuable time and resources, and ensures that casting directors can find the best actors for their productions quickly and efficiently.\n\nOne of the most significant advantages of Talent Tree is that it enables casting directors to view audition tapes of actors remotely, which is especially beneficial in today's climate where virtual casting has become the norm. This allows casting directors to cast actors from anywhere in the world, without having to physically meet them in person.\n\nAt Talent Tree, we pride ourselves on our commitment to promoting diversity and inclusivity in the entertainment industry. We believe that everyone deserves a chance to showcase their talent, regardless of their background or identity. With Talent Tree, we aim to create a level playing field for actors of all backgrounds and provide them with an equal opportunity to succeed.\n\nOverall, Talent Tree is a game-changer for the entertainment industry, providing a much-needed solution for actors and casting directors alike. Whether you're an aspiring actor looking to jumpstart your career or a casting director searching for the perfect talent, Talent Tree is the platform for you.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                )
              ]),
        ),
      ),
    ));
  }
}
