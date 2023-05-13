import 'package:flutter/material.dart';
import 'package:talent_tree/utils/utils.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class OpeningDetailsScreen extends StatefulWidget {
  final String title;
  final String source;
  final String description;
  final String location;
  final String whatsapp;
  final String email;
  const OpeningDetailsScreen({
    Key? key,
    required this.title,
    required this.source,
    required this.description,
    required this.location,
    required this.whatsapp,
    required this.email,
  }) : super(key: key);

  @override
  State<OpeningDetailsScreen> createState() => _OpeningDetailsScreenState();
}

class _OpeningDetailsScreenState extends State<OpeningDetailsScreen> {
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
          )),
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
                  child: Image.asset("assets/images/tv.jpeg"),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.source,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_pin),
                          Text(widget.location)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Job Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(widget.description),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  Expanded(
                      child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff0a2647)),
                    ),
                    onPressed: () async {
                      final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: widget.email,
                          queryParameters: {
                            'subject': 'Talent Tree',
                            'body': 'Talent Tree'
                          });
                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        throw 'Could not launch email client';
                      }
                    },
                    child: const Text("Apply Now",
                        style: TextStyle(color: Colors.white)),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextButton.icon(
                    icon: const Icon(
                      Icons.whatsapp,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade800),
                    ),
                    onPressed: () async {
                      var contact = '+91${widget.whatsapp}';
                      var androidUrl =
                          "whatsapp://send?phone=$contact&text=Hey There";
                      var iosUrl =
                          "https://wa.me/$contact?text=${Uri.parse('Hey, There')}";

                      try {
                        if (Platform.isIOS) {
                          await launchUrl(Uri.parse(iosUrl));
                        } else {
                          await launchUrl(Uri.parse(androidUrl));
                        }
                      } on Exception {
                        showSnackBar(context, 'WhatsApp is not installed.');
                      }
                    },
                    label: const Text("WhatsApp",
                        style: TextStyle(color: Colors.white)),
                  )),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
