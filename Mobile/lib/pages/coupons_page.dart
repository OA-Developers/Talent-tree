import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talent_tree/pages/subscription_page.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:talent_tree/widgets/action_button.dart';
import 'package:http/http.dart' as http;

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
      appBar: AppBar(
        title: Text('Coupons'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
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
                    height: 25,
                  ),
                  const Text(
                    'Apply Coupon Here',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _couponController,
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
                          backgroundColor: Colors.grey.shade400,
                          textColor: Colors.black54,
                          text: "SKIP",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SubscriptionPage(
                                          discount: 0,
                                        )));
                          }),
                      ActionButton(
                        height: 50,
                        width: 150,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        text: "APPLY",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final code = _couponController.text.trim();
                              final response = await http.post(
                                Uri.parse('${Constants.baseURL}apply-coupon'),
                                body: {'code': code},
                              );
                              if (response.statusCode == 200) {
                                final discount =
                                    jsonDecode(response.body)['discount'];
                                showSnackBar(
                                    context, 'Coupon Applied Successfully.');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SubscriptionPage(
                                          discount: int.parse(discount))),
                                );
                              } else if (response.statusCode == 400) {
                                final msg = json.decode(response.body)['msg'];
                                showSnackBar(context, msg);
                              } else {
                                throw Exception('Failed to apply coupon');
                              }
                            } catch (error) {
                              showSnackBar(context, 'Error applying coupon');
                              print(error);
                            }
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
