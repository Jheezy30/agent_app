import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';
import '../pages/home_page.dart';

class Integration extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> send(User user) async {
    isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Read token
    String? token = prefs.getString('token');

    final dio = Dio();

    print('Sending request...');
    print(token);

    try {

      print('Request Method: POST');
      print('Request Headers: ${dio.options.headers}');
      print('Request Data: ${user.toJson()}');
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: user.toJson(),
        options: Options(
          headers: {
            'Authorization':  'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Received response');
      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');

      isLoading = false;
      notifyListeners();

      return false;
    }
  }

}
