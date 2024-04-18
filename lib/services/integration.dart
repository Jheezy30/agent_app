import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';
import '../pages/home_page.dart';

class Integration extends ChangeNotifier {
  // Integration();Integration

  bool _isLoading = false;


  Future<bool> send(User user) async {
    _isLoading = true;
    notifyListeners();


    final dio = Dio();
    try {
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: user.toJson(),


      );

      _isLoading = false;
      notifyListeners();
       print("Response status code: ${response.statusCode}");
      if (response.statusCode == 201) {

        return true;
      } else {
       

        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
