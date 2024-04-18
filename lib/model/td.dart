import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TD {
  final String username;
  final String password;

  TD({
    required this.username,
    required this.password,
  });

  factory TD.fromJson(Map<String, dynamic> json) {
    return TD(
      username: json['username'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson(){
    return{
       'username' : username,
    'password' : password,
    };
  
  }
}
