import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talent_tree/pages/debate_details_screen.dart';
import 'package:talent_tree/utils/constants.dart';

class DebatePage extends StatefulWidget {
  const DebatePage({Key? key}) : super(key: key);

  @override
  State<DebatePage> createState() => _DebatePageState();
}

class DebateData {
  final String title;
  final String description;
  final String type;
  final String videoUrl;
  final String thumbnailUrl;

  DebateData({
    required this.title,
    required this.description,
    required this.type,
    required this.videoUrl,
    required this.thumbnailUrl,
  });
}

class _DebatePageState extends State<DebatePage> {
  List<DebateData> _debates = [];

  @override
  void initState() {
    super.initState();

    _fetchDebates();
  }

  Future<void> _fetchDebates() async {
    final response = await http.get(Uri.parse('${Constants.baseURL}debates'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<DebateData> debates = [];
      print(data);

      for (final debate in data) {
        debates.add(
          DebateData(
            title: debate['title'],
            description: debate['description'],
            type: debate['type'],
            videoUrl: '${Constants.baseURL}${debate['videoUrl']}',
            thumbnailUrl: '${Constants.baseURL}${debate['thumbnailUrl']}',
          ),
        );
      }

      setState(() {
        _debates = debates;
      });
    } else {
      throw Exception('Failed to fetch banners');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Debates')),
      body: ListView.builder(
        itemCount: _debates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DebateDetailsScreen(
                    title: _debates[index].title,
                    description: _debates[index].description,
                    type: _debates[index].type,
                    videoUrl: _debates[index].videoUrl,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      _debates[index].thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      _debates[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
