import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TD {
  final String email;
  final String password;
  

  TD({
    required this.email,
    required this.password,
   
  });

  factory TD.fromJson(Map<String, dynamic> json) {
    return TD(
      email: json['email'],
      password: json['password'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

