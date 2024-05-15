import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';

class Integration extends ChangeNotifier {
  bool isLoading = false;
  String message = '';
  bool success = false;
  String? _token; // Added variable to store the token

  // Getter for token
  String? get token => _token;

  Future<void> send(User user, BuildContext context,
      {required Function onSuccess}) async {
    isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Read token
    _token = prefs.getString('token');
    print(_token);

    try {
      // Perform the API request to create the vendor
      final dio = Dio();

      // Log request details
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

      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: user.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Include the bearer token
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle the API response based on success field
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        success =
            responseData['success']; // Check for the actual 'success' field
        message = responseData['message'];
        print(response.data);

        isLoading = false;
        notifyListeners();
        print(success);
        if (success) {
          onSuccess();
        }
      } else {
        isLoading = false;
        notifyListeners();
        if (!success) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Wallet Assigned',
              message: 'The wallet number has already been assigned',
            ),
          );
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Wallet Assigned',
          message: 'The wallet number has already been assigned',
        ),
      );
      // Include error message in case of exception
    }
  }
}
