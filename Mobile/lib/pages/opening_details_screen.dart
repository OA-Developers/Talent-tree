import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_tree/models/user.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;
import 'dart:io';

class OpeningDetailsScreen extends StatefulWidget {
  final String title;
  final String source;
  final String description;
  final String location;
  final String whatsapp;
  final String imgUrl;
  final String email;

  const OpeningDetailsScreen({
    Key? key,
    required this.title,
    required this.source,
    required this.description,
    required this.location,
    required this.whatsapp,
    required this.imgUrl,
    required this.email,
  }) : super(key: key);

  @override
  _OpeningDetailsScreenState createState() => _OpeningDetailsScreenState();
}

class _OpeningDetailsScreenState extends State<OpeningDetailsScreen> {
  Map<String, dynamic>? userRegistration;
  late User user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    _getUserRegistration();
  }

  Future<Map<String, dynamic>> fetchUserRegistration() async {
    final String apiUrl =
        '${Constants.baseURL}getUserRegistration?userId=${user.id}';
    print(apiUrl);

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch user registration');
      }
    } catch (error) {
      throw Exception('Failed to fetch user registration: $error');
    }
  }

  Future<void> _getUserRegistration() async {
    try {
      final registrationData = await fetchUserRegistration();
      setState(() {
        userRegistration = registrationData['userRegistration'][0];
      });
    } catch (error) {
      print(error.toString());
    }
  }

  String getEmailBody() {
    if (userRegistration != null) {
      final StringBuilder = StringBuffer();

      final fullName = userRegistration!['fullName'];
      final gender = userRegistration!['gender'];
      final email = userRegistration!['email'];
      final mobile = userRegistration!['mobile'];
      final dob = userRegistration!['dob'];
      final state = userRegistration!['state'];
      final district = userRegistration!['district'];
      final city = userRegistration!['city'];
      final currentCity = userRegistration!['currentCity'];
      final height = userRegistration!['height'];
      final experience = userRegistration!['experience'];

      StringBuilder.writeln('Job Title: ${widget.title}');
      StringBuilder.writeln('Name: $fullName');
      StringBuilder.writeln('Gender: $gender');
      StringBuilder.writeln('Email: $email');
      StringBuilder.writeln('Mobile: $mobile');
      StringBuilder.writeln('Date of Birth: $dob');
      StringBuilder.writeln('State: $state');
      StringBuilder.writeln('District: $district');
      StringBuilder.writeln('City: $city');
      StringBuilder.writeln('Current City: $currentCity');
      StringBuilder.writeln('Height: $height');
      StringBuilder.writeln('Experience: $experience');

      return StringBuilder.toString();
    } else {
      return 'User registration data not available';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opening Details"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      widget.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.source,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.location_pin),
                            Text(widget.location),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "Job Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(widget.description),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          backgroundColor: Color.fromARGB(255, 34, 147, 212),
                        ),
                        onPressed: () async {
                          String email = Uri.encodeComponent(widget.email);
                          String subject = Uri.encodeComponent("Hello Sir");
                          String body = Uri.encodeComponent(getEmailBody());
                          Uri mail = Uri.parse(
                              "mailto:$email?subject=$subject&body=$body");
                          try {
                            await launchUrl(mail);
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                        },
                        child: const Text(
                          "Apply Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.wechat_sharp,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          primary: Colors.green.shade800,
                        ),
                        onPressed: () async {
                          final contact = '+91${widget.whatsapp}';
                          final androidUrl =
                              'whatsapp://send?phone=$contact&text=Hey There';
                          final iosUrl =
                              'https://wa.me/$contact?text=${Uri.parse('Hey, There')}';

                          try {
                            if (Platform.isIOS) {
                              await launchUrl(Uri.parse(iosUrl));
                            } else {
                              await launchUrl(Uri.parse(androidUrl));
                            }
                          } on Exception {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('WhatsApp is not installed.'),
                              ),
                            );
                          }
                        },
                        label: const Text(
                          "WhatsApp",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
