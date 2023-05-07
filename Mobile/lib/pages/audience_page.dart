import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:talent_tree/pages/opening_list_screen.dart';

class AudiencePage extends StatefulWidget {
  const AudiencePage({Key? key});

  @override
  State<AudiencePage> createState() => _AudiencePageState();
}

class _AudiencePageState extends State<AudiencePage> {
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
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 28, 28, 39),
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
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/tv_shows_banner.png'),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 28, 28, 39),
                      child: InkWell(
                        onTap: () {
                          // Perform action when Movies tile is tapped.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OpeningListScreen(),
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/movie_banner.png'),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 28, 28, 39),
                      child: InkWell(
                        onTap: () {
                          // Perform action when Web & Ads tile is tapped.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OpeningListScreen(),
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/ad_shoot_banner.png'),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(8),
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
