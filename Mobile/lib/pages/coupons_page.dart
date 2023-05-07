import 'package:flutter/material.dart';
import 'package:talent_tree/pages/subscription_page.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:talent_tree/widgets/action_button.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  final _formKey = GlobalKey<FormState>();
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Apply Coupon Here',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black54,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter a coupon',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a coupon';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ActionButton(
                          height: 50,
                          width: 150,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          text: "SKIP",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SubscriptionPage()));
                          }),
                      ActionButton(
                          height: 50,
                          width: 150,
                          backgroundColor: Colors.indigoAccent.shade400,
                          textColor: Colors.white,
                          text: "APPLY",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showSnackBar(
                                  context, 'Coupon Applied Successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SubscriptionPage(),
                                ),
                              );
                            }
                          })
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
