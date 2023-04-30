import 'dart:convert';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:talent_tree/models/user.dart";
import "package:http/http.dart" as http;
import 'package:talent_tree/pages/main_screen.dart';
import 'package:talent_tree/providers/user_provider.dart';
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );
      http.Response res = await http.post(
        Uri.parse('${Constants.baseURL}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created! Login to continue!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void siginUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
          Uri.parse('${Constants.baseURL}/api/signin'),
          body: jsonEncode({'email': email, password: password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: ((context) => MainScreen()),
              ),
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
