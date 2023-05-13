import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_tree/pages/opening_details_screen.dart';
import 'package:talent_tree/utils/constants.dart';

class OpeningListScreen extends StatefulWidget {
  final String category;
  const OpeningListScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<OpeningListScreen> createState() => _OpeningListScreenState();
}

class _OpeningListScreenState extends State<OpeningListScreen> {
  late Future<List<dynamic>> _futureOpenings;

  Future<List<dynamic>> fetchOpenings(String category) async {
    final response = await http
        .get(Uri.parse('${Constants.baseURL}openings?category=$category'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to fetch openings');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureOpenings = fetchOpenings(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Openings'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureOpenings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final opening = snapshot.data![index];

                return Card(
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
                                  whatsapp: opening['whatsAppNumber'],
                                  source: opening['source'],
                                )),
                      );
                    },
                    leading: SizedBox(
                      width: 60,
                      child: Image.network(
                        '${Constants.baseURL}${opening['imageUrl']}',
                        fit: BoxFit.cover,
                      ),
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
                            Text(opening['time'].toString().substring(0, 10)),
                            const SizedBox(width: 8),
                            const Icon(Icons.access_time),
                            const SizedBox(width: 4),
                            Text(opening['time'].toString().substring(11, 16)),
                            const SizedBox(width: 8),
                            const Icon(Icons.location_on),
                            const SizedBox(width: 4),
                            Text(opening['location']),
                          ],
                        ),
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
    );
  }
}
