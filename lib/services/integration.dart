import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';
import '../pages/home_page.dart';

class Integration extends ChangeNotifier {
  bool isLoading = false;

  Future<bool> send(User user) async {
    isLoading = true;
    notifyListeners();

    final dio = Dio();
    
    print('Sending request...');
    
    try {
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: user.toJson(),
      );
      
      print('Received response');
      print("Response status code: ${response.statusCode}");

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
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
