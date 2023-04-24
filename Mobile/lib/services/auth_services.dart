import "package:flutter/material.dart";
import "package:talent_tree/models/user.dart";
import "package:http/http.dart" as http;
import 'package:talent_tree/utils/constants.dart';
import 'package:talent_tree/utils/utils.dart';

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
}
