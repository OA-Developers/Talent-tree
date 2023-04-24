import 'package:flutter/material.dart';
import 'package:talent_tree/pages/debate_details_screen.dart';

class DebatePage extends StatefulWidget {
  const DebatePage({super.key});

  @override
  State<DebatePage> createState() => _DebatePageState();
}

class _DebatePageState extends State<DebatePage> {
  final List<Map<String, String>> items = [
    {
      'title': 'Debate 1',
      'description': 'This is the description for Debate 1',
      'videoUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1561489396-888724a1543d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    },
    {
      'title': 'Debate 2',
      'description': 'This is the description for Debate 2',
      'videoUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1561489396-888724a1543d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    },
    {
      'title': 'Debate 3',
      'description': 'This is the description for Debate 3',
      'videoUrl':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'thumbnail':
          'https://images.unsplash.com/photo-1561489396-888724a1543d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DebateDetailsScreen(
                          videoUrl: items[index]['videoUrl']!,
                          description: items[index]['description']!,
                        ),
                      ));
                }),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Image.network(
                          items[index]['thumbnail']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          items[index]['title']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
