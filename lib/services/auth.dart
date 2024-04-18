import 'package:agent_app/model/td.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  bool _isLoading = false;
  String user_id ='';
  String token =
      'oYA3AijAoQ1Qt8K37cZWOmAYJqEDWhFhE0n5d3iKav5qAvhbQex1zPremUqyCPBBaS96rwGATCZJqDs5DRrLJljIAXQ7MgNG1Kmlc12IG8yMZ2HXqExuvwgEuGENbdjvEfKnABg8cer45UHhxgqCO18Fo5nakFZQpPYpWxUghhQOepkTGN2p';

  Future<bool> send(TD td) async {
    _isLoading = true;
    notifyListeners();

    final dio = Dio();
    try {
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/login',
        data: td.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      _isLoading = false;
      notifyListeners();
      if (response.statusCode == 201) {
        String token = response.data['token'];
        user_id = response.data['user']['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        token = token;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      _isLoading = false;
      print(e);
      notifyListeners();
      return false;
    }
  }
}
