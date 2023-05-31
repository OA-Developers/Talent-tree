import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:talent_tree/pages/opening_details_screen.dart';
import 'package:talent_tree/utils/constants.dart';

class OpeningListScreen extends StatefulWidget {
  final String category;

  const OpeningListScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _OpeningListScreenState createState() => _OpeningListScreenState();
}

class _OpeningListScreenState extends State<OpeningListScreen> {
  late Future<List<dynamic>> _futureOpenings;
  var pageTitle = "Serial Audition";

  Future<List<dynamic>> fetchOpenings(String category) async {
    try {
      final response = await http
          .get(Uri.parse('${Constants.baseURL}openings?category=$category'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception(
            'Failed to fetch openings with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch openings: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureOpenings = fetchOpenings(widget.category);
    pageTitle = (widget.category == "ads")
        ? "Ad Audition"
        : (widget.category == "web")
            ? "Web / Movie Audition"
            : "Serial Audition";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
          future: _futureOpenings,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(color: Colors.black),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final opening = snapshot.data![index];

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OpeningDetailsScreen(
                              title: opening['title'],
                              description: opening['description'],
                              location: opening['location'],
                              email: opening['email'],
                              imgUrl:
                                  '${Constants.baseURL}${opening['imageUrl']}',
                              whatsapp: opening['whatsAppNumber'],
                              source: opening['source'],
                            ),
                          ),
                        );
                      },
                      leading: SizedBox(
                        width: 60,
                        child: Image.network(
                            '${Constants.baseURL}${opening['imageUrl']}',
                            fit: BoxFit.cover),
                      ),
                      title: Text(opening['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(opening['description']),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(width: 4),
                              Text(
                                opening['time'].toString().substring(0, 10),
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.access_time),
                              const SizedBox(width: 4),
                              Text(
                                opening['time'].toString().substring(11, 16),
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 4),
                            Text(
                              opening['location'],
                              style: TextStyle(color: Colors.black),
                            ),
                          ])
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
