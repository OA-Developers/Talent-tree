// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_tree/pages/login_screen.dart';

import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';

class SubscriptionPage extends StatefulWidget {
  final int discount;
  const SubscriptionPage({
    Key? key,
    required this.discount,
  }) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class SubscriptionCard extends StatelessWidget {
  final String duration;
  final String discountedPrice;
  final String price;
  final String buttonText;
  final BuildContext context;

  const SubscriptionCard({
    Key? key,
    required this.duration,
    required this.discountedPrice,
    required this.price,
    required this.buttonText,
    required this.context,
  }) : super(key: key);

  void _subscribePlan() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');
      if (token == null) {
        // Handle case where user is not authenticated
        // Show login screen
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        return;
      }
      final url = Uri.parse('${Constants.baseURL}subscribe');
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      };
      final body = <String, dynamic>{
        'duration': 30
      }; // replace with the desired duration in days
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        // subscription successful
        showSnackBar(context, jsonDecode(response.body)['msg']);
      } else {
        // handle error
        showSnackBar(context, jsonDecode(response.body)['msg']);
      }
    } catch (e) {
      // handle error
      print('Failed to subscribe to the plan. Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade700,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              Text(
                '₹ $discountedPrice',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              Text(
                '₹ $price',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 150, // set the desired width
                child: ElevatedButton(
                  onPressed: () {
                    if (int.parse(discountedPrice) == 0) {
                      _subscribePlan();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black54),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlanData {
  final String price;
  final String mrp;
  final int duration;

  PlanData({required this.price, required this.mrp, required this.duration});
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<PlanData> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _fetchPlans();
  }

  Future<void> _fetchPlans() async {
    final response = await http.get(Uri.parse('${Constants.baseURL}plans'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<PlanData> plans = [];
      print(data);

      for (final plan in data) {
        plans.add(
          PlanData(
              price: plan['price'],
              mrp: plan['mrp'],
              duration: plan['duration']),
        );
      }

      setState(() {
        _subscriptions = plans;
      });
    } else {
      throw Exception('Failed to fetch banners');
    }
  }

  String convertDays(int numDays) {
    int years = (numDays / 365).floor();
    int remainingDays = numDays % 365;
    int months = (remainingDays / 30).floor();
    remainingDays %= 30;
    String output = '';
    if (years > 0) {
      output += '$years Year${years > 1 ? 's' : ''}';
    }
    if (months > 0) {
      if (years > 0) {
        output += ' ';
      }
      output += '$months Month${months > 1 ? 's' : ''}';
    }
    if (remainingDays > 0) {
      if (years > 0 || months > 0) {
        output += ' ';
      }
      output += '$remainingDays Day${remainingDays > 1 ? 's' : ''}';
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Audience Subscription",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Subscription",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "•  We provide audition updates on daily basis",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "• We will help you how to make good auditions",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "• Interaction with casting directors",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "• Helping grooming yourself through our courses",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "• Talenttree will help you to work in different states.",
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Add a GridView or any other widgets here
                    const SizedBox(height: 25),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _subscriptions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final subscription = _subscriptions[index];
                        int finalPriceInt = int.parse(subscription.price);
                        final discountBy = widget.discount;
                        if (discountBy > 0) {
                          finalPriceInt -=
                              (finalPriceInt * discountBy / 100).round();
                        }

                        return SubscriptionCard(
                            duration: convertDays(subscription.duration),
                            discountedPrice: finalPriceInt.toString(),
                            context: context,
                            price: subscription
                                .mrp, // Replace with actual price data
                            buttonText: 'Subscribe');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
