import 'dart:convert';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:talent_tree/models/user.dart";
import "package:http/http.dart" as http;
import 'package:talent_tree/pages/main_screen.dart';
import 'package:talent_tree/pages/register_screen.dart';
import 'package:talent_tree/pages/splash_screen.dart';
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
          profileImage: '');
      http.Response res = await http.post(
        Uri.parse('${Constants.baseURL}api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            siginUser(context: context, email: email, password: password);
            showSnackBar(context, 'Logged In');
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
          Uri.parse('${Constants.baseURL}api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
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
                builder: ((context) => SplashScreen()),
              ),
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.baseURL}tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        var userRes = await http.get(
          Uri.parse('${Constants.baseURL}getUser'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        var jsonResponse = jsonDecode(userRes.body);
        print(jsonResponse);
        // var user = jsonResponse['user'];
        userProvider.setUser(userRes.body);
        userProvider.setIsSubscrbed(jsonResponse['isSubscribed']);
        userProvider.setIsRegistered(jsonResponse['isRegistered']);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const RegisterScreen()),
        (route) => false);
  }
}
