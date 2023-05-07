import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class SubscriptionCard extends StatelessWidget {
  final String duration;
  final String discountedPrice;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;

  const SubscriptionCard(
      {super.key,
      required this.duration,
      required this.discountedPrice,
      required this.price,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade700,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black54),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 150,
          height: 175,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              Text(
                '₹ $discountedPrice',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              Text(
                '₹ $price',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black54),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5))),
                child: Text(
                  buttonText,
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionPageState extends State<SubscriptionPage> {
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubscriptionCard(
                          duration: "1 Month",
                          discountedPrice: "49",
                          price: "150",
                          buttonText: "Subscribe",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SubscriptionCard(
                          duration: "3 Month",
                          discountedPrice: "149",
                          price: "350",
                          buttonText: "Subscribe",
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubscriptionCard(
                          duration: "6 Month",
                          discountedPrice: "249",
                          price: "450",
                          buttonText: "Subscribe",
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SubscriptionCard(
                          duration: "1 Year",
                          discountedPrice: "449",
                          price: "850",
                          buttonText: "Subscribe",
                          onPressed: () {},
                        ),
                      ],
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
