import 'package:flutter/material.dart';
import 'package:talent_tree/pages/opening_details_screen.dart';

class OpeningListScreen extends StatefulWidget {
  const OpeningListScreen({super.key});

  @override
  State<OpeningListScreen> createState() => _OpeningListScreenState();
}

class _OpeningListScreenState extends State<OpeningListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Openings'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OpeningDetailsScreen()));
              }),
              leading: SizedBox(
                width: 60,
                child: Image.network(
                  'https://picsum.photos/150',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('Title $index'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('Description $index'),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.date_range),
                      SizedBox(width: 4),
                      Text('10-04-2023'),
                      SizedBox(width: 8),
                      Icon(Icons.access_time),
                      SizedBox(width: 4),
                      Text('10:00 AM'),
                      SizedBox(width: 8),
                      Icon(Icons.location_on),
                      SizedBox(width: 4),
                      Text('10:00 AM'),
                    ],
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
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class OpeningListScreen extends StatefulWidget {
//   const OpeningListScreen({Key? key});

//   @override
//   State<OpeningListScreen> createState() => _OpeningListScreenState();
// }

// class _OpeningListScreenState extends State<OpeningListScreen> {
//   late Future<List<Opening>> _openingList;

//   @override
//   void initState() {
//     super.initState();
//     _openingList = _fetchOpeningList();
//   }

//   Future<List<Opening>> _fetchOpeningList() async {
//     final response = await http.get(Uri.parse('https://api.example.com/openings'));
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body) as List<dynamic>;
//       return jsonData.map((json) => Opening.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to fetch openings');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TV Openings'),
//       ),
//       body: FutureBuilder<List<Opening>>(
//         future: _openingList,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final opening = snapshot.data![index];
//                 return Card(
//                   child: ListTile(
//                     leading: SizedBox(
//                       width: 60,
//                       child: Image.network(
//                         opening.imageUrl,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     title: Text(opening.title),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 8),
//                         Text(opening.description),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             Icon(Icons.date_range),
//                             SizedBox(width: 4),
//                             Text(opening.date),
//                             SizedBox(width: 8),
//                             Icon(Icons.access_time),
//                             SizedBox(width: 4),
//                             Text(opening.time),
//                             SizedBox(width: 8),
//                             Icon(Icons.location_on),
//                             SizedBox(width: 4),
//                             Text(opening.location),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('${snapshot.error}'),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class Opening {
//   final String title;
//   final String description;
//   final String imageUrl;
//   final String date;
//   final String time;
//   final String location;

//   Opening({
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.date,
//     required this.time,
//     required this.location,
//   });

//   factory Opening.fromJson(Map<String, dynamic> json) {
//     return Opening(
//       title: json['title'] as String,
//       description: json['description'] as String,
//       imageUrl: json['imageUrl'] as String,
//       date: json['date'] as String,
//       time: json['time'] as String,
//       location: json['location'] as String,
//     );
//   }
// }
