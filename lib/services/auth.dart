import 'dart:convert';

import 'package:agent_app/components/custom_alert_dialogue.dart';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/vendors_page.dart';
import 'Apis.dart';

class Auth extends ChangeNotifier {
  bool isLoading = false;
  String token = '';
  String user_id = '';
  bool isResetting = false;

  Future<void> login(TD td, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    var basicAuth =
        'Basic ' + base64Encode(utf8.encode('${td.email}:${td.password}'));

    try {
      final dio = Dio();
      Response response = await dio.post(Apis.login,
          data: td.toJson(),
          options: Options(headers: {'Authorization': basicAuth}));

      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.data);
        user_id = response.data['data']['user']['id'];
        print(user_id);

        token = response.data['data']['bearer_token'];
        print(token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        isLoading = false;
        notifyListeners();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Invalid Credentials',
            message:
            'Please check your username and password and try again.',
          ),
        );
      }
    } catch (e) {

      isLoading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Operation failed',
          message: 'The operation was not successful',
        ),
      );
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    isResetting = true;
    notifyListeners();


    final dio = Dio();
    final data = {
      'email': email,
    };
    final jsonData = jsonEncode(data);
    print(jsonData);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request URL: ${options.uri}');
          print('Request Headers: ${options.headers}');
          print('Request Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response Status: ${response.statusCode}');
          print('Response Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('Error: $error');
          return handler.next(error);
        },
      ),
    );

    try {
      Response response = await dio.post(
        Apis.resetPassword,
        data: jsonData,
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        isResetting = false;
        notifyListeners();
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Success',
            message: 'Password reset link sent successfully',
          ),
        );
      } else {
        isResetting = false;
        notifyListeners();
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Operation failed',
            message: 'The operation was not successful',
          ),
        );
      }
    } catch (e) {
      isResetting = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Operation failed',
          message: 'The operation was not successful',
        ),
      );
    }
  }

  Future<void> logout() async {
    token = '';
    user_id = ''; // Clear user ID as well
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id'); // Remove user ID storage
    // ... notify listeners about logout ...
  }
}
