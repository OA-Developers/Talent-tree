import 'package:flutter/material.dart';

class OpeningDetailsScreen extends StatefulWidget {
  const OpeningDetailsScreen({super.key});

  @override
  State<OpeningDetailsScreen> createState() => _OpeningDetailsScreenState();
}

class _OpeningDetailsScreenState extends State<OpeningDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Opening Details"),
          leading: IconButton(
            onPressed: () {Navigator.of(context).pop();},
            icon: Icon(Icons.arrow_back),
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
                      const Text("Male casting intern Male casting intern Male",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("TT In House",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_pin),
                          const Text("Mumbai")
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
            const Expanded(
              child: Text(
                  "Male cating intern male casting intern male casting intern male casting intern male casting intern male casting intern male casting intern male casting intern male casting internmale casting intern"),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
