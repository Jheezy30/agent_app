import 'dart:convert';
import 'package:agent_app/model/td.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  bool isLoading = false;
  String token = '';
  String user_id = '';

  Future<bool> login(TD td) async {
    isLoading = true;
    notifyListeners();

    var basicAuth =
        'Basic ' + base64Encode(utf8.encode('${td.username}:${td.password}'));

    try {
      final dio = Dio();
      Response response = await dio.post(
          'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/login',
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

        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
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
