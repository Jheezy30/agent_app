import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';
import '../pages/home_page.dart';


class Integration {
  final BuildContext context;
  final User user;
  final VoidCallback setState;

  Integration({required this.context, required this.user, required this.setState});

  void send() async {
    setState();
    final dio = Dio();
    try {
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Operation Failed',
            message: 'The operation was not successful.',
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Operation Failed',
          message: 'An error occurred while performing the operation.',
        ),
      );
    } finally {
      setState();
    }
  }
}