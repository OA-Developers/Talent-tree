import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talent_tree/pages/opening_list_screen.dart';

class AudiencePage extends StatefulWidget {
  const AudiencePage({Key? key});

  @override
  State<AudiencePage> createState() => _AudiencePageState();
}

class _AudiencePageState extends State<AudiencePage> {
  List<String> _imageUrls = [
    'https://picsum.photos/500/150',
    'https://picsum.photos/500/150?grayscale',
    'https://picsum.photos/500/150?blur=2',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // Perform action when TV Shows tile is tapped.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OpeningListScreen(),
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/tv.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.tv,
                                      size: 48.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 16.0),
                                    Text("TV Shows",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // Perform action when Movies tile is tapped.
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/movies.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.movie,
                                        size: 48.0, color: Colors.white),
                                    SizedBox(height: 16.0),
                                    Text("Movies",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          // Perform action when Movies tile is tapped.
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/web.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.web,
                                        size: 48.0, color: Colors.white),
                                    SizedBox(height: 16.0),
                                    Text("Web & Ads",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
