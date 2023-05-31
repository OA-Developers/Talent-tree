import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:talent_tree/pages/opening_list_screen.dart';
import 'package:talent_tree/utils/constants.dart';

class AudiencePage extends StatefulWidget {
  const AudiencePage({Key? key});

  @override
  State<AudiencePage> createState() => _AudiencePageState();
}

class _AudiencePageState extends State<AudiencePage> {
  String? tvBanner;
  String? webBanner;
  String? adBanner;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseURL}settings'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          tvBanner = '${Constants.baseURL}files/${jsonData['tvBanner']}';
          webBanner = '${Constants.baseURL}files/${jsonData['webBanner']}';
          adBanner = '${Constants.baseURL}files/${jsonData['adBanner']}';
        });
      } else {
        setState(() {
          tvBanner = null;
          webBanner = null;
          adBanner = null;
        });
        print('Failed to fetch category image');
      }
    } catch (e) {
      setState(() {
        tvBanner = null;
        webBanner = null;
        adBanner = null;
      });
      print('Failed to fetch category image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audition')),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      color: const Color.fromARGB(255, 28, 28, 39),
                      child: InkWell(
                        onTap: () {
                          // Perform action when TV Shows tile is tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OpeningListScreen(
                                category: 'tv',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              image: tvBanner != null
                                  ? DecorationImage(
                                      image: NetworkImage(tvBanner!),
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/tv_shows_banner.png',
                                      ),
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
                      color: const Color.fromARGB(255, 28, 28, 39),
                      child: InkWell(
                        onTap: () {
                          // Perform action when Movies tile is tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OpeningListScreen(
                                category: 'web',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              image: webBanner != null
                                  ? DecorationImage(
                                      image: NetworkImage(webBanner!),
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/movie_banner.png',
                                      ),
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
                      color: const Color.fromARGB(255, 28, 28, 39),
                      child: InkWell(
                        onTap: () {
                          // Perform action when Web & Ads tile is tapped.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OpeningListScreen(
                                category: 'ads',
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              image: adBanner != null
                                  ? DecorationImage(
                                      image: NetworkImage(adBanner!),
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/ad_shoot_banner.png',
                                      ),
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
