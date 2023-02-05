import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserService {
  UserService();

  static const baseUrl = 'reqres.in';

  Future<void> register(String email,String username,String password) async {

    final response = await http.post(
      Uri.https(baseUrl,'/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    if(response.statusCode != 200){
      throw UserRequestFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> login(String email,String username,String password) async {

    final response = await http.post(
      Uri.https('reqres.in','/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    if(response.statusCode != 200){
      throw UserRequestFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }
}

class UserRequestFailure implements Exception {}









