import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UserService {
  UserService();

  static const baseUrl = 'reqres.in';

  Future<void> register(String email, String username, String password) async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw LoginFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.https(baseUrl, '/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      throw LoginFailure();
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<void> logout() async {
    final response = await http.post(Uri.https(baseUrl, '/api/logout'));
    if (response.statusCode != 200) {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
      throw LogoutFailure();
    }
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
  }


}

class LoginFailure implements Exception {}

class LogoutFailure implements Exception {}
